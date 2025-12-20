# OUTPUT_RULES.md — Code Quality Standards

**Inherits From**: `SYSTEM.md`  
**Scope**: Code standards, linting, formatting, testing, performance  
**Authority**: Project conventions, industry best practices

---

## PURPOSE

This file defines technical quality standards for all code, documentation, and assets generated or modified by AI tools. All outputs must meet these requirements before commit/push.

---

## FILE NAMING CONVENTIONS

### HTML Files
- **Format**: `kebab-case.html`
- **Examples**: `theme-demo.html`, `service-page.html`, `about-us.html`
- **Root pages**: Can use single word (`index.html`, `success.html`, `404.html`)

### CSS/SCSS Files
- **Format**: `kebab-case.css` or `_partial-name.scss`
- **Examples**: `theme.css`, `_header.scss`, `_tokens.scss`
- **Partials**: Must start with underscore (`_component-name.scss`)
- **Compiled output**: `main.css`, `theme.css`

### JavaScript Files
- **Format**: `camelCase.js` or `kebab-case.js` (prefer camelCase)
- **Examples**: `agent.js`, `nav.js`, `formValidation.js`
- **Modules**: Use descriptive names (`scrollHandler.js`, `reviewsApi.js`)

### Images & SVG
- **Format**: `kebab-case.svg|png|jpg|webp`
- **Examples**: `sacred-tile.svg`, `hero-background.jpg`, `logo-main.svg`
- **Patterns**: Prefix with `pattern-` (`pattern-sacred-tile.svg`)
- **Icons**: Prefix with `icon-` (`icon-chevron-down.svg`)

### Directories
- **Format**: `kebab-case/` or `_underscore-prefix/`
- **Jekyll conventions**: `_includes/`, `_layouts/`, `_sass/`
- **Examples**: `assets/`, `pages/`, `.github/workflows/`

---

## HTML STANDARDS

### Semantic Structure
```html
<!-- CORRECT: Semantic HTML5 -->
<header class="site-header">
  <nav aria-label="Primary navigation">
    <ul class="nav-list">
      <li><a href="/services">Services</a></li>
    </ul>
  </nav>
</header>

<main>
  <article class="blog-post">
    <h1>Title</h1>
    <section>Content</section>
  </article>
</main>

<footer class="site-footer">
  <address>Contact information</address>
</footer>

<!-- WRONG: Divitis -->
<div class="header">
  <div class="nav">
    <div class="nav-list">
      <div class="nav-item"><div class="link">Services</div></div>
    </div>
  </div>
</div>
```

### Required Meta Tags
```html
<!-- Every page must include -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Page Title | Tillerstead LLC</title>
<meta name="description" content="150-160 character description">

<!-- Open Graph for social sharing -->
<meta property="og:title" content="Page Title">
<meta property="og:description" content="Description">
<meta property="og:image" content="/assets/img/og-image.jpg">
<meta property="og:url" content="https://tillerstead.com/page">
<meta property="og:type" content="website">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Page Title">
<meta name="twitter:description" content="Description">
<meta name="twitter:image" content="/assets/img/twitter-card.jpg">
```

### Accessibility Requirements
```html
<!-- Image alt text (descriptive, not decorative) -->
<img src="tile.jpg" alt="Large format porcelain tile installation in modern bathroom" loading="lazy">

<!-- NOT: alt="tile" or alt="image" -->

<!-- Form labels (explicit association) -->
<label for="user-email">Email Address</label>
<input type="email" id="user-email" name="email" required>

<!-- NOT: <label>Email <input></label> -->

<!-- ARIA labels for icon buttons -->
<button aria-label="Close navigation menu" class="nav-close">
  <svg aria-hidden="true"><use href="#icon-x"></use></svg>
</button>

<!-- Landmark roles when semantic HTML isn't sufficient -->
<div role="search">
  <input type="search" aria-label="Search site">
</div>

<!-- Skip to main content link -->
<a href="#main-content" class="skip-link">Skip to main content</a>
```

