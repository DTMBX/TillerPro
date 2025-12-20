# COPILOT.md — GitHub Copilot Adapter

**Tool**: GitHub Copilot (Editor Extension + Chat)  
**Inherits From**: `SYSTEM.md` → `STYLE.md` + `DOMAIN.md` + `COMPLIANCE.md` + `OUTPUT_RULES.md`  
**Scope**: Context-specific instructions for GitHub Copilot integration

---

## INHERITANCE CHAIN

This file is a **thin adapter** that inherits all authoritative rules from:

1. **`SYSTEM.md`** (master behavioral contract)
   - Core AI behavior rules (no fabrication, explicit uncertainty, deterministic outputs)
   - Project context (Tillerstead LLC identity, tech stack, repository architecture)
   - Operational rules (consult domain files first, follow style guides, cite sources)
   - Verification checklist

2. **`STYLE.md`** (voice and persuasion strategy)
   - Brand voice ("competent professional who refuses to suffer fools")
   - 48 Laws of Power/Seduction marketing framework
   - Language patterns (power words, humor, technical specificity, contrast)
   - Positioning strategy ("The Anti-Corner-Cutter")
   - Client avatars and pain points

3. **`DOMAIN.md`** (technical authority)
   - TCNA 2024 standards (ANSI A108/A118/A137 series)
   - Large Format Tile requirements (95% thinset coverage, C2 rating)
   - Waterproofing systems (KERDI, RedGard, Hydroban)
   - NJ HIC compliance (license #13VH10808800, Consumer Fraud Act)
   - Carpentry requirements (L/360 deflection, substrate specs)
   - Industry terminology (40+ trade-specific terms)

4. **`COMPLIANCE.md`** (legal and ethical boundaries)
   - NJ HIC contract requirements (3-day rescission, payment schedules)
   - Advertising compliance (license display, prohibited claims)
   - Safety standards (OSHA silica, fall protection)
   - Professional ethics (no ghosting, no bait-and-switch)

5. **`OUTPUT_RULES.md`** (code quality standards)
   - File naming conventions (kebab-case.html, camelCase.js)
   - HTML standards (semantic structure, accessibility, meta tags)
   - CSS/SCSS standards (design tokens, mobile-first, Grid over Flexbox)
   - JavaScript standards (ES6+, error handling, module patterns)
   - Performance targets (Lighthouse ≥90, Core Web Vitals)
   - Testing requirements (HTMLHint, ESLint, Jekyll build)
   - Commit conventions (Conventional Commits format)

---

## COPILOT-SPECIFIC INSTRUCTIONS

### Code Completion Context

When providing inline code suggestions:

1. **Prioritize design tokens** over hard-coded values
   ```scss
   // SUGGEST: background: var(--color-primary);
   // NOT: background: #2a3f5f;
   ```

2. **Use semantic HTML** automatically
   ```html
   <!-- SUGGEST: <nav aria-label="Primary navigation"> -->
   <!-- NOT: <div class="nav"> -->
   ```

3. **Include accessibility attributes** by default
   ```html
   <!-- SUGGEST: <button aria-label="Close menu"> -->
   <!-- NOT: <button> -->
   ```

4. **Prefer modern CSS patterns**
   ```scss
   // SUGGEST: display: grid; gap: var(--space-4);
   // NOT: display: flex; margin-right: 1rem;
   ```

5. **Use ES6+ JavaScript** syntax
   ```javascript
   // SUGGEST: const fetchData = async () => { ... }
   // NOT: var fetchData = function() { ... }
   ```

### Chat Interaction Patterns

When responding to Copilot Chat queries:

#### For Technical Questions (Tile/Construction)
1. **Consult `DOMAIN.md` first** before answering
2. **Cite TCNA/ANSI standards** when applicable
3. **Use precise terminology** (e.g., "C2 modified thinset" not "strong glue")
4. **Include material implications** (e.g., "LFT requires 95% coverage to prevent tenting")

**Example**:
> **User**: "What thinset for 24×48 tile?"
> 
> **Copilot**: Per TCNA standards, large format tile (>15" any dimension) requires **C2-rated modified thinset** with **S1 flexibility** (ISO 13007 classification). For 24×48 porcelain, recommend:
> - **Mapei Kerabond T** (C2TE S1)
> - **Laticrete 254 Platinum** (C2E S1)
> - **Schluter ALL-SET** (C2TE S1)
> 
> Must achieve **95% thinset coverage** (increased from 80% in TCNA 2024 update). Use **1/2×1/2" square-notch trowel** and **back-butter all tiles** to prevent voids and tenting. See DOMAIN.md §2.2 for deflection requirements.

#### For Marketing/Copy Questions
1. **Consult `STYLE.md` for voice guidelines**
2. **Apply 48 Laws framework** when relevant
3. **Use contrast patterns** without naming competitors
4. **Match tone to context** (homepage = bold, services = detailed, about = personality)

**Example**:
> **User**: "Write headline for waterproofing page"
> 
> **Copilot**: Applying voice from STYLE.md (bold, technical specificity, contrast):
> 
> **Option 1** (Law 6 - Court Attention):  
> "Your Shower Will Leak. Unless We Build It."
> 
> **Option 2** (Law 30 - Make It Look Effortless):  
> "Waterproofing That Actually Works (RedGard, KERDI, Hydroban)"
> 
> **Option 3** (Law 33 - Discover Pain Points):  
> "Tile Over Drywall? That's Not Waterproofing. This Is."
> 
> Subheadline: "Schluter KERDI, Laticrete Hydroban, or RedGard liquid membrane—specified per your substrate, tested to ANSI A118.10 standards, and documented with photos."

#### For Code Generation
1. **Follow `OUTPUT_RULES.md` standards** automatically
2. **Include accessibility attributes** in HTML
3. **Use design tokens** in CSS
4. **Add error handling** in JavaScript
5. **Write Conventional Commits** messages

**Example**:
> **User**: "Create service card component"
> 
> **Copilot**: Creating accessible service card with design tokens:
> 
> ```html
> <article class="service-card">
>   <div class="service-card__icon" aria-hidden="true">
>     {% include ts-icon.html name="tile" %}
>   </div>
>   <h3 class="service-card__title">{{ service.title }}</h3>
>   <p class="service-card__summary">{{ service.summary }}</p>
>   <a href="{{ service.url }}" class="btn btn--secondary">
>     Learn More
>     <span class="visually-hidden">about {{ service.title }}</span>
>   </a>
> </article>
> ```
> 
> ```scss
> .service-card {
>   display: flex;
>   flex-direction: column;
>   gap: var(--space-3);
>   padding: var(--space-5);
>   background: var(--color-surface-elevated);
>   border-radius: var(--radius-lg);
>   box-shadow: var(--shadow-soft);
>   transition: transform 0.2s, box-shadow 0.2s;
> 
>   &:hover {
>     transform: translateY(-4px);
>     box-shadow: var(--shadow-lift);
>   }
> 
>   &__icon {
>     width: 48px;
>     height: 48px;
>     color: var(--color-accent);
>   }
> 
>   &__title {
>     font-size: var(--heading-4);
>     color: var(--color-primary);
>   }
> }
> ```
> 
> **Commit message**:  
> ```
> feat(components): add service card component
> 
> - Create reusable service card with icon, title, summary, CTA
> - Use design tokens for colors, spacing, shadows
> - Include accessibility improvements (visually-hidden span, aria-hidden icon)
> - Add hover state with lift effect
> ```

#### For Compliance/Legal Questions
1. **Consult `COMPLIANCE.md` before answering**
2. **Never generate legal advice** (refer to attorney)
3. **Include required disclaimers** in marketing content
4. **Verify HIC license number** is included where required

**Example**:
> **User**: "Write payment terms for contract template"
> 
> **Copilot**: Per COMPLIANCE.md §2 (NJ Consumer Fraud Act):
> 
> **CRITICAL**: NJ law limits initial deposits to **10% of total contract price OR $1,000 (whichever is LESS)**.
> 
> **Example Payment Schedule** (for $8,000 bathroom):
> - Deposit at signing: **$800** (10%, under $1,000 limit)
> - At substrate prep completion: $2,000
> - At waterproofing completion: $2,500
> - At tile installation completion: $2,000
> - Final payment after punch list: $700
> 
> **Required contract language**:
> - HIC License #13VH10808800 prominently displayed
> - 3-Day Right of Rescission notice (bold, 12pt minimum)
> - Itemized cost breakdown
> - Change order procedures
> - Dispute resolution process
> 
> **Disclaimer**: This is general information, not legal advice. Consult with a contracts attorney for final contract language. See COMPLIANCE.md §2 for full requirements.

---

## COPILOT CHAT COMMANDS (Suggested)

### Quick Reference Commands

Users can invoke these patterns in Copilot Chat:

#### `/tcna [topic]`
Query TCNA standards and installation requirements
- Example: `/tcna large format tile trowel size`
- Consults: `DOMAIN.md` §2

#### `/voice [context]`
Get voice guidelines for specific content type
- Example: `/voice homepage hero headline`
- Consults: `STYLE.md` §2

#### `/comply [topic]`
Check legal/compliance requirements
- Example: `/comply contract payment schedule`
- Consults: `COMPLIANCE.md`

#### `/tokens`
List available design tokens
- Consults: `OUTPUT_RULES.md` §2.2 + `_sass/00-settings/_tokens.scss`

#### `/a11y [component]`
Get accessibility requirements for component
- Example: `/a11y navigation menu`
- Consults: `OUTPUT_RULES.md` §1.3

---

## COPILOT WORKSPACE CONTEXT

### Repository Structure Awareness

When suggesting code locations:
- **Components**: Place in `_includes/` (partials) or `_sass/30-components/` (styles)
- **Layouts**: Use `_layouts/default.html` for standard pages
- **Data**: Store structured content in `_data/*.yml`
- **Assets**: Images → `assets/img/`, CSS → `assets/css/`, JS → `assets/js/`

### File Relationship Awareness

When modifying code, consider dependencies:
- **SCSS changes**: Require `npm run build:css` to compile
- **Jekyll changes**: Require `bundle exec jekyll build` to regenerate `_site/`
- **Data changes**: Automatically picked up by Jekyll includes
- **Asset changes**: May require cache busting in production

### Common Workflow Awareness

**Typical development cycle**:
1. Edit SCSS in `_sass/`
2. Run `npm run build:css` to compile
3. Run `bundle exec jekyll serve` to preview
4. Run `npm run lint` before committing
5. Commit with Conventional Commits format
6. Push to GitHub (triggers Netlify deploy)

---

## EDGE CASES & EXCEPTIONS

### When to Deviate from Rules

**Acceptable exceptions** (with justification):
1. **Legacy browser support**: May need fallback for CSS Grid (rare)
2. **Third-party integrations**: May require inline scripts (document in commit)
3. **Performance optimization**: May inline critical CSS (note in comments)
4. **Accessibility conflict**: Always prioritize accessibility over aesthetics

**Unacceptable exceptions**:
- Skipping accessibility attributes ("too much work")
- Hard-coding values because "it's just one place"
- Ignoring linter errors ("works fine locally")
- Omitting HIC license number ("forgot to add")

---

## VERIFICATION BEFORE OUTPUT

Before suggesting code, Copilot must verify:
- [ ] Consulted relevant domain files (STYLE, DOMAIN, COMPLIANCE, OUTPUT_RULES)
- [ ] Used design tokens (no hard-coded colors/spacing)
- [ ] Included accessibility attributes (ARIA, alt text, labels)
- [ ] Followed semantic HTML structure
- [ ] Applied Conventional Commits format (for commit messages)
- [ ] Checked for legal compliance (HIC license, disclaimers if needed)
- [ ] Used modern web standards (ES6+, CSS Grid, mobile-first)
- [ ] Included error handling (for JavaScript)

---

## FEEDBACK LOOP

### When Uncertain
If Copilot encounters ambiguity:
1. **Ask clarifying questions** rather than guessing
2. **Suggest multiple options** with trade-offs explained
3. **Cite source files** (e.g., "Per STYLE.md §3.2, recommend...")
4. **Defer to human judgment** on subjective decisions

### Learning from Corrections
When user corrects a suggestion:
- Acknowledge the correction
- Update context for remainder of session
- Do not argue or defend incorrect suggestion
- Ask if clarification should be added to instruction files

---

**Version**: 1.0.0  
**Last Updated**: December 20, 2025  
**Tool**: GitHub Copilot (Editor Extension + Chat)  
**Authority**: Inherits from SYSTEM.md (master) + all domain files
