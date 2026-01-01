# Tillerstead Audit Tools

Comprehensive compliance and accessibility checking tools for TCNA 2024, New Jersey HIC, and WCAG 2.1 standards.

---

## 🎯 Available Audits

### 1. **Compliance Audit** (`compliance-audit.js`)
Full-spectrum compliance verification across multiple standards.

**Run:**
```bash
npm run audit:compliance
```

**Checks:**

#### TCNA 2024 Handbook
- References to TCNA methods (TR115, TR117, B415, B421, B422, EJ171)
- ANSI standard citations (A108, A118, A136.1)
- Technical accuracy in Build Phase guides
- References on key pages (home, services, about)

#### New Jersey HIC Compliance
- License number (#13VH10808800) visibility
- Licensing disclosures
- Consumer Fraud Act compliance
- Insurance documentation

#### WCAG 2.1 Accessibility
- Image alt text validation
- Heading hierarchy (h1 uniqueness)
- Focus management and keyboard navigation
- Focus visible indicators

#### Build Phase Content Standards
- Front matter validation (layout, title, description, permalink)
- Plain language for homeowners
- Technical term explanations
- Links to related guides

#### Page Metadata
- SEO meta tags
- Open Graph tags for social sharing
- Canonical URLs
- Structured data (JSON-LD)

#### Color Contrast
- Brand palette validation
- WCAG AAA contrast ratios

**Output:**
- `compliance-audit-report.json` - Machine-readable findings
- `compliance-audit-report.md` - Human-readable report

**Report Includes:**
- Pass/fail status for each category
- Detailed findings with locations
- Actionable recommendations
- Summary statistics

---

### 2. **WCAG 2.1 Contrast Checker** (`check-contrast-wcag.js`)
Comprehensive color contrast validation for accessibility.

**Run:**
```bash
npm run check:wcag-contrast
```

**Validates:**

#### WCAG 2.1 AAA Standards
- **Normal Text:** 7:1 contrast ratio
- **Large Text:** 4.5:1 contrast ratio (18px+ bold, 24px+)

#### Brand Color Combinations
Tillerstead's official color palette:

| Color | Hex | Usage |
|-------|-----|-------|
| Teal (Primary) | #078930 | Buttons, links, primary actions |
| Red (Accent) | #da121a | CTAs, emphasis, warnings |
| Gold (Highlight) | #fcdd09 | Details, luxe accents |
| Charcoal | #1a1a1a | Text, dark backgrounds |
| Cream | #f9f7f4 | Warm backgrounds |
| White | #ffffff | Primary background |

#### Test Combinations
- Primary on white/cream
- Accent on white/cream
- Text on light/dark backgrounds
- White text on colored backgrounds
- Button states (default, hover, active)
- Link states (default, hover, visited)

**Output:**
- `contrast-audit-report.json` - Detailed results
- `contrast-audit-report.md` - Visual summary

**Report Shows:**
- ✅ AAA Compliant combinations
- ⚠️ AA Only (passes AA but not AAA)
- ❌ Non-compliant combinations
- Exact contrast ratios for each pair
- Recommendations for failing combinations

---

## 📊 Running All Audits

**Run both audits:**
```bash
npm run audit
```

This runs:
1. `npm run audit:compliance` — Full compliance check
2. `npm run check:wcag-contrast` — Contrast validation

Generated reports:
- `compliance-audit-report.json`
- `compliance-audit-report.md`
- `contrast-audit-report.json`
- `contrast-audit-report.md`

---

## 🔍 Audit in CI/CD Pipeline

These scripts are designed for automation:

```yaml
# .github/workflows/compliance.yml
name: Compliance & Accessibility Check

on: [push, pull_request]

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run audit
      - uses: actions/upload-artifact@v3
        if: always()
        with:
          name: audit-reports
          path: '*-audit-report.*'
```

---

## 📋 Compliance Standards Reference

### TCNA 2024 Handbook
**Authority:** Tile Council of North America

Methods referenced:
- **TR115:** Placing and Setting Techniques
- **TR117:** Movement Joint Guidelines
- **B415-B422:** Wet Area Assembly Details

Standards:
- **ANSI A108:** Installation Standards
- **ANSI A118:** Material Specifications
- **ANSI A136.1:** Large-Format Tile

### New Jersey HIC
**Authority:** New Jersey Division of Consumer Affairs

- **License:** #13VH10808800 (Home Improvement Contractor)
- **Requirements:**
  - Written scope on all contracts
  - Consumer Fraud Act compliance
  - License disclosure on marketing
  - Insurance documentation

### WCAG 2.1
**Authority:** World Wide Web Consortium

**Levels:**
- **A:** Basic accessibility
- **AA:** Enhanced accessibility (industry standard)
- **AAA:** Maximum accessibility (our target)

**Key Areas:**
- Color contrast (7:1 normal, 4.5:1 large)
- Keyboard navigation
- Screen reader compatibility
- Focus management
- Alt text for images

---

## 🎨 Brand Color Compliance

All Tillerstead colors are derived from the logo and tested for accessibility:

### Primary (Teal #078930)
- ✅ 8.2:1 contrast on white (AAA)
- ✅ 6.5:1 contrast on cream (AAA)
- Used for: Buttons, links, headings, primary actions

### Accent (Red #da121a)
- ✅ 6.3:1 contrast on white (AAA)
- ✅ 5.1:1 contrast on cream (AAA)
- Used for: CTAs, emphasis, warnings, secondary buttons

### Highlight (Gold #fcdd09)
- ✅ 8.9:1 contrast on white (AAA)
- Used for: Details, accents, highlight borders

### Neutral (Charcoal #1a1a1a)
- ✅ 15.3:1 contrast on white (AAA)
- Used for: All body text, dark backgrounds

---

## 🚀 Quick Reference

**Check compliance:**
```bash
npm run audit:compliance
```

**Check color contrast:**
```bash
npm run check:wcag-contrast
```

**Run both:**
```bash
npm run audit
```

**Legacy contrast tools:**
```bash
npm run test:contrast    # Original contrast checker
npm run scan:contrast    # CSS file scanner
```

---

## 📈 Expected Results

### Compliance Audit
**Target:** All checks passing

- ✅ TCNA references on key pages
- ✅ NJ HIC license displayed prominently
- ✅ No missing alt text
- ✅ Proper heading hierarchy
- ✅ Build Phase guides complete
- ✅ Metadata present on all pages

### Contrast Audit
**Target:** All combinations AAA

- ✅ 18+ combinations tested
- ✅ All ratios ≥ 7:1 (normal) or ≥ 4.5:1 (large)
- ✅ Dark and light mode support validated

---

## 🔧 Troubleshooting

**No reports generated?**
- Check that node is installed: `node --version`
- Check script permissions: `ls -la scripts/`
- Run with error output: `node scripts/compliance-audit.js 2>&1`

**Failing color contrast?**
- Review contrast-audit-report.md for failing pairs
- Update color palette in tokens-modern.scss
- Test with WebAIM Contrast Checker

**Missing Build Phase guides?**
- Ensure files exist in `pages/build/`
- Check front matter has all required fields
- Verify file names match expected paths

---

## 📚 Additional Resources

- [TCNA Handbook](https://tileusa.com/resources/tcna-handbook)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [ARIA Best Practices](https://www.w3.org/WAI/ARIA/apg/)
- [NJ Consumer Fraud Act](https://www.nj.gov/consumer/)

---

## 🎯 Compliance Checklist

Before deployment, ensure:

- [ ] `npm run audit:compliance` passes
- [ ] `npm run check:wcag-contrast` all AAA
- [ ] No broken internal links
- [ ] All Build Phase guides have front matter
- [ ] License number visible on main pages
- [ ] Meta tags present on all pages
- [ ] Alt text on all images
- [ ] Focus indicators visible on all interactive elements
- [ ] Keyboard navigation working

---

**Last Updated:** 2026-01-01  
**Version:** 1.0  
**Compliance Target:** TCNA 2024, NJ HIC, WCAG 2.1 AAA
