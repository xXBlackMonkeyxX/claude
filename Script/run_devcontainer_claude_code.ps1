# Deprecated compatibility wrapper.
# Use tools/devcontainer/run_devcontainer.ps1 instead.

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateSet('docker', 'podman')]
    [string]$Backend
)

$ErrorActionPreference = 'Stop'
$Target = Join-Path $PSScriptRoot '..\tools\devcontainer\run_devcontainer.ps1'

if (-not (Test-Path -LiteralPath $Target -PathType Leaf)) {
    throw "DevContainer launcher not found: $Target"
}

& $Target -Backend $Backend
exit $LASTEXITCODE
