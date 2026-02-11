# Tillerstead.com

Professional tile installation and waterproofing services website for Tillerstead LLC, a licensed New Jersey contractor specializing in TCNA-compliant tile work.

## Quick Start

### Prerequisites

- **Ruby** >= 3.2.3
- **Bundler** (install with `gem install bundler`)
- **Node.js** >= 18 (optional, for additional tooling)

### Local Development

```bash
# 1. Clone the repository
git clone https://github.com/DTMBX/TillerPro.git
cd TillerPro

# 2. Install Ruby dependencies
bundle install

# 3. Build the site
bundle exec jekyll build

# 4. Serve locally (with live reload)
bundle exec jekyll serve

# Site will be available at http://localhost:4000
```

### Verification

Run the verification script to ensure everything is working:

```bash
# Bash (Linux, macOS, WSL)
./scripts/verify.sh

# PowerShell (Windows)
.\scripts\verify.ps1
```

The verification script checks:
- ✅ Ruby and Bundler installation
- ✅ Dependency installation
- ✅ Jekyll build success
- ✅ Required pages exist
- ✅ Internal link validation
- ✅ Configuration validity
- ✅ Asset presence

## Build Commands

```bash
# Development build
bundle exec jekyll build

# Production build (optimized)
JEKYLL_ENV=production bundle exec jekyll build

# Serve with live reload
bundle exec jekyll serve --livereload

# Serve on custom port
bundle exec jekyll serve --port 4001

# Build and watch for changes
bundle exec jekyll build --watch
```

## Testing

```bash
# Run linters
npm run lint          # All linters
npm run lint:css      # CSS/SCSS linting
npm run lint:js       # JavaScript linting
npm run lint:html     # HTML validation

# Run tests
npm test              # Playwright tests

# Accessibility audit
npm run test:a11y     # Pa11y CI

# Performance audit
npm run lighthouse    # Lighthouse CI
```

## Deployment

The site is automatically deployed to GitHub Pages when changes are pushed to the `main` branch.

**Deployment Pipeline:**
1. Code pushed to `main`
2. GitHub Actions runs `.github/workflows/jekyll.yml`
3. Jekyll builds the site
4. Build artifact uploaded to GitHub Pages
5. Site deployed to https://tillerstead.com

**Manual Deployment:**
```bash
# Trigger manual deployment
gh workflow run jekyll.yml
```

## Project Structure

```
TillerPro/
├── _config.yml              # Jekyll configuration
├── _layouts/                # Page templates
├── _includes/               # Reusable components
├── _data/                   # YAML data files
├── assets/
│   ├── css/                 # Stylesheets
│   │   ├── theme.css        # Color tokens (WCAG AAA)
│   │   ├── accessibility-core.css  # A11y features
│   │   └── components/      # Component styles
│   ├── js/                  # JavaScript
│   └── img/                 # Images
├── scripts/                 # Build and utility scripts
│   ├── verify.sh            # Verification script (Bash)
│   └── verify.ps1           # Verification script (PowerShell)
├── docs/                    # Documentation
│   └── ACCESSIBILITY.md     # Accessibility guide
├── .github/
│   └── workflows/           # CI/CD workflows
├── Gemfile                  # Ruby dependencies
└── package.json             # Node.js dependencies (optional)
```

## Accessibility

This site meets **WCAG 2.2 Level AA** standards with AAA goals for color contrast.

**Key Features:**
- ✅ Skip-to-content link
- ✅ Keyboard navigation support
- ✅ Screen reader compatible
- ✅ High contrast color scheme (7:1+ ratios)
- ✅ Focus indicators on all interactive elements
- ✅ Semantic HTML5 structure
- ✅ Reduced motion support
- ✅ 44x44px touch targets on mobile

See [docs/ACCESSIBILITY.md](docs/ACCESSIBILITY.md) for complete implementation details.

## Color System

The site uses a token-based color system with guaranteed WCAG AAA compliance.

**Primary Colors:**
- Tillerstead Green: 10 shades (50-950)
- Gold Accent: 9 shades (50-900)
- Neutral Grays: 10 shades

**Semantic Tokens:**
- `--text-primary`: #111827 (16.1:1 on white)
- `--text-green`: #006b3d (8.1:1 on white)
- `--text-gold`: #9c7a14 (8.8:1 on white)
- `--btn-primary-bg`: #008751 (6.5:1 with white text)
- `--focus-color`: #d4af37 (High visibility)

All colors documented in `assets/css/theme.css` with usage guidelines.

## Troubleshooting

### Build Fails

```bash
# Clear Jekyll cache
rm -rf .jekyll-cache _site

# Clean install dependencies
rm -rf vendor/bundle
bundle install

# Rebuild
bundle exec jekyll build
```

### Ruby Version Mismatch

```bash
# Check Ruby version
ruby --version

# Install correct version with rbenv
rbenv install 3.2.3
rbenv local 3.2.3

# Or with RVM
rvm install 3.2.3
rvm use 3.2.3
```

### Bundler Issues

```bash
# Update Bundler
gem update bundler

# Or install specific version
gem install bundler -v 2.4.22
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run verification: `./scripts/verify.sh`
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

**Before submitting PR:**
- [ ] Run `./scripts/verify.sh` successfully
- [ ] Check accessibility with Lighthouse
- [ ] Verify color contrast meets WCAG AA (4.5:1 minimum)
- [ ] Test keyboard navigation
- [ ] Update documentation if needed

## License

Copyright © 2024-2026 Tillerstead LLC. All rights reserved.

This website and its content are proprietary. See [COPYRIGHT.md](COPYRIGHT.md) for details.

## Contact

- **Website**: https://tillerstead.com
- **Email**: info@tillerstead.com
- **Phone**: (609) 862-8808
- **License**: NJ HIC #13VH10808800

## Command Center

Run the interactive PowerShell command center to execute grouped maintenance tasks:

```powershell
pwsh tools/command-center.ps1
```

Select a menu option to run the associated batch (e.g., `Sync + Build`, `Backups`, or `Maintenance`).