### Performance Best Practices
```html
<!-- Preload critical assets -->
<link rel="preload" href="/assets/fonts/inter-var.woff2" as="font" type="font/woff2" crossorigin>

<!-- Lazy load below-the-fold images -->
<img src="image.jpg" loading="lazy" alt="Description">

<!-- Use srcset for responsive images -->
<img src="tile-800.jpg" 
     srcset="tile-400.jpg 400w, tile-800.jpg 800w, tile-1200.jpg 1200w"
     sizes="(max-width: 768px) 100vw, 50vw"
     alt="Description">

<!-- Defer non-critical scripts -->
<script src="analytics.js" defer></script>

<!-- Use type="module" for ES6 modules -->
<script type="module" src="app.js"></script>
```

### HTMLHint Compliance
```bash
# Run before committing
npx htmlhint '**/*.html'
```

**Common violations to avoid**:
- `doctype-first`: Must have `<!DOCTYPE html>` as first line
- `id-unique`: IDs must be unique per page
- `attr-lowercase`: Attributes must be lowercase
- `attr-value-double-quotes`: Use double quotes for attributes
- `tag-pair`: All opening tags must have closing tags
- `spec-char-escape`: Escape special characters in text

---

## CSS/SCSS STANDARDS

### Token-Based Design System
```scss
// CORRECT: Use design tokens
.hero {
  background: var(--gradient-primary);
  color: var(--color-on-primary);
  padding: var(--space-8) var(--space-4);
  border-radius: var(--radius-lg);
}

// WRONG: Hard-coded values
.hero {
  background: linear-gradient(135deg, #1a2332 0%, #2a3f5f 100%);
  color: #f8f9fa;
  padding: 4rem 2rem;
  border-radius: 12px;
}
```

### Available Design Tokens
```scss
// Colors (_sass/00-settings/_tokens.scss)
--color-primary      // Regal blue #2a3f5f
--color-accent       // Gold #d4af37
--color-on-primary   // Text on primary background
--color-on-accent    // Text on accent background
--color-surface      // Background surfaces
--color-border       // Borders and dividers

// Typography
--font-sans          // System font stack
--font-mono          // Monospace for code
--heading-1          // clamp(2rem, 5vw, 3rem)
--heading-2 through --heading-6

// Spacing (clamp-based, responsive)
--space-1 through --space-12

// Shadows
--shadow-soft        // Subtle elevation
--shadow-lift        // Hover/focus states

// Border Radius
--radius-sm, --radius-md, --radius-lg, --radius-pill

// Gradients
--gradient-primary, --gradient-surface, --gradient-accent
```

### Responsive Design Patterns
```scss
// Mobile-first approach (min-width)
.component {
  // Mobile styles (default)
  display: block;
  padding: var(--space-4);

  // Tablet and up
  @media (min-width: 768px) {
    display: grid;
    grid-template-columns: 1fr 2fr;
    padding: var(--space-6);
  }

  // Desktop and up
  @media (min-width: 1024px) {
    grid-template-columns: 1fr 3fr 1fr;
    padding: var(--space-8);
  }
}

// AVOID max-width unless specific reason (e.g., hiding mobile nav)
@media (max-width: 920px) {
  .desktop-only { display: none; }
}
```

### CSS Grid Over Flexbox (When Appropriate)
```scss
// PREFER: CSS Grid for 2D layouts
.footer-nav {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: var(--space-4);
}

// USE: Flexbox for 1D layouts (rows or columns)
.nav-list {
  display: flex;
  gap: var(--space-3);
  align-items: center;
}
```

### Specificity Management
```scss
// GOOD: Low specificity, utility classes
.text-primary { color: var(--color-primary); }
.mt-4 { margin-top: var(--space-4); }

// GOOD: BEM naming for components
.site-nav__item { ... }
.site-nav__item--active { ... }

// BAD: High specificity, hard to override
header nav ul li a.active { ... }
```

### Stylelint Compliance (Future)
```bash
# Will be added to CI pipeline
npx stylelint "assets/css/**/*.css" "_sass/**/*.scss"
```

**Target rules**:
- No ID selectors (`#header`)
- No `!important` unless absolutely necessary
- Use logical properties (`margin-inline`, `padding-block`)
- Prefer CSS custom properties over SCSS variables (in compiled output)

---

## JAVASCRIPT STANDARDS

### ES6+ Syntax
```javascript
// CORRECT: Modern JavaScript
const navToggle = document.querySelector('.nav-toggle');
const navDrawer = document.querySelector('.site-nav');

const toggleNav = () => {
  navDrawer.classList.toggle('is-open');
  navToggle.setAttribute('aria-expanded', 
    navDrawer.classList.contains('is-open')
  );
};

navToggle?.addEventListener('click', toggleNav);

// WRONG: Legacy syntax
var navToggle = document.querySelector('.nav-toggle');
function toggleNav() { ... }
if (navToggle !== null) { ... }
```

