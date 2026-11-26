[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectMode,

    [Parameter(Mandatory = $true)]
    [string]$ToolkitRoot,

    [ValidateSet('solo', 'team')]
    [string]$OperatingMode = 'solo',

    [switch]$Interactive,

    [switch]$EnableBranching,

    [switch]$EnableDeploymentCheckpoints,

    [switch]$EnableEvidencePolicy
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
Write-Host " Operating: $OperatingMode" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Cyan
Write-Host ""

Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 1 / 3                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please execute Step 1: AI Direction & Project Management Setup" -ForegroundColor White
Write-Host ""
Write-Host "Context files to read:" -ForegroundColor Gray
Write-Host "  - $ToolkitRoot\shared\ai-direction-guidance.md" -ForegroundColor Gray
Write-Host "  - $ToolkitRoot\shared\project-management\workflow.md" -ForegroundColor Gray
Write-Host "  - $ToolkitRoot\shared\project-management\$OperatingMode-mode.md" -ForegroundColor Gray
Write-Host "  - $ToolkitRoot\shared\project-management\project-management.md" -ForegroundColor Gray
if ($EnableBranching) {
    Write-Host "  - $ToolkitRoot\shared\project-management\branching.md" -ForegroundColor Gray
}
if ($EnableDeploymentCheckpoints) {
    Write-Host "  - $ToolkitRoot\shared\project-management\deployment-checkpoints.md" -ForegroundColor Gray
}
if ($EnableEvidencePolicy) {
    Write-Host "  - $ToolkitRoot\shared\project-management\evidence-policy.md" -ForegroundColor Gray
}
Write-Host ""
Write-Host "Directives:" -ForegroundColor White
if ($ProjectMode -eq 'greenfield') {
    Write-Host "  - Greenfield Mode: Create AGENTS.md and .github/copilot-instructions.md fresh with pointer to PM/workflow.md."
    Write-Host "  - Create PM/ structure for the selected mode (project-management.md, workflow.md, backlog/, current/, completed/)."
} else {
    Write-Host "  - Existing Mode: Inspect existing AGENTS.md / .github/copilot-instructions.md."
    Write-Host "  - Reconcile and append pointer to PM/workflow.md without overwriting existing CI/CD or project-specific direction."
    Write-Host "  - Reconcile PM/ structure for the selected mode (project-management.md, workflow.md, backlog/, current/, completed/)."
    Write-Host "  - Migrate any existing roadmap or task checklists into appropriate PM/ lifecycle directories."
    Write-Host "  - Preserve PM history and existing optional policies; ask before changing ambiguous item states or disabling/removing an existing module."
}
Write-Host "  - Compose PM/workflow.md from the shared safety baseline and the selected operating-mode overlay."
Write-Host "  - Ask the developer to identify the accountable owner, acceptance authority, and deployment authority; record roles, never infer them."
Write-Host "  - Explain that work completion is separate from deployment and that an accepted slice needs no second PM-status approval."
Write-Host "  - Add a 'Project Management Mode: $OperatingMode; see PM/workflow.md' pointer in AGENTS.md / copilot-instructions.md."
if ($EnableBranching) {
    Write-Host "  - Copy branching.md into PM/branching.md, add its breadcrumb, and add a 'Branching Policy: enabled, see PM/branching.md' pointer line next to the PM/workflow.md pointer in AGENTS.md / copilot-instructions.md."
}
if ($EnableDeploymentCheckpoints) {
    Write-Host "  - Add the deployment-checkpoint rules from deployment-checkpoints.md; create separate deployment candidate indexes without moving work items and add a pointer in AI direction files."
}
if ($EnableEvidencePolicy) {
    Write-Host "  - Copy evidence-policy.md into PM/evidence-policy.md and add its breadcrumb and pointer in AI direction files."
}
Write-Host "  - Document which actions need a human at an interactive terminal; never simulate approval input."
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
Write-Host "  - Apply origin breadcrumb header per shared/breadcrumb-spec.md to all generated PM policy files and PM/project-management.md."
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
