<##
.SYNOPSIS
    Starts a DevContainer with Docker or Podman and opens an interactive shell.

.DESCRIPTION
    Validates the required tooling, initializes the selected container backend,
    starts the DevContainer, locates the container for the current workspace,
    and launches Claude Code followed by an interactive zsh session.

.PARAMETER Backend
    Container backend. Valid values: docker, podman.

.EXAMPLE
    .\Script\run_devcontainer_claude_code.ps1 -Backend docker

.EXAMPLE
    .\Script\run_devcontainer_claude_code.ps1 -Backend podman
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateSet('docker', 'podman')]
    [string]$Backend
)

$ErrorActionPreference = 'Stop'
$MachineName = 'salvorel-devcontainer'
$WorkspacePath = (Get-Location).Path

function Assert-Command {
    param([Parameter(Mandatory)][string]$Name)

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' was not found in PATH."
    }
}

function Invoke-CheckedCommand {
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter()][string[]]$Arguments = @()
    )

    & $Name @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Command '$Name' failed with exit code $LASTEXITCODE."
    }
}

Write-Host '--- DevContainer Startup ---'
Write-Host "Backend: $Backend"
Write-Host "Workspace: $WorkspacePath"

try {
    Assert-Command $Backend
    Assert-Command 'devcontainer'

    if ($Backend -eq 'podman') {
        Write-Host "Preparing Podman machine '$MachineName'..."

        & podman machine inspect $MachineName *> $null
        if ($LASTEXITCODE -ne 0) {
            Invoke-CheckedCommand 'podman' @('machine', 'init', $MachineName)
        }

        & podman machine start $MachineName -q
        if ($LASTEXITCODE -ne 0) {
            Write-Host 'Podman machine may already be running; continuing.'
        }

        Invoke-CheckedCommand 'podman' @('system', 'connection', 'default', $MachineName)
    }
    else {
        Write-Host 'Checking Docker daemon...'
        Invoke-CheckedCommand 'docker' @('info') | Out-Null
    }

    Write-Host 'Starting DevContainer...'
    $DevContainerArgs = @('up', '--workspace-folder', $WorkspacePath)
    if ($Backend -eq 'podman') {
        $DevContainerArgs += @('--docker-path', 'podman')
    }
    Invoke-CheckedCommand 'devcontainer' $DevContainerArgs

    Write-Host 'Locating DevContainer...'
    $ContainerId = (& $Backend ps --filter "label=devcontainer.local_folder=$WorkspacePath" --format '{{.ID}}').Trim()

    if (-not $ContainerId) {
        throw "No running DevContainer was found for '$WorkspacePath'."
    }

    Write-Host "Container: $ContainerId"
    Write-Host 'Launching Claude Code and interactive zsh...'

    Invoke-CheckedCommand $Backend @('exec', '-it', $ContainerId, 'zsh', '-c', 'claude; exec zsh')

    Write-Host '--- Session completed ---'
}
catch {
    Write-Error "DevContainer startup failed: $($_.Exception.Message)"
    exit 1
}
