# Install the zoo-kimi-playbook configuration into a project directory.
# Usage: .\setup.ps1 -Target C:\path\to\project
param(
    [Parameter(Mandatory = $true)]
    [string]$Target
)

$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
New-Item -ItemType Directory -Force -Path $Target | Out-Null

Copy-Item (Join-Path $Here ".clinerules") (Join-Path $Target ".clinerules") -Force
Copy-Item (Join-Path $Here ".roo") (Join-Path $Target ".roo") -Recurse -Force

$Agents = Join-Path $Target "AGENTS.md"
if (-not (Test-Path $Agents)) {
    Copy-Item (Join-Path $Here "templates\AGENTS.md") $Agents
    Write-Host "installed starter AGENTS.md — edit it for your project"
} else {
    Write-Host "AGENTS.md already present — left untouched"
}

Write-Host "done → $Target"
Write-Host "next: install Zoo Code (or the Kimi Code CLI) and follow INSTALLATION_GUIDE.md"
