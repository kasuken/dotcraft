#Requires -Version 7.0
<#
.SYNOPSIS
    Checks that the plugin is well formed: manifests, skills, agents, vendored files and generated Codex agents.

.DESCRIPTION
    Runs locally and in CI. Exits with code 1 when any check fails.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$errors = [System.Collections.Generic.List[string]]::new()
function Fail([string] $Message) { $errors.Add($Message) }

function Get-Frontmatter([string] $Path) {
    $text = (Get-Content $Path -Raw) -replace "`r`n", "`n"
    if ($text -notmatch '(?s)^---\n(.*?)\n---\n') { return $null }
    $block = $Matches[1]
    $result = @{}
    $lines = $block -split "`n"
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^([A-Za-z_-]+):\s*(.*)$') {
            $key = $Matches[1]; $value = $Matches[2]
            if ($value -match '^[>|][-+]?$') {
                # YAML block scalar: collect indented lines.
                $parts = @()
                while ($i + 1 -lt $lines.Count -and $lines[$i + 1] -match '^\s+\S|^\s*$') { $i++; $parts += $lines[$i].Trim() }
                $value = ($parts -join ' ').Trim()
            }
            $result[$key] = $value.Trim().Trim('''"')
        }
    }
    $result
}

# Manifests
$plugin = Get-Content (Join-Path $root '.claude-plugin/plugin.json') -Raw | ConvertFrom-Json
$market = Get-Content (Join-Path $root '.claude-plugin/marketplace.json') -Raw | ConvertFrom-Json
$null = Get-Content (Join-Path $root '.mcp.json') -Raw | ConvertFrom-Json
$entry = $market.plugins | Where-Object name -eq $plugin.name
if (-not $entry) { Fail "marketplace.json has no entry for plugin '$($plugin.name)'" }
elseif ($entry.version -ne $plugin.version) { Fail "Version mismatch: plugin.json $($plugin.version), marketplace.json $($entry.version)" }
if (Test-Path (Join-Path $root 'plugin.json')) { Fail 'Root plugin.json found: it changes how Copilot and Codex load the plugin. Keep only .claude-plugin/plugin.json.' }

# Skills (Agent Skills spec: name matches folder, <= 64 chars, lowercase/digits/hyphens; description 1-1024 chars)
$skillNames = @()
foreach ($dir in Get-ChildItem (Join-Path $root 'skills') -Directory) {
    $skillFile = Join-Path $dir.FullName 'SKILL.md'
    if (-not (Test-Path $skillFile)) { Fail "skills/$($dir.Name): no SKILL.md"; continue }
    $fm = Get-Frontmatter $skillFile
    if (-not $fm) { Fail "skills/$($dir.Name): no frontmatter"; continue }
    if ($fm.name -ne $dir.Name) { Fail "skills/$($dir.Name): name '$($fm.name)' does not match folder" }
    if ($fm.name -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$' -or $fm.name.Length -gt 64) { Fail "skills/$($dir.Name): invalid name" }
    if (-not $fm.description) { Fail "skills/$($dir.Name): missing description" }
    elseif ($fm.description.Length -gt 1024) { Fail "skills/$($dir.Name): description is $($fm.description.Length) chars (max 1024)" }
    $skillNames += $dir.Name
}

# Agents
foreach ($file in Get-ChildItem (Join-Path $root 'agents') -Filter '*.md') {
    $fm = Get-Frontmatter $file.FullName
    $id = $file.Name -replace '(\.agent)?\.md$', ''
    if (-not $fm) { Fail "agents/$($file.Name): no frontmatter"; continue }
    if ($fm.name -ne $id) { Fail "agents/$($file.Name): name '$($fm.name)' must match the file name (Copilot uses the file name as the agent id)" }
    if (-not $fm.description) { Fail "agents/$($file.Name): missing description" }
}

# Vendored skills must exist and must not be edited by hand
$manifest = Get-Content (Join-Path $root 'vendor.json') -Raw | ConvertFrom-Json
$vendoredNames = $manifest.vendored.skills.name
$adaptedSkills = ($manifest.adapted.items | Where-Object kind -eq 'skill').name
foreach ($name in $vendoredNames) {
    if ($name -notin $skillNames) { Fail "vendor.json lists '$name' but skills/$name is missing" }
}
$known = @($vendoredNames) + @($adaptedSkills)
foreach ($source in $manifest.vendored) {
    $licence = Join-Path $root ('licenses/' + ($source.repo -replace '/', '__') + '.txt')
    if (-not (Test-Path $licence)) { Fail "Missing licence file for $($source.repo)" }
}

# Generated Codex agents are up to date
$before = Get-ChildItem (Join-Path $root 'codex/agents') -Filter '*.toml' -ErrorAction SilentlyContinue |
    ForEach-Object { "$($_.Name):$((Get-FileHash $_.FullName).Hash)" }
& (Join-Path $PSScriptRoot 'Export-CodexAgents.ps1') | Out-Null
$after = Get-ChildItem (Join-Path $root 'codex/agents') -Filter '*.toml' |
    ForEach-Object { "$($_.Name):$((Get-FileHash $_.FullName).Hash)" }
if (Compare-Object @($before) @($after)) { Fail 'codex/agents is out of date. Run scripts/Export-CodexAgents.ps1 and commit the result.' }

$own = $skillNames | Where-Object { $_ -notin $known }
Write-Host "Skills: $($skillNames.Count) ($($vendoredNames.Count) vendored, $(@($adaptedSkills).Count) adapted, $(@($own).Count) original)"
Write-Host "Agents: $((Get-ChildItem (Join-Path $root 'agents') -Filter '*.md').Count)"

if ($errors.Count) {
    $errors | ForEach-Object { Write-Host "FAIL $_" -ForegroundColor Red }
    exit 1
}
Write-Host 'All checks passed.' -ForegroundColor Green
