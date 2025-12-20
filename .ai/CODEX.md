# CODEX.md — Agent-Style Coding Tool Adapter

**Tool**: Codex-based agents (Cursor, Replit, autonomous agents)  
**Inherits From**: `SYSTEM.md` → `STYLE.md` + `DOMAIN.md` + `COMPLIANCE.md` + `OUTPUT_RULES.md`  
**Scope**: Context for AI coding agents with repository access and execution capabilities

---

## INHERITANCE CHAIN

This file is a **thin adapter** that inherits all authoritative rules from:

1. **`SYSTEM.md`** — Core behavioral contract, operational rules, verification checklist
2. **`STYLE.md`** — Brand voice, 48 Laws framework, language patterns, positioning
3. **`DOMAIN.md`** — TCNA 2024 standards, NJ HIC compliance, technical authority
4. **`COMPLIANCE.md`** — Legal boundaries, contract requirements, safety standards
5. **`OUTPUT_RULES.md`** — Code quality, file naming, linting, commit conventions

**See each file for complete rules**. This adapter provides agent-specific context.

---

## KEY DIFFERENCE: AUTONOMOUS EXECUTION

Unlike ChatGPT (conversational) or GitHub Copilot (assistant), agent-style tools:
- **Have full repository access** (read/write files, run commands)
- **Can execute code** (run tests, build projects, preview changes)
- **Operate semi-autonomously** (multi-step task completion)
- **Generate larger changesets** (refactors, feature implementations)

**Implications**:
1. **Higher stakes**: Agents can break things if not careful
2. **More context**: Must understand repository state before acting
3. **Testing imperative**: Must verify changes before committing
4. **Rollback awareness**: Must be prepared to undo changes

---

## AGENT-SPECIFIC OPERATIONAL RULES

### Pre-Action Requirements

