# Theme Cleanup Report

Generated: December 8, 2025

## Files Identified for Removal

### ❌ OLD/UNUSED DIRECTORIES

#### 1. `/src/scss/` (280+ lines)
**Status**: SAFE TO REMOVE
**Reason**: Duplicate old SCSS structure, not imported in main-build.scss
**Contents**:
- `_common.scss`
- `theme.scss` 
- `components/` directory with old components
- `layouts/` directory
- `utilities/` directory
- `README.md`

**Impact**: None - not referenced anywhere in the build

#### 2. `/src/assets/patterns/` 
**Status**: SAFE TO REMOVE
**Reason**: Old pattern assets, SVG patterns now in `assets/img/patterns/`
**Impact**: None - duplicates existing patterns

### 🔄 FILES TO RENAME

#### 1. `assets/css/main-build.scss` → `assets/css/main.scss`
**Reason**: Jekyll convention - needs to be `main.scss` to compile to `main.css`
**Current State**: Has front-matter (---), imports all new modular SCSS
**Impact**: Critical - fixes CSS compilation path

### ✅ FILES TO KEEP (Current Active Theme)

#### In `_sass/` directory:
- `base/_tokens.scss` ✅ Active
- `base/_reset.scss` ✅ Active (NEW)
- `base/_typography.scss` ✅ Active (NEW)
- `layout/_container.scss` ✅ Active (NEW)
- `layout/_grid.scss` ✅ Active
- `components/_buttons.scss` ✅ Active (NEW)
- `components/_cards.scss` ✅ Active (NEW)
- `components/_forms.scss` ✅ Active (NEW)
- `components/_header.scss` ✅ Active (NEW)
- `components/_footer.scss` ✅ Active (NEW)
- `components/_hero.scss` ✅ Active (NEW)
- `components/_theme.scss` ✅ Active (Legacy compatibility)
- `utilities/_helpers.scss` ✅ Active

## Why These Files Are Safe to Remove

### `/src/scss/` Analysis

**Not imported anywhere:**
```bash
# Searched for: @import.*src/scss
# Results: 0 matches in HTML/SCSS files
```

**Not referenced in build:**
```scss
# Current main-build.scss uses:
@import "base/tokens";           // From _sass/base/
@import "base/reset";            // From _sass/base/
@import "components/buttons";    // From _sass/components/
# NOT: @import "src/scss/..."
```

**Duplicate functionality:**
- Old `src/scss/components/_buttons.scss` duplicates `_sass/components/_buttons.scss`
- Old `src/scss/components/_cards.scss` duplicates `_sass/components/_cards.scss`
- etc.

## Cleanup Plan

### Step 1: Rename Main Build File
```bash
mv assets/css/main-build.scss assets/css/main.scss
```

**Update references in documentation:**
- MODERN_THEME_DOCS.md
- THEME_QUICKSTART.md
- THEME_VISUAL_GUIDE.md

### Step 2: Remove Old SCSS Directory
```bash
rm -rf src/scss/
```

**Backup first (optional):**
```bash
tar -czf theme-backup-$(date +%Y%m%d).tar.gz src/scss/
```

### Step 3: Remove Old Assets
```bash
rm -rf src/assets/
```

### Step 4: Clean Build Directory
```bash
rm -rf _site/
```

### Step 5: Rebuild
```bash
bundle exec jekyll build
```

**Expected output:**
- New `_site/assets/css/main.css` generated from `main.scss`
- All new modern theme styles compiled
- No errors or conflicts

## Risk Assessment

### Low Risk ✅
- Removing `/src/scss/` - Not referenced anywhere
- Removing `/src/assets/` - Duplicates of existing assets
- Cleaning `_site/` - Temporary build directory

### Medium Risk ⚠️
- Renaming `main-build.scss` - Need to update docs
- **Mitigation**: Update references in 3 documentation files

### Critical Dependencies ✅
All critical files are in `_sass/` and actively imported:
- Design tokens: `_sass/base/_tokens.scss`
- Components: `_sass/components/*.scss`
- Layouts: `_sass/layout/*.scss`

## Testing Checklist

After cleanup:
- [ ] Run `bundle exec jekyll build` - Should succeed
- [ ] Check `_site/assets/css/main.css` exists
- [ ] Verify no 404s for CSS
- [ ] Test homepage renders correctly
- [ ] Check responsive design works
- [ ] Validate all components display properly

## Size Reduction

**Estimated space freed:**
- `/src/scss/`: ~45 KB
- `/src/assets/`: ~15 KB
- `_site/`: Varies (regenerated on build)
- **Total**: ~60 KB of dead code removed

## Next Steps

1. Execute cleanup script: `./scripts/cleanup-old-theme.sh --backup`
2. Or manually follow Step 1-5 above
3. Run full rebuild
4. Test site thoroughly
5. Commit changes

## Notes

The new modern theme in `_sass/` is:
- ✅ More organized (base → layout → components → utilities)
- ✅ Better documented
- ✅ HTML5 & CSS3 compliant
- ✅ Mobile-first responsive
- ✅ Accessibility-focused
- ✅ Modular and maintainable

Old `/src/scss/` was an earlier attempt that has been superseded.
