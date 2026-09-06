[CmdletBinding()]
param(
  [switch]$WhatIfMode
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $PSCommandPath
$docsDir = Join-Path $scriptDir 'docs'

if (-not (Test-Path -LiteralPath $docsDir)) {
  throw "Required directory not found: $docsDir"
}

if ($WhatIfMode) {
  Write-Host '[WhatIf] Validation completed. Deployment source is ./docs.' -ForegroundColor Yellow
}
else {
  Write-Host 'Validation completed. Deployment source is ./docs.' -ForegroundColor Green
}