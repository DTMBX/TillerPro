param(
  [string]$Root = "C:\barber-cam\public",
  [string]$Repo = "tillerstead"
)

$repoPath = Join-Path $Root $Repo
Set-Location $repoPath

Write-Host "== FINALIZING TILLERSTEAD ==" -ForegroundColor Cyan

# 1. Safety check
git status --porcelain
if ($LASTEXITCODE -ne 0) {
  throw "Not a git repo or git not available."
}

# 2. Ensure correct branch
git checkout bypass-compliance

# 3. Remove backup artifacts from build
$cleanup = @(
  ".backups",
  "reports",
  "*.bak_keep_*"
)

foreach ($item in $cleanup) {
  Get-ChildItem -Recurse -Force -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -like $item } |
    Remove-Item -Force -Recurse
}

# 4. Enforce excludes
if (-not (Select-String "_bak_keep_" _config.yml -Quiet)) {
  Add-Content _config.yml @"
exclude:
  - "*.bak_keep_*"
  - ".backups"
  - "reports"
"@
}

# 5. Merge footer gradient tokens (idempotent)
$tokens = "_sass/00-settings/_tokens-hybrid.scss"
$footerGradient = "--tiller-footer-bg: linear-gradient(180deg, #0a0a0a 0%, #065a24 100%);"

if (-not (Select-String "tiller-footer-bg" $tokens -Quiet)) {
  Add-Content $tokens $footerGradient
}

# 6. Commit
git add .
git commit -m "Finalize canonical Tillerstead build + preserve live footer gradient"

# 7. Build verification
bundle exec jekyll build --trace

Write-Host "✔ Final build completed" -ForegroundColor Green
