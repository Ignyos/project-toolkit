[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectMode,

    [Parameter(Mandatory = $true)]
    [string]$ToolkitRoot,

    [string]$NewProfileName,

    [switch]$Interactive
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Wait-ForStep {
    param([string]$Message)
    if ($Interactive) { Read-Host $Message | Out-Null }
}

Write-Host "----------------------------------------" -ForegroundColor Cyan
Write-Host " Action: Create a New Profile" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Cyan
Write-Host ""

# Prompt for the new profile folder name
if ([string]::IsNullOrWhiteSpace($NewProfileName)) {
    $NewProfileName = Read-Host "Enter new profile folder name (e.g., python-fastapi-service, node-react-spa)"
}
$newProfileName = $NewProfileName.ToLower().Trim() -replace '[^a-z0-9\-]', ''

if ([string]::IsNullOrWhiteSpace($newProfileName)) {
    throw "Invalid profile name provided."
}

$profilesDir = Join-Path $ToolkitRoot 'profiles'
$targetProfileDir = Join-Path $profilesDir $newProfileName
$targetBootstrapScript = Join-Path $ToolkitRoot "bootstrap\$newProfileName.ps1"

if (Test-Path -LiteralPath $targetProfileDir) {
    throw "Profile '$newProfileName' already exists at $targetProfileDir"
}

Write-Host "New Profile Name: $newProfileName" -ForegroundColor Green
Write-Host "New Profile Dir:  $targetProfileDir" -ForegroundColor Green
Write-Host ""

Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 1 / 3                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please execute Step 1: Draft Profile Definition Files" -ForegroundColor White
Write-Host ""
Write-Host "Target Directory: $targetProfileDir" -ForegroundColor Gray
Write-Host "Target Script:    $targetBootstrapScript" -ForegroundColor Gray
Write-Host ""
Write-Host "Directives:" -ForegroundColor White
Write-Host "  1. Create directory $targetProfileDir and $targetProfileDir\reference\"
Write-Host "  2. Inspect the current workspace/target codebase for real architecture evidence."
Write-Host "  3. Create $targetProfileDir\architecture.md describing components, process model, and versioning."
Write-Host "  4. Create $targetProfileDir\requirements.md listing mandatory non-negotiable requirements."
Write-Host "  5. Create $targetProfileDir\implementation-steps.md detailing AI generation steps (Greenfield vs. Existing)."
Write-Host "  6. Create $targetProfileDir\acceptance-checklist.md providing prose verification criteria."
Write-Host "  7. Copy real working scripts/workflows into $targetProfileDir\reference\ and add $targetProfileDir\reference\README.md."
Write-Host "  8. Create $targetBootstrapScript using the standard 4-directive AI hand-off loop pattern."
Write-Host ""

Wait-ForStep "Press ENTER after AI Assistant creates the new profile files..."

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 2 / 3                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please execute Step 2: Commit & Push New Profile to project-toolkit Repo" -ForegroundColor White
Write-Host ""
Write-Host "Directives:" -ForegroundColor White
Write-Host "  1. Verify git status inside $ToolkitRoot"
Write-Host "  2. Stage new profile: git add profiles/$newProfileName bootstrap/$newProfileName.ps1"
Write-Host "  3. Commit: git commit -m 'feat(profile): add $newProfileName profile'"
Write-Host "  4. Attempt Push: git push origin main"
Write-Host ""
Write-Host "Fallback Handling if git push origin main fails (e.g. 403 Permission Denied / Read-Only access):" -ForegroundColor Yellow
Write-Host "  If pushing directly to origin/main fails, present the developer with 3 options:" -ForegroundColor Yellow
Write-Host "    [1] Push to Personal Fork & Open PR:" -ForegroundColor Gray
Write-Host "        git remote add fork <user-fork-url>; git push fork main (AI outputs PR creation link)" -ForegroundColor Gray
Write-Host "    [2] Export Profile Zip / Artifact:" -ForegroundColor Gray
Write-Host "        Package profiles/$newProfileName and bootstrap/$newProfileName.ps1 into artifacts/new-profile-$newProfileName.zip for issue/discussion attachment" -ForegroundColor Gray
Write-Host "    [3] Skip Remote Push & Proceed Locally:" -ForegroundColor Gray
Write-Host "        Keep committed locally in .scratch-toolkit and proceed to bootstrap target project" -ForegroundColor Gray
Write-Host ""

Wait-ForStep "Press ENTER after AI Assistant completes Step 2..."

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host "                     AI ASSISTANT DIRECTIVE 3 / 3                               " -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please execute Step 3: Bootstrap Target Project Using New Profile" -ForegroundColor White
Write-Host ""
Write-Host "Directives:" -ForegroundColor White
Write-Host "  - Now execute $targetBootstrapScript -ProjectMode $ProjectMode -ToolkitRoot $ToolkitRoot"
Write-Host "  - Proceed to bootstrap the current project using the newly minted $newProfileName profile."
Write-Host ""

# Dispatch to the newly created profile script if it exists
if (Test-Path -LiteralPath $targetBootstrapScript) {
    Write-Host "Dispatching to newly created profile script: $targetBootstrapScript ..." -ForegroundColor Cyan
    & $targetBootstrapScript -ProjectMode $ProjectMode -ToolkitRoot $ToolkitRoot
} else {
    Write-Warning "New profile script $targetBootstrapScript was not found. Please verify manual dispatch."
}
