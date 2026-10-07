#Requires -Version 7.0
<#
.SYNOPSIS
    Copies the third-party skills listed in vendor.json into skills/ and rebuilds THIRD-PARTY-NOTICES.md.

.DESCRIPTION
    Each vendored skill is fetched from its upstream repository at the commit pinned in vendor.json
    and copied verbatim into skills/<name>. Adapted skills and agents are never touched.

    With -Update, the script fetches the latest commit of each upstream default branch instead,
    copies from there and writes the new commit SHAs back to vendor.json. Review the diff before
    committing.

.PARAMETER Update
    Move every vendored source (or only those in -Repo) to the latest upstream commit.

.PARAMETER Repo
    Limit the run to these upstream repositories, e.g. -Repo dotnet/skills,stripe/ai.

.EXAMPLE
    ./scripts/Sync-Vendored.ps1
    Re-copies every vendored skill from its pinned commit.

.EXAMPLE
    ./scripts/Sync-Vendored.ps1 -Update -Repo dotnet/skills
    Moves dotnet/skills to its latest commit.
#>
[CmdletBinding()]
param(
    [switch] $Update,
    [string[]] $Repo
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$manifestPath = Join-Path $root 'vendor.json'
$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json
$skillsDir = Join-Path $root 'skills'
$licensesDir = Join-Path $root 'licenses'
New-Item -ItemType Directory -Force -Path $licensesDir | Out-Null

# Short temp path: some upstream repos have deep paths that break Windows' 260-char limit.
$work = Join-Path ([IO.Path]::GetTempPath()) "dcv-$PID"
New-Item -ItemType Directory -Force -Path $work | Out-Null

function Invoke-Git {
    param([string] $Dir, [Parameter(ValueFromRemainingArguments)] [string[]] $GitArgs)
    $output = & git -C $Dir -c core.longpaths=true @GitArgs 2>&1
    if ($LASTEXITCODE -ne 0) { throw "git $($GitArgs -join ' ') failed in ${Dir}:`n$output" }
    $output
}

function Get-SkillName([string] $SkillFile) {
    $inFrontmatter = $false
    foreach ($line in Get-Content $SkillFile) {
        if ($line -match '^---\s*$') { if ($inFrontmatter) { break } else { $inFrontmatter = $true; continue } }
        if ($inFrontmatter -and $line -match '^name:\s*[''"]?([^''"]+?)[''"]?\s*$') { return $Matches[1] }
    }
    return $null
}

try {
    $index = 0
    foreach ($source in $manifest.vendored) {
        if ($Repo -and $source.repo -notin $Repo) { continue }
        $index++
        $checkout = Join-Path $work "$index"
        New-Item -ItemType Directory -Force -Path $checkout | Out-Null

        $wanted = if ($Update) { 'HEAD' } else { $source.ref }
        Write-Host "==> $($source.repo) @ $wanted" -ForegroundColor Cyan

        Invoke-Git $checkout init -q | Out-Null
        Invoke-Git $checkout remote add origin "https://github.com/$($source.repo).git" | Out-Null
        Invoke-Git $checkout fetch -q --depth 1 --filter=blob:none origin $wanted | Out-Null
        $sparse = @($source.skills | ForEach-Object { "/$($_.path)/" }) + '/LICENSE*', '/LICENCE*', '/COPYING*'
        Invoke-Git $checkout sparse-checkout set --no-cone @sparse | Out-Null
        Invoke-Git $checkout checkout -q FETCH_HEAD | Out-Null
        $sha = (Invoke-Git $checkout rev-parse HEAD | Select-Object -First 1).Trim()

        foreach ($skill in $source.skills) {
            $from = Join-Path $checkout $skill.path
            if (-not (Test-Path (Join-Path $from 'SKILL.md'))) {
                throw "$($source.repo): no SKILL.md at $($skill.path) (commit $sha)"
            }
            $declared = Get-SkillName (Join-Path $from 'SKILL.md')
            if ($declared -ne $skill.name) {
                Write-Warning "$($source.repo)/$($skill.path) declares name '$declared' but vendor.json says '$($skill.name)'."
            }
            $to = Join-Path $skillsDir $skill.name
            if (Test-Path $to) { Remove-Item -Recurse -Force $to }
            Copy-Item -Recurse -Path $from -Destination $to
            Write-Host "    $($skill.name)"
        }

        $licenseFile = Get-ChildItem -Path $checkout -File |
            Where-Object Name -match '^(LICEN[CS]E|COPYING)' | Select-Object -First 1
        $licenseTarget = Join-Path $licensesDir (($source.repo -replace '/', '__') + '.txt')
        if ($licenseFile) {
            Copy-Item $licenseFile.FullName $licenseTarget -Force
        }
        else {
            $note = if ($source.licenseNote) { $source.licenseNote } else { 'No licence file found upstream.' }
            Set-Content -Path $licenseTarget -Value "$($source.license)`n`n$note`nSource: https://github.com/$($source.repo)/tree/$sha"
        }

        if ($Update -and $source.ref -ne $sha) {
            Write-Host "    ref $($source.ref.Substring(0, 7)) -> $($sha.Substring(0, 7))" -ForegroundColor Yellow
            $source.ref = $sha
        }
    }

    if ($Update) {
        $manifest | ConvertTo-Json -Depth 10 | Set-Content -Path $manifestPath -Encoding utf8NoBOM
    }

    # Rebuild THIRD-PARTY-NOTICES.md from the manifest.
    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add('# Third-party notices')
    $lines.Add('')
    $lines.Add('dotcraft bundles skills and agents written by other people. Each one keeps its original licence.')
    $lines.Add('Licence texts are in [`licenses/`](licenses/). This file is generated by `scripts/Sync-Vendored.ps1`; do not edit it by hand.')
    $lines.Add('')
    $lines.Add('## Copied unchanged')
    $lines.Add('')
    $lines.Add('| Skill | Source | Commit | Licence |')
    $lines.Add('|---|---|---|---|')
    foreach ($source in $manifest.vendored) {
        foreach ($skill in $source.skills) {
            $url = "https://github.com/$($source.repo)/tree/$($source.ref)/$($skill.path)"
            $lines.Add("| ``$($skill.name)`` | [$($source.repo)]($url) | ``$($source.ref.Substring(0, 7))`` | $($source.license) |")
        }
    }
    $lines.Add('')
    $lines.Add('## Adapted for dotcraft')
    $lines.Add('')
    $lines.Add('| Item | Kind | Source | Licence | Changes |')
    $lines.Add('|---|---|---|---|---|')
    foreach ($source in $manifest.adapted) {
        foreach ($item in $source.items) {
            $lines.Add("| ``$($item.name)`` | $($item.kind) | [$($source.repo)](https://github.com/$($source.repo)/tree/$($source.ref)) | $($source.license) | $($item.change) |")
        }
    }
    $lines.Add('')
    $lines.Add('## Companions (installed separately, not included)')
    $lines.Add('')
    foreach ($companion in $manifest.companions) {
        $lines.Add("- **$($companion.name)** ([$($companion.repo)](https://github.com/$($companion.repo)), $($companion.license)): $($companion.reason)")
    }
    Set-Content -Path (Join-Path $root 'THIRD-PARTY-NOTICES.md') -Value $lines -Encoding utf8NoBOM
    Write-Host "Done. Review 'git status' and 'git diff' before committing." -ForegroundColor Green
}
finally {
    Remove-Item -Recurse -Force $work -ErrorAction SilentlyContinue
}
