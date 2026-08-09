[CmdletBinding()]
param(
    [string]$RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Fail([string]$Message) {
    Write-Error "VALIDATION FAILED: $Message"
    exit 1
}

function Assert-Condition([bool]$Condition, [string]$Message) {
    if (-not $Condition) { Fail $Message }
}

$marketplacePath = Join-Path $RepositoryRoot 'claude-plugin/marketplace.json'
Assert-Condition (Test-Path -LiteralPath $marketplacePath -PathType Leaf) "Missing claude-plugin/marketplace.json."

try {
    $marketplace = Get-Content -LiteralPath $marketplacePath -Raw | ConvertFrom-Json
} catch {
    Fail "marketplace.json is not valid JSON: $($_.Exception.Message)"
}

Assert-Condition ($null -ne $marketplace.plugins) "marketplace.json has no plugins array."

$names = @{}
foreach ($plugin in @($marketplace.plugins)) {
    Assert-Condition (-not [string]::IsNullOrWhiteSpace([string]$plugin.name)) "A marketplace plugin has no name."
    Assert-Condition (-not $names.ContainsKey([string]$plugin.name)) "Duplicate marketplace plugin name: $($plugin.name)"
    $names[[string]$plugin.name] = $true

    Assert-Condition (-not [string]::IsNullOrWhiteSpace([string]$plugin.source)) "Plugin '$($plugin.name)' has no source."
    $sourcePath = Join-Path $RepositoryRoot ([string]$plugin.source)
    Assert-Condition (Test-Path -LiteralPath $sourcePath -PathType Container) "Plugin '$($plugin.name)' source does not exist: $($plugin.source)"

    $readme = Join-Path $sourcePath 'README.md'
    Assert-Condition (Test-Path -LiteralPath $readme -PathType Leaf) "Plugin '$($plugin.name)' is missing README.md."
}

$pluginDirs = Get-ChildItem -LiteralPath $RepositoryRoot -Directory | Where-Object {
    $_.Name -notin @('.git','.github','.devcontainer','Script','docs','tools','claude-plugin')
}

$declaredSources = @($marketplace.plugins | ForEach-Object { [string]$_.source.TrimStart('./') })
foreach ($dir in $pluginDirs) {
    if ($declaredSources -contains $dir.Name) { continue }
    if ($dir.Name -in @('claude')) { continue }
    Write-Warning "Top-level directory '$($dir.Name)' is not declared in marketplace.json."
}

$psFiles = Get-ChildItem -LiteralPath $RepositoryRoot -Recurse -File -Filter '*.ps1' | Where-Object {
    $_.FullName -notmatch '[\\/]\.git[\\/]'
}
foreach ($file in $psFiles) {
    $tokens = $null
    $errors = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$tokens, [ref]$errors)
    if ($errors.Count -gt 0) {
        Fail "PowerShell parse errors in '$($file.FullName)': $($errors[0].Message)"
    }
}

$forbidden = @('*.log','*.tmp','*.bak','*.zip','*.tar','*.tar.gz','*.7z')
foreach ($pattern in $forbidden) {
    $matches = Get-ChildItem -LiteralPath $RepositoryRoot -Recurse -File -Filter $pattern -ErrorAction SilentlyContinue | Where-Object {
        $_.FullName -notmatch '[\\/]\.git[\\/]'
    }
    foreach ($match in $matches) {
        Fail "Generated or temporary artifact must not be committed: $($match.FullName)"
    }
}

Write-Host "VALIDATION PASSED: $(@($marketplace.plugins).Count) marketplace plugins checked; $(@($psFiles).Count) PowerShell files parsed."