**Before modifying ANY file**, agent must:
1. **Read current file state** (don't assume structure)
2. **Check dependencies** (what else uses this component?)
3. **Verify design tokens exist** (if referencing CSS variables)
4. **Review related files** (e.g., if editing SCSS, check HTML usage)
5. **Consult OUTPUT_RULES.md** for file naming and code standards

**Before running ANY command**, agent must:
1. **Verify command syntax** (check package.json scripts)
2. **Understand side effects** (does it modify files? Install packages?)
3. **Check current working directory** (am I in the right path?)
4. **Confirm dependencies installed** (`node_modules/` present? `bundle install` run?)

### Multi-File Changes

When implementing a feature that spans multiple files:
1. **Plan first**: List all files to modify and their dependencies
2. **Work in logical order**: 
   - Data structures first (`_data/*.yml`)
   - Components/includes second (`_includes/*.html`)
   - Styles third (`_sass/**/*.scss`)
   - Integration/layout last (`_layouts/*.html`, `pages/*.html`)
3. **Test incrementally**: Build after each logical group of changes
4. **Commit atomically**: Related changes in single commit

**Example**:
> **Task**: Add testimonial section to homepage
> 
> **Agent plan**:
> 1. Create `_data/testimonials.yml` (3 sample testimonials)
> 2. Create `_includes/testimonial-card.html` (component)
> 3. Create `_sass/30-components/_testimonial-card.scss` (styles)
> 4. Import SCSS in `_sass/main.scss`
> 5. Add section to `_layouts/home.html` (usage)
> 6. Run `npm run build:css` (compile SCSS)
> 7. Run `bundle exec jekyll build` (verify no errors)
> 8. Commit: `feat(home): add testimonial section with star ratings`
> 
> **Test points**:
> - After step 4: Check if styles compile without errors
> - After step 5: Preview site at localhost:4000
> - After step 7: Verify _site/ output is correct
> - After step 8: Run `npm run lint` before push

### Build Process Awareness

**Jekyll + SCSS workflow**:
```bash
# 1. Edit SCSS files (_sass/**/*.scss)
# 2. Compile CSS
npm run build:css

# 3. Edit HTML/Liquid files (_includes/, _layouts/, pages/)
# 4. Build Jekyll site
bundle exec jekyll build

# 5. Preview (optional)
bundle exec jekyll serve
# Visit http://localhost:4000

# 6. Lint before commit
npm run lint

# 7. Commit with Conventional Commits format
git add .
git commit -m "feat(component): add feature description"

# 8. Push (triggers Netlify deploy)
git push origin main
```

**Critical**: Agent must run `npm run build:css` after ANY SCSS change, or styles won't apply.

---

## TASK DECOMPOSITION

### Complex Feature Implementation

When given a high-level task (e.g., "add portfolio section"), agent must:
1. **Break down into subtasks**:
   - Create data structure (`_data/portfolio.yml`)
   - Create card component (`_includes/portfolio-card.html`)
   - Create grid layout styles (`_sass/30-components/_portfolio.scss`)
   - Add to relevant pages (`pages/portfolio.html`)
   - Update navigation (`_data/navigation.yml`)
2. **Identify dependencies**: What design tokens needed? What icons? What existing patterns?
3. **Determine order**: Data → Component → Styles → Integration
4. **Plan testing**: How to verify each step works?
5. **Write commit message**: `feat(portfolio): add filterable portfolio grid with lightbox`

### Refactoring Existing Code

When refactoring (e.g., "migrate footer to CSS Grid"):
1. **Understand current implementation**: Read existing code thoroughly
2. **Identify all usages**: Search for references (includes, layouts, pages)
3. **Plan migration path**: Can it be done incrementally? Or all-at-once?
4. **Preserve functionality**: No feature regressions allowed
5. **Update tests/docs**: If relevant
6. **Commit with explanation**: `refactor(footer): replace flexbox with CSS Grid layout`

---

## ERROR HANDLING & RECOVERY

### When Build Fails

If `bundle exec jekyll build` fails:
1. **Read error message** carefully (Liquid syntax? YAML parsing? Missing file?)
2. **Check recent changes**: What did I just modify?
3. **Isolate the problem**: Comment out recent changes, rebuild
4. **Fix incrementally**: Uncomment/fix one section at a time
5. **Document the issue**: Add comment explaining the fix

### When Styles Don't Apply

If CSS changes don't appear on site:
1. **Verify compilation**: Did `npm run build:css` run? Any errors?
2. **Check file paths**: Is `assets/css/main.css` updated?
3. **Verify linking**: Is `<link>` tag in `_includes/head.html` correct?
4. **Clear caches**: Hard refresh browser (Cmd+Shift+R / Ctrl+F5)
5. **Check specificity**: Is another rule overriding?

### When Linter Fails

If `npm run lint` fails:
1. **Read errors**: HTMLHint? ESLint? Stylelint?
2. **Fix auto-fixable**: Run `npx eslint . --fix` for JS
3. **Fix manually**: HTMLHint errors require manual fixes
4. **Re-run**: Verify all errors resolved
5. **Don't commit with lint errors**: CI will fail

---

## TESTING REQUIREMENTS

### Before Committing

Agent must verify:
- [ ] **Build succeeds**: `bundle exec jekyll build` (exit code 0)
- [ ] **CSS compiled**: `npm run build:css` (exit code 0)
- [ ] **Linters pass**: `npm run lint` (exit code 0)
- [ ] **Visual check**: Preview at localhost:4000, spot-check changes
- [ ] **Accessibility check**: Run Lighthouse in DevTools, score ≥95 (Accessibility)
- [ ] **Mobile check**: Test responsive breakpoints (768px, 1024px)
- [ ] **Browser check**: Chrome, Safari, Firefox (if major change)

### Automated Testing (Current)

Repository has minimal automated tests. Agent can enhance:
```bash
# Current CI checks (.github/workflows/ci.yml)
npm ci              # Install dependencies
npm run lint        # HTMLHint + ESLint
bundle install      # Install Ruby dependencies
bundle exec jekyll build  # Verify Jekyll builds

# Future enhancements (not yet implemented)
npm run test:a11y   # Accessibility tests (Axe/Pa11y)
npm run test:perf   # Performance tests (Lighthouse CI)
npm run test:visual # Visual regression (BackstopJS/Percy)
```

### Manual Testing Scenarios

For major changes, agent should test:
1. **Navigation**: All links work, mobile nav toggles correctly
2. **Forms**: Validation works, submissions handle errors
3. **Responsive**: Check 320px (mobile), 768px (tablet), 1024px (desktop), 1920px (large desktop)
4. **Accessibility**: Keyboard navigation (Tab, Enter, Esc), screen reader landmarks
5. **Performance**: Lighthouse audit (Performance ≥90, Accessibility ≥95)

---

## COMMIT CONVENTIONS

### Conventional Commits Format

**Required format**:
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `refactor`: Code refactor (no functionality change)
- `style`: Code formatting (no logic change)
- `docs`: Documentation only
- `perf`: Performance improvement
- `test`: Add/update tests
- `chore`: Maintenance (dependencies, build config)

**Scope** (optional but recommended):
- Component name: `(hero)`, `(nav)`, `(footer)`
- Feature area: `(portfolio)`, `(reviews)`, `(services)`
- Technical area: `(css)`, `(js)`, `(jekyll)`

**Subject**:
- Imperative mood: "add feature" not "added feature"
- No capital first letter (unless proper noun)
- No period at end
- Max 72 characters

**Body** (optional, use for complex changes):
- Explain WHAT changed and WHY (not HOW—that's in the code)
- List related changes as bullet points
- Reference issues/discussions if relevant

**Footer** (optional):
- `BREAKING CHANGE:` for breaking API changes
- `Closes #123` for issue resolution
- `Co-authored-by:` for collaboration

### Example Commits

**Simple feature**:
```
feat(testimonials): add star rating display

Add visual star rating (1-5 stars) to testimonial cards.
Uses SVG icons with aria-label for accessibility.
```

**Bug fix**:
```
fix(nav): hide mobile drawer elements on desktop

Replaced @container queries with @media (max-width: 920px).
Added explicit display: none for drawer-specific elements.

Resolves issue where "close" and "menu" text appeared on desktop.
```

**Refactor**:
```
refactor(footer): migrate to CSS Grid layout

- Replace flexbox with CSS Grid (1fr 2fr 1fr columns)
- Remove <details>/<summary> accordions
- Create semantic .footer-nav-column structure
- Reduce footer.html from 237 to 141 lines

Improves maintainability and responsive behavior.
```

**Multiple files**:
```
feat(portfolio): add filterable portfolio grid

- Create _data/portfolio.yml with project metadata
- Add portfolio-card component with lightbox support
- Style grid with CSS Grid (3 columns desktop, 1 column mobile)
- Add filter buttons for project categories (Bath, Kitchen, Commercial)
- Update navigation to include Portfolio link

Uses design tokens for consistency. Lighthouse score: 92 (Performance).
```

---

## COLLABORATION WITH HUMAN DEVELOPER

### Communication Patterns

**When agent is unsure**:
- **Ask clarifying questions**: "Should the hero background be `sacred-tile` or `geometric` pattern?"
- **Provide options**: "I can implement this as a modal or a slide-out panel. Which do you prefer?"
- **Explain trade-offs**: "CSS Grid is cleaner but requires IE11 fallback. Flexbox works everywhere but is more complex. Which priority?"

**When agent completes a task**:
- **Summarize changes**: "I've added the testimonial section to the homepage. Modified 4 files: _data/testimonials.yml, _includes/testimonial-card.html, _sass/30-components/_testimonial-card.scss, _layouts/home.html."
- **Show test results**: "Build succeeded. Linters pass. Lighthouse: 93 Performance, 100 Accessibility."
- **Request review**: "Ready to commit? Or do you want to review the testimonial card styling first?"

**When agent encounters errors**:
- **Report immediately**: "Jekyll build failed with YAML parsing error in _data/portfolio.yml (line 42)."
- **Explain attempted fixes**: "I tried correcting the indentation, but the issue persists. Can you check the raw YAML?"
- **Provide context**: "This started after adding the new project entries. Previous build was successful."

### Human Review Checkpoints

Agent should pause for human review:
1. **Before major refactors**: "I'm about to refactor the entire header component. Confirm?"
2. **Before deleting code**: "Removing 200 lines from footer.html (duplicate content). Confirm before proceeding?"
3. **Before changing data structures**: "Modifying _data/services.yml schema will break existing includes. Should I update those too?"
4. **After CI failures**: "CI failed on lint errors. I've fixed them locally—push again?"

---

## SECURITY & SAFETY

### Dangerous Operations

**Agent must NEVER**:
- Commit sensitive data (API keys, credentials, client info)
- Delete files without explicit confirmation
- Run `rm -rf` or similar destructive commands
- Install unvetted npm packages
- Expose internal paths in client-facing code
- Hardcode personal information (addresses, phone numbers)

**Agent must ALWAYS**:
- Check `.gitignore` before committing
- Verify no `console.log()` with sensitive data
- Use environment variables for secrets
- Sanitize user inputs in forms/scripts
- Follow OWASP best practices for web security

### Repository Integrity

**Before pushing**:
- [ ] All tests pass locally
- [ ] No uncommitted changes (or intentional)
- [ ] Commit message follows Conventional Commits
- [ ] No merge conflicts (if working on branch)
- [ ] `.gitignore` prevents sensitive files
- [ ] Large files optimized (images compressed, no unnecessary node_modules)

---

## EDGE CASES

### When Instructions Conflict

If agent detects conflicting rules:
1. **SYSTEM.md supersedes all** (core behavioral contract)
2. **COMPLIANCE.md supersedes STYLE.md** (legal > preferences)
3. **OUTPUT_RULES.md supersedes personal preference** (standards > agent's "better idea")
4. **Flag the conflict** to human: "STYLE.md says X, but COMPLIANCE.md requires Y. Using Y per hierarchy."

### When External Dependencies Change

If npm packages or Ruby gems have breaking changes:
1. **Don't auto-update** without human approval
2. **Document the issue**: "Package X has security vulnerability. Recommend update to version Y."
3. **Test thoroughly**: Update, rebuild, run full test suite
4. **Commit separately**: `chore(deps): update lodash to 4.17.21 (security patch)`

### When User Requests Non-Standard Approach

If human asks for something that violates OUTPUT_RULES.md:
1. **Gently push back**: "That would use inline styles, which violates OUTPUT_RULES.md §2.1. Can we use a utility class instead?"
2. **Explain the reasoning**: "Inline styles have higher specificity and make maintenance harder."
3. **Offer alternatives**: "We could add a custom class or use data attributes with CSS."
4. **Defer to human**: "If you still want inline styles, I'll implement it—just confirming first."

---

## VERIFICATION CHECKLIST

Before committing changes, agent must verify:
- [ ] Read SYSTEM.md, consulted relevant domain files (STYLE, DOMAIN, COMPLIANCE, OUTPUT_RULES)
- [ ] All files follow OUTPUT_RULES.md conventions (naming, structure, standards)
- [ ] Code builds successfully (`bundle exec jekyll build` + `npm run build:css`)
- [ ] Linters pass without errors (`npm run lint`)
- [ ] Visual check completed (previewed at localhost:4000)
- [ ] Accessibility verified (keyboard nav, ARIA attributes, color contrast)
- [ ] Responsive design tested (320px, 768px, 1024px breakpoints)
- [ ] Commit message follows Conventional Commits format
- [ ] No sensitive data in commit (checked .gitignore, no credentials)
- [ ] Related files updated (if component changed, check usages)

---

**Version**: 1.0.0  
**Last Updated**: December 20, 2025  
**Tool**: Codex-based agents (Cursor, Replit, autonomous agents)  
**Authority**: Inherits from SYSTEM.md (master) + all domain files  
**Key Capability**: Repository access + command execution + semi-autonomous operation