### Module Pattern
```javascript
// Prefer ES6 modules when appropriate
export const initNav = () => {
  // Nav initialization logic
};

export const closeNav = () => {
  // Close logic
};

// Import in main script
import { initNav, closeNav } from './nav.js';
```

### Error Handling
```javascript
// REQUIRED: Graceful failure
const fetchReviews = async () => {
  try {
    const response = await fetch('/api/reviews.json');
    if (!response.ok) throw new Error('Failed to fetch reviews');
    return await response.json();
  } catch (error) {
    console.error('Reviews fetch error:', error);
    // Show fallback UI, don't crash the page
    return [];
  }
};

// WRONG: No error handling
const fetchReviews = async () => {
  const response = await fetch('/api/reviews.json');
  return await response.json(); // Will throw on network failure
};
```

### DOM Manipulation Best Practices
```javascript
// GOOD: Batch DOM updates
const fragment = document.createDocumentFragment();
items.forEach(item => {
  const li = document.createElement('li');
  li.textContent = item.name;
  fragment.appendChild(li);
});
list.appendChild(fragment); // Single reflow

// BAD: Multiple reflows
items.forEach(item => {
  const li = document.createElement('li');
  li.textContent = item.name;
  list.appendChild(li); // Reflow on each append
});
```

### ESLint Compliance
```bash
# Run before committing
npx eslint .
```

**Key rules** (`.eslintrc.json`):
- `no-unused-vars`: No unused variables
- `no-console`: Console statements allowed (warnings)
- `prefer-const`: Use `const` when variable isn't reassigned
- `arrow-spacing`: Space around arrow function arrows
- `semi`: Semicolons required
- `quotes`: Single quotes for strings

---

## JEKYLL/LIQUID STANDARDS

### Front Matter
```yaml
---
layout: default
title: "Page Title"
description: "Meta description for SEO"
hero_title: "Main Heading"
hero_summary: "Lead paragraph"
hero_primary_url: "/contact"
hero_primary_label: "Get Estimate"
hero_bg_pattern: "sacred-tile"
---
```

### Include Usage
```liquid
<!-- CORRECT: Pass parameters explicitly -->
{% include unified-hero.html 
   title=page.hero_title 
   summary=page.hero_summary 
   cta_url=page.hero_primary_url 
%}

<!-- WRONG: Relying on implicit global scope -->
{% include unified-hero.html %}
```

### Liquid Logic (Minimal)
```liquid
<!-- Keep logic simple, move complexity to data files -->
{% for service in site.data.services %}
  {% include ts-service-card.html service=service %}
{% endfor %}

<!-- AVOID: Complex conditionals in templates -->
{% if page.layout == 'default' and page.hero_title and page.url != '/' %}
  <!-- Complex logic -->
{% endif %}
```

---

## PERFORMANCE STANDARDS

### Lighthouse Targets (Desktop)
- **Performance**: ≥ 90
- **Accessibility**: ≥ 95 (target 100)
- **Best Practices**: ≥ 95
- **SEO**: ≥ 95

### Lighthouse Targets (Mobile)
- **Performance**: ≥ 85 (acceptable), ≥ 90 (goal)
- **Accessibility**: ≥ 95
- **Best Practices**: ≥ 95
- **SEO**: ≥ 95

### Core Web Vitals
- **LCP (Largest Contentful Paint)**: < 2.5s
- **FID (First Input Delay)**: < 100ms
- **CLS (Cumulative Layout Shift)**: < 0.1

### Asset Optimization
- **Images**: Compress with ImageOptim/Squoosh (WebP preferred)
- **CSS**: Inline critical CSS (above-the-fold)
- **JS**: Defer non-critical scripts
- **Fonts**: Preload, use `font-display: swap`

---

## TESTING REQUIREMENTS

### Pre-Commit Checklist
```bash
# 1. Lint HTML
npx htmlhint '**/*.html'

# 2. Lint JavaScript
npx eslint .

# 3. Build Jekyll (verify no errors)
bundle exec jekyll build

# 4. Check for broken links (optional but recommended)
# (Add script in future)

# 5. Visual regression test (manual for now)
# Check localhost:4000 in Chrome, Firefox, Safari
```

