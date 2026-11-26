Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptRoot = Split-Path -Parent $PSCommandPath

$checks = @()

function Add-Check {
    param(
        [string]$Name,
        [bool]$Passed,
        [string]$Details
    )

    $script:checks += [PSCustomObject]@{
        Name = $Name
        Passed = $Passed
        Details = $Details
    }
}

function Test-FileContentContains {
    param(
        [string]$Path,
        [string]$Pattern
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return $false
    }

    $content = Get-Content -LiteralPath $Path -Raw
    return ($content -match [regex]::Escape($Pattern))
}

$publishLivePath = Join-Path $scriptRoot "publish-live.ps1"
$publishDevPath = Join-Path $scriptRoot "publish-dev.ps1"
$releaseCommonPath = Join-Path $scriptRoot "release-common.ps1"
$publishDevWorkflowPath = Join-Path $scriptRoot ".github/workflows/publish-dev.yml"
$publishDevWorkflowPath = [System.IO.Path]::GetFullPath($publishDevWorkflowPath)

Add-Check -Name "publish-live exists" -Passed (Test-Path -LiteralPath $publishLivePath) -Details $publishLivePath
Add-Check -Name "publish-dev exists" -Passed (Test-Path -LiteralPath $publishDevPath) -Details $publishDevPath
Add-Check -Name "release-common exists" -Passed (Test-Path -LiteralPath $releaseCommonPath) -Details $releaseCommonPath

Add-Check -Name "publish-live has a short release-notes handoff" -Passed (Test-FileContentContains -Path $publishLivePath -Pattern "Are release notes ready? [y/N]") -Details "Default-No release-notes handoff found"
Add-Check -Name "publish-live preserves final deployment approval" -Passed (Test-FileContentContains -Path $publishLivePath -Pattern "Authorize production commit, tag, and push") -Details "Final deployment authorization found"
Add-Check -Name "publish-live preserves release notes output path default" -Passed (Test-FileContentContains -Path $publishLivePath -Pattern ".github/release/release-notes.md") -Details "Default release notes path found"

Add-Check -Name "publish-dev uses dev branch gate" -Passed (Test-FileContentContains -Path $publishDevPath -Pattern "Expected 'dev' but found") -Details "publish-dev enforces the dev branch"
Add-Check -Name "publish-dev uses dev version suggestion" -Passed (Test-FileContentContains -Path $publishDevPath -Pattern "Get-DevSuggestedVersion") -Details "publish-dev uses dev version suggestion logic"
Add-Check -Name "publish-dev skips release-notes gate" -Passed (Test-FileContentContains -Path $publishDevPath -Pattern "Release notes are optional") -Details "publish-dev does not require release notes"
Add-Check -Name "publish-dev workflow triggers on push to dev" -Passed (Test-FileContentContains -Path $publishDevWorkflowPath -Pattern "push") -Details "dev workflow responds to dev branch pushes"
$commonFunctions = @(
    "Invoke-ReleaseGit",
    "Test-ReleaseSemVer",
    "Get-NextReleasePatchVersion",
    "Get-DevSuggestedVersion",
    "Resolve-ReleasePath",
    "Get-ReleaseChangedPaths"
)

foreach ($functionName in $commonFunctions) {
    Add-Check -Name "release-common function $functionName" -Passed (Test-FileContentContains -Path $releaseCommonPath -Pattern "function $functionName") -Details $functionName
}

$failed = @($checks | Where-Object { -not $_.Passed })

Write-Host "Publish Parity Validation Results" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
foreach ($check in $checks) {
    $status = if ($check.Passed) { "PASS" } else { "FAIL" }
    $color = if ($check.Passed) { "Green" } else { "Red" }
    Write-Host ("[{0}] {1} - {2}" -f $status, $check.Name, $check.Details) -ForegroundColor $color
}

if ($failed.Count -gt 0) {
    Write-Host "" 
    Write-Host ("Validation failed: {0} check(s) failed." -f $failed.Count) -ForegroundColor Red
    exit 1
}

Write-Host "" 
Write-Host "Validation passed: all parity checks succeeded." -ForegroundColor Green
exit 0
