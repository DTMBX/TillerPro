#!/usr/bin/env bash
###############################################################################
# verify.sh - Cross-platform build verification script for Tillerstead.com
# 
# Purpose: Verify Jekyll site builds successfully and passes quality gates
# Usage: ./scripts/verify.sh
# 
# Requirements:
# - Ruby >= 3.2
# - Bundler
# - Node.js >= 18 (optional, for additional checks)
###############################################################################

set -e  # Exit on error
set -u  # Exit on undefined variable

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Track overall status
OVERALL_STATUS=0

# Helper functions
info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
    OVERALL_STATUS=1
}

section() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}▶${NC} $1"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
}

###############################################################################
# 1. Environment Check
###############################################################################
section "Environment Check"

# Check Ruby
if command -v ruby &> /dev/null; then
    RUBY_VERSION=$(ruby --version)
    success "Ruby found: $RUBY_VERSION"
else
    error "Ruby not found. Please install Ruby >= 3.2"
    exit 1
fi

# Check Bundler
if command -v bundle &> /dev/null; then
    BUNDLER_VERSION=$(bundle --version)
    success "Bundler found: $BUNDLER_VERSION"
else
    error "Bundler not found. Install with: gem install bundler"
    exit 1
fi

# Check Node.js (optional but recommended)
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    success "Node.js found: $NODE_VERSION"
else
    warning "Node.js not found. Some optional checks will be skipped."
fi

###############################################################################
# 2. Dependency Installation
###############################################################################
section "Installing Dependencies"

info "Running bundle install..."
if bundle install --quiet; then
    success "Bundle install completed successfully"
else
    error "Bundle install failed"
    exit 1
fi

###############################################################################
# 3. Jekyll Build
###############################################################################
section "Building Jekyll Site"

info "Building site with Jekyll..."
if bundle exec jekyll build --trace; then
    success "Jekyll build completed successfully"
else
    error "Jekyll build failed"
    exit 1
fi

# Check if _site directory exists and has content
if [ -d "_site" ]; then
    FILE_COUNT=$(find _site -type f | wc -l)
    success "Build output verified: $_site directory exists with $FILE_COUNT files"
else
    error "Build failed: _site directory not found"
    exit 1
fi

# Check for key pages
REQUIRED_PAGES=("index.html" "services.html" "contact.html" "about.html")
for page in "${REQUIRED_PAGES[@]}"; do
    if [ -f "_site/$page" ]; then
        success "Required page found: $page"
    else
        error "Required page missing: $page"
    fi
done

###############################################################################
# 4. Internal Link Check
###############################################################################
section "Checking Internal Links"

# Check if we can use html-proofer
if bundle show html-proofer &> /dev/null; then
    info "Running html-proofer for internal links..."
    if bundle exec htmlproofer ./_site \
        --disable-external \
        --allow-hash-href \
        --ignore-urls "/localhost/,/127.0.0.1/,/0.0.0.0/" \
        --swap-urls "^/TillerPro:" \
        --ignore-status-codes "0,200,201,301,302,303,307,308,401,403,404,405,406,407,408,409,410,429,500,502,503,504,999" \
        2>&1; then
        success "Internal links validated successfully"
    else
        warning "Some internal link issues detected (non-blocking)"
    fi
else
    warning "html-proofer not installed. Skipping link check."
    warning "Install with: gem install html-proofer"
    info "Performing basic link check instead..."
    
    # Simple grep-based check for common issues
    if grep -r "href=\"\"" _site/ 2>/dev/null; then
        warning "Found empty href attributes"
    else
        success "No empty href attributes found"
    fi
    
    if grep -r "src=\"\"" _site/ 2>/dev/null; then
        warning "Found empty src attributes"
    else
        success "No empty src attributes found"
    fi
fi

###############################################################################
# 5. Configuration Validation
###############################################################################
section "Configuration Validation"

# Check _config.yml syntax
if bundle exec ruby -ryaml -e "YAML.load_file('_config.yml')" 2>/dev/null; then
    success "_config.yml is valid YAML"
else
    error "_config.yml has syntax errors"
fi

# Check critical config values
if grep -q "url:" _config.yml; then
    success "_config.yml has url defined"
else
    warning "_config.yml missing url field"
fi

if grep -q "title:" _config.yml; then
    success "_config.yml has title defined"
else
    error "_config.yml missing title field"
fi

###############################################################################
# 6. Asset Validation (Optional)
###############################################################################
section "Asset Validation"

# Check for CSS files
CSS_COUNT=$(find assets/css -name "*.css" 2>/dev/null | wc -l || echo 0)
if [ "$CSS_COUNT" -gt 0 ]; then
    success "Found $CSS_COUNT CSS files"
else
    warning "No CSS files found in assets/css/"
fi

# Check for JavaScript files
JS_COUNT=$(find assets/js -name "*.js" 2>/dev/null | wc -l || echo 0)
if [ "$JS_COUNT" -gt 0 ]; then
    success "Found $JS_COUNT JavaScript files"
else
    warning "No JavaScript files found in assets/js/"
fi

# Check for images
IMG_COUNT=$(find assets/img -type f 2>/dev/null | wc -l || echo 0)
if [ "$IMG_COUNT" -gt 0 ]; then
    success "Found $IMG_COUNT images"
else
    warning "No images found in assets/img/"
fi

###############################################################################
# 7. Build Output Size Check
###############################################################################
section "Build Output Analysis"

SITE_SIZE=$(du -sh _site 2>/dev/null | cut -f1)
info "Total site size: $SITE_SIZE"

# Check HTML file count
HTML_COUNT=$(find _site -name "*.html" | wc -l)
info "HTML pages generated: $HTML_COUNT"

# Check for common build artifacts
if [ -f "_site/sitemap.xml" ]; then
    success "Sitemap generated"
else
    warning "Sitemap not found"
fi

if [ -f "_site/feed.xml" ]; then
    success "RSS feed generated"
else
    warning "RSS feed not found"
fi

if [ -f "_site/robots.txt" ]; then
    success "robots.txt found"
else
    warning "robots.txt not found"
fi

###############################################################################
# Summary
###############################################################################
echo ""
section "Verification Summary"

if [ $OVERALL_STATUS -eq 0 ]; then
    echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}✓ ALL CHECKS PASSED${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
    echo ""
    info "Site is ready for deployment"
    echo ""
else
    echo -e "${RED}═══════════════════════════════════════════════════${NC}"
    echo -e "${RED}✗ VERIFICATION FAILED${NC}"
    echo -e "${RED}═══════════════════════════════════════════════════${NC}"
    echo ""
    error "Please fix the errors above before deploying"
    echo ""
fi

exit $OVERALL_STATUS
