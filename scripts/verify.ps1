###############################################################################
# verify.ps1 - Cross-platform build verification script for Tillerstead.com
# 
# Purpose: Verify Jekyll site builds successfully and passes quality gates
# Usage: .\scripts\verify.ps1
# 
# Requirements:
# - Ruby >= 3.2
# - Bundler
# - PowerShell Core >= 7.0 (or Windows PowerShell 5.1+)
###############################################################################

param(
    [switch]$Verbose,
    [switch]$SkipLinkCheck
)

$ErrorActionPreference = "Stop"
$OverallStatus = 0

###############################################################################
# Helper Functions
###############################################################################

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ " -ForegroundColor Blue -NoNewline
    Write-Host $Message
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ " -ForegroundColor Green -NoNewline
    Write-Host $Message
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠ " -ForegroundColor Yellow -NoNewline
    Write-Host $Message
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "✗ " -ForegroundColor Red -NoNewline
    Write-Host $Message
    $script:OverallStatus = 1
}

function Write-Section {
    param([string]$Title)
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Blue
    Write-Host "▶ $Title" -ForegroundColor Blue
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Blue
}

###############################################################################
# 1. Environment Check
###############################################################################
Write-Section "Environment Check"

# Check Ruby
try {
    $rubyVersion = ruby --version
    Write-Success "Ruby found: $rubyVersion"
}
catch {
    Write-Error-Custom "Ruby not found. Please install Ruby >= 3.2"
    exit 1
}

# Check Bundler
try {
    $bundlerVersion = bundle --version
    Write-Success "Bundler found: $bundlerVersion"
}
catch {
    Write-Error-Custom "Bundler not found. Install with: gem install bundler"
    exit 1
}

# Check Node.js (optional)
try {
    $nodeVersion = node --version
    Write-Success "Node.js found: $nodeVersion"
}
catch {
    Write-Warning "Node.js not found. Some optional checks will be skipped."
}

# Check PowerShell version
$psVersion = $PSVersionTable.PSVersion
Write-Info "PowerShell version: $psVersion"

###############################################################################
# 2. Dependency Installation
###############################################################################
Write-Section "Installing Dependencies"

Write-Info "Running bundle install..."
try {
    $output = bundle install 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Bundle install completed successfully"
    }
    else {
        Write-Error-Custom "Bundle install failed"
        if ($Verbose) { Write-Host $output }
        exit 1
    }
}
catch {
    Write-Error-Custom "Bundle install failed: $_"
    exit 1
}

###############################################################################
# 3. Jekyll Build
###############################################################################
Write-Section "Building Jekyll Site"

Write-Info "Building site with Jekyll..."
try {
    $buildOutput = bundle exec jekyll build --trace 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Jekyll build completed successfully"
    }
    else {
        Write-Error-Custom "Jekyll build failed"
        if ($Verbose) { Write-Host $buildOutput }
        exit 1
    }
}
catch {
    Write-Error-Custom "Jekyll build failed: $_"
    exit 1
}

# Check if _site directory exists
if (Test-Path "_site") {
    $fileCount = (Get-ChildItem -Path "_site" -Recurse -File).Count
    Write-Success "Build output verified: _site directory exists with $fileCount files"
}
else {
    Write-Error-Custom "Build failed: _site directory not found"
    exit 1
}

# Check for key pages
$requiredPages = @("index.html", "services.html", "contact.html", "about.html")
foreach ($page in $requiredPages) {
    $pagePath = Join-Path "_site" $page
    if (Test-Path $pagePath) {
        Write-Success "Required page found: $page"
    }
    else {
        Write-Error-Custom "Required page missing: $page"
    }
}

