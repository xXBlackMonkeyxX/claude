<#
.SYNOPSIS
    Starts the repository DevContainer with Docker or Podman and launches Claude Code.

.DESCRIPTION
    Runs from the repository root. The launcher uses the Dev Container CLI for
    container discovery and execution instead of parsing backend-specific labels.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('docker', 'podman')]
    [string]$Backend
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Require-Command([string]$Name) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' was not found in PATH."
    }
}

function Invoke-Checked([string]$Command, [string[]]$Arguments) {
    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Command '$Command' failed with exit code $LASTEXITCODE."
    }
}

$repoRoot = (Get-Location).Path
$devcontainerPath = Join-Path $repoRoot '.devcontainer'
if (-not (Test-Path -LiteralPath $devcontainerPath -PathType Container)) {
    throw "No .devcontainer directory was found in '$repoRoot'. Run this script from the repository root."
}

Write-Host '--- Salvorel DevContainer Launcher ---'
Write-Host "Backend: $Backend"
Write-Host "Workspace: $repoRoot"

Require-Command $Backend
Require-Command 'devcontainer'

$devcontainerArgs = @('up', '--workspace-folder', $repoRoot)
$execArgs = @('exec', '--workspace-folder', $repoRoot)

if ($Backend -eq 'docker') {
    Write-Host 'Checking Docker daemon...'
    Invoke-Checked 'docker' @('info')
} else {
    Require-Command 'podman'
    Write-Host 'Checking Podman machine...'
    $machineState = (& podman machine inspect claudeVM --format '{{.State}}' 2>$null)
    if ($LASTEXITCODE -ne 0) {
        Write-Host 'Creating Podman machine claudeVM...'
        Invoke-Checked 'podman' @('machine', 'init', 'claudeVM')
        $machineState = 'stopped'
    }

    if ([string]$machineState -ne 'running') {
        Write-Host 'Starting Podman machine claudeVM...'
        Invoke-Checked 'podman' @('machine', 'start', 'claudeVM')
    }

    Invoke-Checked 'podman' @('system', 'connection', 'default', 'claudeVM')
    $devcontainerArgs += @('--docker-path', 'podman')
    $execArgs += @('--docker-path', 'podman')
}

Write-Host 'Starting DevContainer...'
Invoke-Checked 'devcontainer' $devcontainerArgs

Write-Host 'Launching Claude Code inside the DevContainer...'
$execArgs += @('zsh', '-lc', 'claude; status=$?; exec zsh')
& devcontainer @execArgs
if ($LASTEXITCODE -ne 0) {
    throw "DevContainer interactive session exited with code $LASTEXITCODE."
}

Write-Host '--- DevContainer session ended ---'
