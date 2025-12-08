# 🔧 HOMEPAGE NOT UPDATING? READ THIS!

## TL;DR - Quick Fix

```bash
# Run this command EVERY TIME you edit files:
npm run build

# Then refresh your browser with hard reload:
# Chrome/Edge: Ctrl+Shift+R
# Firefox: Ctrl+F5
# Mac: Cmd+Shift+R
```

## Why Your Homepage Looks The Same

Jekyll is a **static site generator**. It doesn't auto-update. You MUST rebuild.

### What Needs Rebuilding?

When you edit these, you MUST run `npm run build`:
- ✏️ Any HTML file (`index.html`, pages, etc.)
- ✏️ Any template (`_includes/`, `_layouts/`)
- ✏️ Any SCSS/CSS file (`_sass/`, `assets/css/`)
- ✏️ Any data file (`_data/`)
- ✏️ `_config.yml`

### The Build Process

1. **Edit your files** (HTML, SCSS, templates, etc.)
2. **Run `npm run build`** (compiles CSS + generates static HTML)
3. **Hard refresh browser** (clear cache: Ctrl+Shift+R)
4. **Check result**

## Build Commands

```bash
# MAIN COMMAND - Use this most of the time
npm run build

# Alternative - Full clean rebuild
./rebuild.sh

# For development with auto-reload
npm run dev
# Then open http://localhost:4000
```

## Common Problems

### "I edited the file but nothing changed!"
- ❌ You forgot to run `npm run build`
- ❌ You're looking at cached version (hard refresh!)
- ❌ You edited `_site/` directly (it gets overwritten!)

✅ **Always edit source files, then rebuild**

### "CSS changes not showing"
```bash
# Force CSS rebuild
npm run build:css
bundle exec jekyll build
```

### "Logo not updating"
```bash
# Clear browser cache completely, or
# Hard refresh: Ctrl+Shift+R
```

### "Still broken after rebuild"
```bash
# Nuclear option - clean everything
rm -rf _site assets/css/main.css
npm run build
```

## Development Workflow

### Option 1: Manual Build (Recommended for Single Changes)
```bash
# 1. Edit files
vim index.html

# 2. Build
npm run build

# 3. View result
# Open _site/index.html in browser
# Or: npm run dev (starts server)
```

### Option 2: Dev Server (Recommended for Active Development)
```bash
# Start server with auto-rebuild
npm run dev

# Opens at http://localhost:4000
# Auto-rebuilds on file changes
# Live reload in browser
```

**Note**: If you edit `_config.yml`, you MUST restart the dev server!

## File Structure

```
Source Files (YOU EDIT THESE):
├── index.html              ← Edit this
├── _includes/              ← Edit these templates
├── _layouts/               ← Edit these layouts
├── _sass/                  ← Edit these styles
├── assets/css/main.scss    ← Main stylesheet
└── _config.yml             ← Site config

Generated Files (DON'T EDIT):
└── _site/                  ← Built by Jekyll (gets overwritten!)
    ├── index.html          ← Generated from your source
    ├── assets/css/main.css ← Compiled from SCSS
    └── ...                 ← All generated files
```

## Generate High-Quality PNG Logos

The site uses SVG logos by default. To generate PNG versions:

```bash
# Install ImageMagick first (if not installed)
sudo apt-get update && sudo apt-get install -y imagemagick

# Generate PNGs from SVGs
npm run build:logos
```

This creates:
- `tillerstead-logo-header.png` (1x, 2x, 3x)
- `tillerstead-logo-mark.png` (1x, 2x, 512px)
- `tillerstead-logo-full.png` (1x, 2x)
- And more...

All in `assets/img/logo/` directory.

## Troubleshooting Checklist

- [ ] Did you run `npm run build`?
- [ ] Did you hard refresh browser? (Ctrl+Shift+R)
- [ ] Did you edit source files (not `_site/`)?
- [ ] Is `_site/index.html` recent? (`ls -lh _site/index.html`)
- [ ] Is `assets/css/main.css` compiled? (`ls -lh assets/css/main.css`)
- [ ] Any errors in build output?
- [ ] Did you restart dev server after editing `_config.yml`?

## Still Not Working?

Check the detailed guide:
```bash
cat .github/instructions/build-troubleshooting.md
```

Or get help:
1. Check build output for errors
2. Run `JEKYLL_TRACE=1 bundle exec jekyll build` for verbose output
3. Check browser console (F12) for JavaScript errors
4. Verify file timestamps match your edits

---

## Remember

**The golden rule**: 
> Edit source → Build → Hard refresh

Jekyll is **not** WordPress. It's a **static site generator**.
Think of it like compiling code - you must rebuild after changes!
