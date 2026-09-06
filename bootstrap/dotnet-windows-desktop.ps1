[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectMode,

    [Parameter(Mandatory = $true)]
    [string]$ToolkitRoot
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$profileName = 'dotnet-windows-desktop'
$profileDir = Join-Path $ToolkitRoot "profiles\$profileName"

Write-Host "----------------------------------------" -ForegroundColor Cyan
Write-Host " Profile: $profileName" -ForegroundColor Cyan
Write-Host " Mode:    $ProjectMode" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Cyan
Write-Host ""

# Environment pre-check
$dotnetCmd = Get-Command dotnet -ErrorAction SilentlyContinue
if (-not $dotnetCmd) {
    Write-Warning ".NET CLI ('dotnet') was not detected on PATH."
    Write-Warning "Ensure .NET SDK is installed before generating this project."
} else {
    Write-Host "[Check] .NET CLI detected." -ForegroundColor Green
}

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 1 / 4                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please execute Step 1: AI Direction & Project Management Setup" -ForegroundColor White
Write-Host ""
Write-Host "Context files to read:" -ForegroundColor Gray
Write-Host "  1. $ToolkitRoot\shared\ai-direction-guidance.md" -ForegroundColor Gray
Write-Host "  2. $ToolkitRoot\shared\project-management\workflow.md" -ForegroundColor Gray
Write-Host "  3. $profileDir\architecture.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Directives:" -ForegroundColor White
if ($ProjectMode -eq 'greenfield') {
    Write-Host "  - Greenfield Mode: Create AGENTS.md and .github/copilot-instructions.md fresh."
    Write-Host "  - Create PM/ structure (project-management.md, workflow.md, backlog/, current/, release-candidate-dev/, release-candidate/, completed/)."
} else {
    Write-Host "  - Existing Mode: Inspect existing AGENTS.md / .github/copilot-instructions.md."
    Write-Host "  - Reconcile and append PM pointer without overwriting project-specific direction."
    Write-Host "  - Establish dev branch if only main exists."
    Write-Host "  - Reconcile PM/ structure."
}
Write-Host ""

Read-Host "Press ENTER after AI Assistant completes Step 1..."

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 2 / 4                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please execute Step 2: Implementation & Script Generation" -ForegroundColor White
Write-Host ""
Write-Host "Context files to read:" -ForegroundColor Gray
Write-Host "  1. $profileDir\requirements.md" -ForegroundColor Gray
Write-Host "  2. $profileDir\implementation-steps.md" -ForegroundColor Gray
Write-Host "  3. Reference scripts in $profileDir\reference\" -ForegroundColor Gray
Write-Host "  4. Breadcrumb spec in $ToolkitRoot\shared\breadcrumb-spec.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Directives:" -ForegroundColor White
Write-Host "  - Apply origin breadcrumbs to all generated files."
Write-Host "  - Generate scripts/publish-live.ps1, scripts/publish-dev.ps1, scripts/release-common.ps1, scripts/validate-publish-parity.ps1, scripts/build-dev-installer.ps1."
Write-Host "  - Generate or merge .vscode/launch.json and .github/workflows/."
Write-Host ""

Read-Host "Press ENTER after AI Assistant completes Step 2..."

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 3 / 4                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please execute Step 3: Acceptance Verification" -ForegroundColor White
Write-Host ""
Write-Host "Context file to read:" -ForegroundColor Gray
Write-Host "  1. $profileDir\acceptance-checklist.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Directives:" -ForegroundColor White
Write-Host "  - Walk through acceptance-checklist.md prose requirements."
Write-Host "  - Verify version source of truth, branch gating, release notes AI gate, installer branding, and PM integration."
Write-Host ""

Read-Host "Press ENTER after AI Assistant completes Step 3..."

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 4 / 4                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Bootstrapping orchestration complete." -ForegroundColor Green
Write-Host "Scratch toolkit directory can now be safely removed." -ForegroundColor Green
Write-Host ""
