<#
.SYNOPSIS
    Starts a DevContainer using Docker or Podman and opens a Claude Code shell.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('docker', 'podman')]
    [string]$Backend
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Assert-Command {
    param([Parameter(Mandatory = $true)][string]$Name)

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' was not found in PATH."
    }
}

function Invoke-Step {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][scriptblock]$Action
    )

    Write-Host "==> $Name"
    try {
        & $Action
    }
    catch {
        throw "$Name failed: $($_.Exception.Message)"
    }
}

Write-Host '--- DevContainer startup ---'
Write-Host "Backend: $Backend"

Invoke-Step 'Check prerequisites' {
    Assert-Command $Backend
    Assert-Command 'devcontainer'
}

if ($Backend -eq 'podman') {
    Invoke-Step 'Initialize Podman machine' {
        & podman machine init claudeVM 2>$null
    }

    Invoke-Step 'Start Podman machine' {
        & podman machine start claudeVM -q
    }

    Invoke-Step 'Set Podman connection' {
        & podman system connection default claudeVM
    }
}
else {
    Invoke-Step 'Check Docker daemon' {
        & docker info | Out-Null
    }
}

Invoke-Step 'Start DevContainer' {
    $arguments = @('up', '--workspace-folder', '.')

    if ($Backend -eq 'podman') {
        $arguments += @('--docker-path', 'podman')
    }

    & devcontainer @arguments
}

$currentFolder = (Get-Location).Path
$containerId = (& $Backend ps --filter "label=devcontainer.local_folder=$currentFolder" --format '{{.ID}}').Trim()

if ([string]::IsNullOrWhiteSpace($containerId)) {
    throw "No DevContainer was found for '$currentFolder'."
}

Write-Host "Container: $containerId"
Invoke-Step 'Open Claude Code session' {
    & $Backend exec -it $containerId zsh -c 'claude; exec zsh'
}

Write-Host '--- DevContainer session ended ---'