### Browser Support
**Minimum**:
- Chrome/Edge: Last 2 versions
- Firefox: Last 2 versions
- Safari: Last 2 versions (iOS and macOS)
- Mobile Safari: iOS 12+
- Chrome Mobile: Android 8+

**Testing priorities**:
1. Chrome (primary development browser)
2. Safari (second priority, CSS Grid quirks)
3. Firefox (standards compliance check)
4. Mobile devices (iOS Safari, Chrome Android)

### Accessibility Testing
```bash
# Automated testing (future enhancement)
npm run test:a11y  # Axe-core or Pa11y

# Manual testing required
# - Keyboard navigation (Tab, Enter, Esc)
# - Screen reader (VoiceOver/NVDA basic check)
# - Contrast checker (WebAIM or built into DevTools)
```

---

## DOCUMENTATION STANDARDS

### Code Comments
```scss
// GOOD: Explain WHY, not WHAT
// Use clamp() to scale between 1rem (mobile) and 1.5rem (desktop)
// This prevents awkward jumps at breakpoints
font-size: clamp(1rem, 2vw, 1.5rem);

// BAD: Obvious statement
// Set font size to clamp
font-size: clamp(1rem, 2vw, 1.5rem);
```

### Inline Documentation
```javascript
/**
 * Toggles the mobile navigation drawer open/closed.
 * Updates aria-expanded attribute for accessibility.
 * 
 * @param {Event} event - Click event from nav-toggle button
 */
const toggleNav = (event) => {
  // Implementation
};
```

### README Updates
**When to update README**:
- Adding new npm scripts
- Changing build process
- Adding new dependencies
- Modifying file structure
- Updating deployment process

**Format**:
```markdown
## New Feature

Brief description of what changed and why.

### Usage
\`\`\`bash
npm run new-command
\`\`\`

### Impact
What developers need to know.
```

---

## GIT COMMIT STANDARDS

### Conventional Commits Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation only
- **style**: Code style (formatting, no logic change)
- **refactor**: Code refactor (no feature/fix)
- **perf**: Performance improvement
- **test**: Adding/updating tests
- **chore**: Maintenance (deps, build config)

### Examples
```bash
# Good commits
feat(hero): add background pattern support
fix(nav): hide mobile drawer elements on desktop
docs(ai): create comprehensive governance structure
refactor(footer): replace details/summary with grid layout

# Bad commits
fix: stuff
update files
changes
Fixed bug
```

### Commit Body Guidelines
```
feat(reviews): integrate Thumbtack API sync

- Add npm script `sync:thumbtack` to fetch latest reviews
- Create _data/reviews.yml auto-generation logic
- Preserve manual reviews with `source: manual` flag
- Update reviews section to display star ratings

Resolves: #42
```

---

## SECURITY STANDARDS

### Content Security Policy
```html
<!-- Eventual goal: Strict CSP -->
<meta http-equiv="Content-Security-Policy" 
      content="default-src 'self'; 
               script-src 'self' 'unsafe-inline'; 
               style-src 'self' 'unsafe-inline'; 
               img-src 'self' data: https:;">
```

### Sensitive Data
**Never commit**:
- API keys (`.env` files should be in `.gitignore`)
- Client personal information
- Passwords or credentials
- Private keys

**Use environment variables**:
```bash
# .env (not committed)
THUMBTACK_API_KEY=secret123

# Access in scripts
const apiKey = process.env.THUMBTACK_API_KEY;
```

---

## OUTPUT VERIFICATION CHECKLIST

Before generating/modifying code, verify:
- [ ] File naming follows conventions
- [ ] HTML is semantic and accessible
- [ ] CSS uses design tokens (no hard-coded values)
- [ ] JavaScript is ES6+ with error handling
- [ ] Lighthouse scores meet targets (check after)
- [ ] Browser support covers requirements
- [ ] Code is commented where necessary
- [ ] Documentation updated if needed
- [ ] Linters pass (HTMLHint, ESLint)
- [ ] Jekyll builds without errors
- [ ] Commit message follows Conventional Commits

---

**Version**: 1.0.0  
**Last Updated**: December 20, 2025  
**Authority**: Project conventions, Web Content Accessibility Guidelines (WCAG 2.1), Modern web standards
