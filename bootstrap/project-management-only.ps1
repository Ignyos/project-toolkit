[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectMode,

    [Parameter(Mandatory = $true)]
    [string]$ToolkitRoot,

    [switch]$Interactive
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Wait-ForStep {
    param([string]$Message)
    if ($Interactive) { Read-Host $Message | Out-Null }
}

$profileName = 'project-management-only'

Write-Host "----------------------------------------" -ForegroundColor Cyan
Write-Host " Component: Project Management Only" -ForegroundColor Cyan
Write-Host " Mode:      $ProjectMode" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Cyan
Write-Host ""

Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 1 / 3                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please execute Step 1: AI Direction & Project Management Setup" -ForegroundColor White
Write-Host ""
Write-Host "Context files to read:" -ForegroundColor Gray
Write-Host "  1. $ToolkitRoot\shared\ai-direction-guidance.md" -ForegroundColor Gray
Write-Host "  2. $ToolkitRoot\shared\project-management\workflow.md" -ForegroundColor Gray
Write-Host "  3. $ToolkitRoot\shared\project-management\project-management.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Directives:" -ForegroundColor White
if ($ProjectMode -eq 'greenfield') {
    Write-Host "  - Greenfield Mode: Create AGENTS.md and .github/copilot-instructions.md fresh with pointer to PM/workflow.md."
    Write-Host "  - Create PM/ structure (project-management.md, workflow.md, backlog/, current/, release-candidate-dev/, release-candidate/, completed/)."
} else {
    Write-Host "  - Existing Mode: Inspect existing AGENTS.md / .github/copilot-instructions.md."
    Write-Host "  - Reconcile and append pointer to PM/workflow.md without overwriting existing CI/CD or project-specific direction."
    Write-Host "  - Create PM/ structure (project-management.md, workflow.md, backlog/, current/, release-candidate-dev/, release-candidate/, completed/)."
    Write-Host "  - Migrate any existing roadmap or task checklists into appropriate PM/ lifecycle directories."
}
Write-Host "  - Carry the completion-confirmation gate from shared/project-management/workflow.md into PM/workflow.md verbatim: items are never marked complete on AI judgment alone."
Write-Host ""

Wait-ForStep "Press ENTER after AI Assistant completes Step 1..."

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 2 / 3                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please execute Step 2: PM Origin Breadcrumb & Verification" -ForegroundColor White
Write-Host ""
Write-Host "Context file to read:" -ForegroundColor Gray
Write-Host "  1. $ToolkitRoot\shared\breadcrumb-spec.md" -ForegroundColor Gray
Write-Host ""
Write-Host "Directives:" -ForegroundColor White
Write-Host "  - Apply origin breadcrumb header per shared/breadcrumb-spec.md to PM/workflow.md and PM/project-management.md."
Write-Host "  - Verify PM/ directory structure and pointer in AGENTS.md / copilot-instructions.md are intact."
Write-Host ""

Wait-ForStep "Press ENTER after AI Assistant completes Step 2..."

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 3 / 3                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Project Management bootstrapping complete." -ForegroundColor Green
Write-Host "Scratch toolkit directory can now be safely removed." -ForegroundColor Green
Write-Host ""

if (-not $Interactive) {
    Write-Host "================================================================================" -ForegroundColor Yellow
    Write-Host "                     ALL DIRECTIVES ISSUED - AI: BEGIN WORK NOW                 " -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "This script has exited. It will not prompt you again and no further terminal" -ForegroundColor White
    Write-Host "commands are required to advance it." -ForegroundColor White
    Write-Host ""
    Write-Host "The directives printed above are YOUR task list. Execute them yourself, in order," -ForegroundColor White
    Write-Host "by reading the listed context files and creating/editing files in the project." -ForegroundColor White
    Write-Host "Do not wait for further input before starting." -ForegroundColor White
    Write-Host ""
    Write-Host "When every directive is complete, delete the .scratch-toolkit directory." -ForegroundColor White
    Write-Host ""
}
