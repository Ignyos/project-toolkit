[CmdletBinding()]
param(
    [string]$ProjectMode, # 'greenfield' or 'existing'
    [string]$ProfileName,

    # Pause between directives for a human operator. AI agents should leave this off
    # so the script emits every directive and exits instead of blocking on input.
    [switch]$Interactive
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $PSCommandPath
$profilesDir = Join-Path $scriptDir 'profiles'
$bootstrapSubDir = Join-Path $scriptDir 'bootstrap'

if (-not (Test-Path -LiteralPath $profilesDir)) {
    throw "Profiles directory not found at $profilesDir"
}

# Discover available profiles dynamically from project-toolkit/profiles/
$availableProfiles = Get-ChildItem -LiteralPath $profilesDir -Directory | Select-Object -ExpandProperty Name

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Ignyos Project Toolkit Bootstrapper  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. Prompt for Scope (Full Profile vs. Project Management Only)
if ([string]::IsNullOrWhiteSpace($ProfileName)) {
    Write-Host "Select Scope:" -ForegroundColor Yellow
    Write-Host "  [1] Full Project Profile    (CI/CD, scripts, launch configs, workflows, and PM)"
    Write-Host "  [2] Project Management Only (AI-driven PM/ structure & AGENTS.md rules only)"
    
    $scopeChoice = Read-Host "Choice [1 or 2]"
    while ($scopeChoice -ne '1' -and $scopeChoice -ne '2') {
        $scopeChoice = Read-Host "Please enter 1 for Full Profile or 2 for Project Management Only"
    }
    
    if ($scopeChoice -eq '2') {
        $ProfileName = 'project-management-only'
    }
}

# 2. Prompt for Project Mode if not provided via parameter
if ([string]::IsNullOrWhiteSpace($ProjectMode)) {
    Write-Host "Select Project Mode:" -ForegroundColor Yellow
    Write-Host "  [1] Greenfield  (New project from scratch)"
    Write-Host "  [2] Existing    (Refactor / adopt toolkit in existing codebase)"
    
    $modeChoice = Read-Host "Choice [1 or 2]"
    while ($modeChoice -ne '1' -and $modeChoice -ne '2') {
        $modeChoice = Read-Host "Please enter 1 for Greenfield or 2 for Existing"
    }
    
    $ProjectMode = if ($modeChoice -eq '1') { 'greenfield' } else { 'existing' }
} else {
    $ProjectMode = $ProjectMode.ToLower().Trim()
}

Write-Host "Project Mode: $ProjectMode" -ForegroundColor Green
Write-Host ""

# 3. Prompt for Profile Selection if not PM-only and not provided via parameter
if ($ProfileName -ne 'project-management-only' -and ([string]::IsNullOrWhiteSpace($ProfileName) -or ($availableProfiles -notcontains $ProfileName -and $ProfileName -ne 'create-new-profile'))) {
    Write-Host "Select Profile:" -ForegroundColor Yellow
    for ($i = 0; $i -lt $availableProfiles.Count; $i++) {
        $pName = $availableProfiles[$i]
        $archFile = Join-Path $profilesDir "$pName\architecture.md"
        $desc = "Profile definition"
        if (Test-Path -LiteralPath $archFile) {
            $firstLine = Get-Content -LiteralPath $archFile -TotalCount 5 | Where-Object { $_ -match '^#\s+' } | Select-Object -First 1
            if ($firstLine) {
                $desc = ($firstLine -replace '^#\s*', '').Trim()
            }
        }
        Write-Host ("  [{0}] {1}" -f ($i + 1), $pName)
        Write-Host ("      {0}" -f $desc) -ForegroundColor Gray
    }

    $newProfileOptionNum = $availableProfiles.Count + 1
    Write-Host ("  [{0}] Create a New Profile" -f $newProfileOptionNum)
    Write-Host "      Author and contribute a new project type profile to project-toolkit" -ForegroundColor Gray

    $profileChoiceIndex = -1
    while ($profileChoiceIndex -lt 0 -or $profileChoiceIndex -ge $newProfileOptionNum) {
        $rawIdx = Read-Host ("Choice [1-{0}]" -f $newProfileOptionNum)
        [int]::TryParse($rawIdx, [ref]$profileChoiceIndex) | Out-Null
        $profileChoiceIndex = $profileChoiceIndex - 1
    }

    if ($profileChoiceIndex -eq $availableProfiles.Count) {
        $ProfileName = 'create-new-profile'
    } else {
        $ProfileName = $availableProfiles[$profileChoiceIndex]
    }
}

Write-Host "Selected Profile: $ProfileName" -ForegroundColor Green
Write-Host ""

# 3. Dispatch to profile-specific orchestration script
$profileScript = Join-Path $bootstrapSubDir "$ProfileName.ps1"

if (-not (Test-Path -LiteralPath $profileScript)) {
    throw "Profile orchestration script not found at $profileScript"
}

Write-Host "Dispatching to $profileScript ..." -ForegroundColor Cyan
Write-Host ""

& $profileScript -ProjectMode $ProjectMode -ToolkitRoot $scriptDir -Interactive:$Interactive
