#Requires -Version 7.0
<#
.SYNOPSIS
    Generates Codex custom agents (codex/agents/*.toml) from the Markdown agents in agents/.

.DESCRIPTION
    Claude Code and GitHub Copilot load agents/*.md from the plugin. Codex plugins cannot ship
    agents, so this script converts each Markdown agent to Codex's TOML format. Run it after
    changing an agent; CI fails if the generated files are out of date.

.PARAMETER Install
    Also copy the generated files to ~/.codex/agents so Codex can use them.

.EXAMPLE
    ./scripts/Export-CodexAgents.ps1 -Install
#>
[CmdletBinding()]
param([switch] $Install)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$outDir = Join-Path $root 'codex/agents'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

function ConvertTo-TomlBasicString([string] $Value) {
    '"' + ($Value -replace '\\', '\\' -replace '"', '\"') + '"'
}

$generated = @()
foreach ($file in Get-ChildItem (Join-Path $root 'agents') -Filter '*.md' | Sort-Object Name) {
    $text = (Get-Content $file.FullName -Raw) -replace "`r`n", "`n"
    if ($text -notmatch '(?s)^---\n(.*?)\n---\n(.*)$') { throw "$($file.Name): missing frontmatter" }
    $frontmatter = $Matches[1]
    $body = $Matches[2].Trim()

    $name = if ($frontmatter -match '(?m)^name:\s*(.+?)\s*$') { $Matches[1].Trim('''"') } else { throw "$($file.Name): no name" }
    $description = if ($frontmatter -match '(?m)^description:\s*(.+?)\s*$') { $Matches[1].Trim('''"') } else { throw "$($file.Name): no description" }
    $readOnly = $frontmatter -match '(?m)^tools:' -and $frontmatter -notmatch '(?m)^tools:.*\b(Edit|Write)\b'
    if ($body.Contains("'''")) { throw "$($file.Name): body contains ''' which TOML literal strings cannot hold" }

    $codexName = $name -replace '-', '_'
    $toml = @(
        "# Generated from agents/$($file.Name) by scripts/Export-CodexAgents.ps1. Do not edit."
        "name = $(ConvertTo-TomlBasicString $codexName)"
        "description = $(ConvertTo-TomlBasicString $description)"
    )
    if ($readOnly) { $toml += 'sandbox_mode = "read-only"' }
    $toml += "developer_instructions = '''"
    $toml += $body
    $toml += "'''"

    $target = Join-Path $outDir "$codexName.toml"
    Set-Content -Path $target -Value (($toml -join "`n") + "`n") -NoNewline -Encoding utf8NoBOM
    $generated += $target
    Write-Host "codex/agents/$codexName.toml"
}

# Remove files for agents that no longer exist.
Get-ChildItem $outDir -Filter '*.toml' | Where-Object { $_.FullName -notin $generated } | Remove-Item

if ($Install) {
    $codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
    $dest = Join-Path $codexHome 'agents'
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item $generated -Destination $dest -Force
    Write-Host "Installed $($generated.Count) agents to $dest" -ForegroundColor Green
}
