# Tillerstead.com

Professional tile and stone installation website for Tillerstead LLC, a New Jersey licensed Home Improvement Contractor (HIC #13VH10808800).

## Quick Start

```bash
# Install dependencies
bundle install
npm ci

# Start development server
bundle exec jekyll serve --livereload

# Or use the helper script
pwsh dev.ps1 serve
```

Site will be available at http://localhost:4000

## Prerequisites

| Tool | Version | Check |
|------|---------|-------|
| Ruby | 3.3.x | `ruby -v` |
| Bundler | ≥2.3 | `bundle -v` |
| Node.js | ≥18 (22 LTS recommended) | `node -v` |
| npm | ≥9 | `npm -v` |

### Windows Setup

```powershell
# Install Ruby via RubyInstaller (https://rubyinstaller.org/)
# Install Node.js via nvm-windows or official installer

# Install Bundler
gem install bundler

# Install dependencies
bundle install
npm ci
```

### macOS/Linux Setup

```bash
# Install Ruby via rbenv or asdf
rbenv install 3.3.10
rbenv local 3.3.10

# Install Node.js via nvm
nvm install 22
nvm use 22

# Install dependencies
bundle install
npm ci
```

## Development

### Available Commands

| Command | Description |
|---------|-------------|
| `npm run dev` | Start development server with live reload |
| `npm run build` | Build site for production |
| `npm run lint` | Run all linters (CSS, JS, HTML) |
| `npm run format` | Format code with Prettier |
| `npm test` | Run Playwright navigation tests |

### Verification Scripts

Cross-platform scripts to verify the build:

```bash
# Bash (Linux/macOS/WSL)
./scripts/verify.sh

# PowerShell (Windows)
pwsh scripts/verify.ps1

# Quick mode (skip slow tests)
./scripts/verify.sh --quick
pwsh scripts/verify.ps1 -Quick
```

### Helper Script (Windows)

```powershell
pwsh dev.ps1 serve    # Start dev server
pwsh dev.ps1 build    # Build site
pwsh dev.ps1 clean    # Clean build artifacts
pwsh dev.ps1 test     # Run build test
```

## Architecture

### Tech Stack

- **Static Site Generator:** Jekyll 4.4.1
- **CSS:** Native CSS with custom properties (design tokens)
- **JavaScript:** ES Modules with progressive enhancement
- **Build:** npm scripts + Jekyll
- **Testing:** Playwright, pa11y-ci, Lighthouse CI
- **Linting:** ESLint, Stylelint, html-validate, Prettier

### Directory Structure

```
├── _config.yml          # Jekyll configuration
├── _data/               # YAML data files
├── _includes/           # Reusable HTML components
├── _layouts/            # Page templates
├── _posts/              # Blog posts
├── assets/
│   ├── css/             # Stylesheets (design tokens in root-vars.css)
│   ├── js/              # JavaScript modules
│   ├── img/             # Images
│   └── icons/           # SVG icons
├── scripts/             # Build and utility scripts
└── tests/               # Playwright tests
```

### Design Tokens

All design tokens are defined in `assets/css/root-vars.css`:

- Colors: `--tiller-color-*`, `--tiller-bg-*`
- Spacing: `--tiller-spacing-*` (responsive with clamp)
- Typography: `--tiller-font-size-*` (responsive with clamp)
- Shadows: `--tiller-shadow-*`
- Border radius: `--tiller-border-radius-*`
- Transitions: `--tiller-transition-*`

WCAG-compliant tokens include `-wcag` suffix for accessible contrast.

## Deployment

### GitHub Pages (Primary)

Automatically deploys on push to `main` via GitHub Actions:

1. CI workflow runs linting, build, and tests
2. Jekyll workflow builds and deploys to GitHub Pages
3. Site is live at https://tillerstead.com

### Netlify (Parallel)

Also configured for Netlify deployment via `netlify.toml`.

## Quality Assurance

### Automated Checks (CI)

- **ESLint:** JavaScript linting
- **Stylelint:** CSS linting
- **html-validate:** HTML validation
- **Playwright:** Navigation tests
- **npm audit:** Security vulnerability scanning
- **Lighthouse CI:** Performance monitoring

### Accessibility

- WCAG 2.1 AA compliance target
- pa11y-ci with axe-core runner
- Skip-to-content links
- Focus-visible states
- Reduced motion support

### Performance

- Critical CSS extraction
- Image optimization (WebP, AVIF)
- Service worker for offline support
- Lazy loading for images

## Contributing

1. Create a feature branch from `main`
2. Make changes
3. Run verification: `./scripts/verify.sh`
4. Submit a pull request

## License

MIT License - see [LICENSE](LICENSE)

## Contact

Tillerstead LLC  
HIC #13VH10808800  
https://tillerstead.com
