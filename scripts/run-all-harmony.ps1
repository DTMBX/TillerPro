#!/usr/bin/env pwsh
# Tillerstead Stone - Intelligent Site Harmony Script
# Audits first, then fixes issues based on scan results

$ErrorActionPreference = "Continue"
$scriptDir = $PSScriptRoot
$projectRoot = Split-Path $scriptDir -Parent

Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  TILLERSTEAD STONE - INTELLIGENT SITE HARMONY BUILDER     ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Set-Location $projectRoot

# Initialize issue tracking
$issues = @{
    css = $false
    images = $false
    config = $false
    jekyll = $false
    links = $false
    navigation = $false
    assets = $false
}

# Phase 1: Environment Setup
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
Write-Host "PHASE 1: Environment Setup" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow

if (Test-Path "$scriptDir\activate-ruby.ps1") {
    Write-Host "[1/1] Activating Ruby environment..." -ForegroundColor Green
    & "$scriptDir\activate-ruby.ps1"
} else {
    Write-Host "[1/1] Ruby activation script not found, skipping..." -ForegroundColor Yellow
}

# Phase 2: Auditing & Diagnostics
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
Write-Host "PHASE 2: Site Auditing & Diagnostics" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow

Write-Host "[1/3] Running CSS structure analysis..." -ForegroundColor Green
node "$scriptDir\analyze-css-structure.js"

Write-Host "[2/3] Checking for unused CSS..." -ForegroundColor Green
node "$scriptDir\find-unused-css.js"

Write-Host "[3/3] Running repo doctor..." -ForegroundColor Green
node "$scriptDir\ts-90-repo-doctor.js"

# Phase 3: Asset Optimization
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
Write-Host "PHASE 3: Asset Optimization" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow

Write-Host "[1/4] Generating PNG logos..." -ForegroundColor Green
node "$scriptDir\generate-png-logos.js"

Write-Host "[2/4] Optimizing images..." -ForegroundColor Green
node "$scriptDir\optimize-images.js"

Write-Host "[3/4] Converting images to WebP..." -ForegroundColor Green
node "$scriptDir\convert-images-to-webp.js"

Write-Host "[4/4] Auditing and fixing image structure..." -ForegroundColor Green
& "$scriptDir\audit-and-fix-images.ps1"

# Phase 4: Build Process
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
Write-Host "PHASE 4: Site Build" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow

Write-Host "[1/2] Building CSS..." -ForegroundColor Green
node "$scriptDir\build-css.js"

Write-Host "[2/2] Building Jekyll site..." -ForegroundColor Green
& "$scriptDir\build-site.ps1"

# Phase 5: Post-Build
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
Write-Host "PHASE 5: Post-Build Tasks" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow

Write-Host "[1/2] Running post-build link script..." -ForegroundColor Green
node "$scriptDir\post-build-link.js"

Write-Host "[2/2] Checking links..." -ForegroundColor Green
node "$scriptDir\check-links.js"

# Phase 6: Verification
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
Write-Host "PHASE 6: Deployment Verification" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow

Write-Host "[1/2] Verifying deployment readiness..." -ForegroundColor Green
node "$scriptDir\verify-deployment.js"

Write-Host "[2/2] Running navigation tests..." -ForegroundColor Green
node "$scriptDir\test-navigation.js"

# Summary
Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  ✓ COMPLETE SITE HARMONY BUILD FINISHED                  ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Review any warnings or errors above" -ForegroundColor White
Write-Host "  2. Test locally: npm run serve" -ForegroundColor White
Write-Host "  3. Deploy: git add -A && git commit -m 'Site harmony build' && git push" -ForegroundColor White
Write-Host ""
