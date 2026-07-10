$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$source = Join-Path $repoRoot "skills"
$target = Join-Path $env:USERPROFILE ".codex\skills"

if (-not (Test-Path -LiteralPath $source)) {
  throw "Missing source skills directory: $source"
}

New-Item -ItemType Directory -Force -Path $target | Out-Null
Copy-Item -Recurse -Force -Path (Join-Path $source "*") -Destination $target

Write-Host "Trading skills restored to: $target"
Write-Host "Next: ask Codex to verify the skills and update machine-specific paths."

