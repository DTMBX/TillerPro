# Release Checklist

Use this checklist before promoting changes to production to avoid regressions in the public site experience.

## Automated verification
- [ ] Ensure the **CI** workflow is green (linting, full site build, and link checks).
- [ ] Ensure the **Jekyll Build Verification** workflow passes (`bundle exec jekyll build` with HTML and link validation).
- [ ] Run `npm run test` locally if time permits to mirror production link checks and the full static build.

## Visual and UX smoke test
- [ ] Homepage loads without console errors or missing assets.
- [ ] Primary navigation works on desktop and mobile (menu toggle, section links, and footer navigation).
- [ ] Key calls-to-action are clickable and routed correctly (contact buttons, phone/email links, quote requests).
- [ ] All images, icons, and backgrounds render without distortion or placeholders.
- [ ] No horizontal scrolling at common breakpoints (320px, 768px, 1024px, and large desktop widths).

## Content and accessibility spot checks
- [ ] Headers follow a sensible hierarchy (one `<h1>` per page, logical `<h2>`/`<h3>` nesting).
- [ ] Contact links (phone, email, maps) open the expected applications/URLs and are accessible via keyboard.
- [ ] Forms or interactive components respond to keyboard focus states and do not trap focus.
- [ ] Alt text is present for informative imagery; decorative images are correctly marked or skipped.

## Repository safeguards
- [ ] Enable required status checks on the `main` branch (e.g., **CI** and **Jekyll Build Verification**) before allowing merges.
- [ ] Keep branch protection enabled so updates must pass automated validation prior to deployment.