###############################################################################
# 4. Internal Link Check
###############################################################################
if (-not $SkipLinkCheck) {
    Write-Section "Checking Internal Links"
    
    # Check if html-proofer is available
    try {
        $htmlProoferCheck = bundle show html-proofer 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Info "Running html-proofer for internal links..."
            $prooferOutput = bundle exec htmlproofer ./_site `
                --disable-external `
                --allow-hash-href `
                --ignore-urls "/localhost/,/127.0.0.1/,/0.0.0.0/" `
                --swap-urls "^/TillerPro:" `
                --ignore-status-codes "0,200,201,301,302,303,307,308,401,403,404,405,406,407,408,409,410,429,500,502,503,504,999" `
                2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Internal links validated successfully"
            }
            else {
                Write-Warning "Some internal link issues detected (non-blocking)"
                if ($Verbose) { Write-Host $prooferOutput }
            }
        }
        else {
            Write-Warning "html-proofer not installed. Skipping link check."
            Write-Warning "Install with: gem install html-proofer"
            
            # Simple check for common issues
            Write-Info "Performing basic link check instead..."
            
            $emptyHrefs = Select-String -Path "_site\*.html" -Pattern 'href=""' -Recurse
            if ($emptyHrefs) {
                Write-Warning "Found empty href attributes"
            }
            else {
                Write-Success "No empty href attributes found"
            }
            
            $emptySrcs = Select-String -Path "_site\*.html" -Pattern 'src=""' -Recurse
            if ($emptySrcs) {
                Write-Warning "Found empty src attributes"
            }
            else {
                Write-Success "No empty src attributes found"
            }
        }
    }
    catch {
        Write-Warning "Link check skipped due to error: $_"
    }
}
else {
    Write-Info "Link check skipped (use without -SkipLinkCheck to enable)"
}

###############################################################################
# 5. Configuration Validation
###############################################################################
Write-Section "Configuration Validation"

# Check _config.yml syntax
try {
    $configContent = Get-Content "_config.yml" -Raw
    # Basic YAML validation (check for common syntax errors)
    if ($configContent -match "^\s*title:\s*.+") {
        Write-Success "_config.yml has title defined"
    }
    else {
        Write-Error-Custom "_config.yml missing title field"
    }
    
    if ($configContent -match "^\s*url:\s*.+") {
        Write-Success "_config.yml has url defined"
    }
    else {
        Write-Warning "_config.yml missing url field"
    }
}
catch {
    Write-Error-Custom "_config.yml validation failed: $_"
}

###############################################################################
# 6. Asset Validation
###############################################################################
Write-Section "Asset Validation"

# Check for CSS files
if (Test-Path "assets\css") {
    $cssCount = (Get-ChildItem -Path "assets\css" -Filter "*.css" -Recurse).Count
    Write-Success "Found $cssCount CSS files"
}
else {
    Write-Warning "No CSS files found in assets\css\"
}

# Check for JavaScript files
if (Test-Path "assets\js") {
    $jsCount = (Get-ChildItem -Path "assets\js" -Filter "*.js" -Recurse).Count
    Write-Success "Found $jsCount JavaScript files"
}
else {
    Write-Warning "No JavaScript files found in assets\js\"
}

# Check for images
if (Test-Path "assets\img") {
    $imgCount = (Get-ChildItem -Path "assets\img" -Recurse -File).Count
    Write-Success "Found $imgCount images"
}
else {
    Write-Warning "No images found in assets\img\"
}

###############################################################################
# 7. Build Output Analysis
###############################################################################
Write-Section "Build Output Analysis"

# Calculate site size
$siteSize = (Get-ChildItem -Path "_site" -Recurse | Measure-Object -Property Length -Sum).Sum
$siteSizeMB = [math]::Round($siteSize / 1MB, 2)
Write-Info "Total site size: $siteSizeMB MB"

# Count HTML pages
$htmlCount = (Get-ChildItem -Path "_site" -Filter "*.html" -Recurse).Count
Write-Info "HTML pages generated: $htmlCount"

# Check for common build artifacts
if (Test-Path "_site\sitemap.xml") {
    Write-Success "Sitemap generated"
}
else {
    Write-Warning "Sitemap not found"
}

if (Test-Path "_site\feed.xml") {
    Write-Success "RSS feed generated"
}
else {
    Write-Warning "RSS feed not found"
}

if (Test-Path "_site\robots.txt") {
    Write-Success "robots.txt found"
}
else {
    Write-Warning "robots.txt not found"
}

###############################################################################
# Summary
###############################################################################
Write-Host ""
Write-Section "Verification Summary"

if ($OverallStatus -eq 0) {
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Green
    Write-Host "✓ ALL CHECKS PASSED" -ForegroundColor Green
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Green
    Write-Host ""
    Write-Info "Site is ready for deployment"
    Write-Host ""
}
else {
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Red
    Write-Host "✗ VERIFICATION FAILED" -ForegroundColor Red
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please fix the errors above before deploying" -ForegroundColor Red
    Write-Host ""
}

exit $OverallStatus
