# Legacy Instructions Directory

> ⚠️ **DEPRECATED STRUCTURE - USE `/.ai/` FOR ALL AI GOVERNANCE**
>
> This directory contains **legacy instruction files** that have been superseded by the centralized AI governance system in **[`/.ai/`](../../.ai/)**.
>
> **All AI tools (GitHub Copilot, ChatGPT, autonomous agents) should reference the new structure:**
> - **[`/.ai/SYSTEM.md`](../../.ai/SYSTEM.md)** — Master behavioral contract
> - **[`/.ai/STYLE.md`](../../.ai/STYLE.md)** — Brand voice & persuasion
> - **[`/.ai/DOMAIN.md`](../../.ai/DOMAIN.md)** — Technical authority (TCNA, NJ HIC)
> - **[`/.ai/COMPLIANCE.md`](../../.ai/COMPLIANCE.md)** — Legal boundaries
> - **[`/.ai/OUTPUT_RULES.md`](../../.ai/OUTPUT_RULES.md)** — Code quality standards
> - **[`/.ai/COPILOT.md`](../../.ai/COPILOT.md)** — GitHub Copilot adapter
> - **[`/.ai/GPT.md`](../../.ai/GPT.md)** — ChatGPT adapter
> - **[`/.ai/CODEX.md`](../../.ai/CODEX.md)** — Agent tool adapter
>
> See **[`/.ai/README.md`](../../.ai/README.md)** for complete governance documentation.

---

## Migration Status

### ❌ **DEPRECATED** (Migrated to `/.ai/`)

| Legacy File | Migrated To | Status |
|-------------|-------------|--------|
| `tcna-nj-hic-trade-expert.md` | [`/.ai/DOMAIN.md`](../../.ai/DOMAIN.md) | ⚠️ DEPRECATED |
| `copy-voice-persuasion-strategy.md` | [`/.ai/STYLE.md`](../../.ai/STYLE.md) | ⚠️ DEPRECATED |
| `quality-standards.instructions.md` | [`/.ai/OUTPUT_RULES.md`](../../.ai/OUTPUT_RULES.md) | ⚠️ DEPRECATED |

**Action**: These files are preserved for historical reference only. Do not update them. Make all changes in the centralized `/.ai/` structure.

### ✅ **SUPPLEMENTAL** (Still Active, Reference `/.ai/`)

| File | Purpose | References |
|------|---------|------------|
| `QA_CHECKLIST.md` | Manual QA procedures | [`/.ai/OUTPUT_RULES.md`](../../.ai/OUTPUT_RULES.md) (Testing Requirements) |
| `accessibility-tools.md` | Tooling & historical context | [`/.ai/OUTPUT_RULES.md`](../../.ai/OUTPUT_RULES.md) (Accessibility) |
| `build-troubleshooting.md` | Troubleshooting common issues | [`/.ai/OUTPUT_RULES.md`](../../.ai/OUTPUT_RULES.md), [`/.ai/CODEX.md`](../../.ai/CODEX.md) (Build Process) |

**Action**: These files supplement the centralized governance with human-driven procedures and specific troubleshooting steps. They now include links to the authoritative `/.ai/` structure.

---

## Why the Migration?

The previous scattered instruction system had several issues:
- ❌ **Duplication**: Same rules repeated across multiple files
- ❌ **Inconsistency**: Conflicting instructions between files
- ❌ **No hierarchy**: Unclear which file takes precedence
- ❌ **Tool-specific gaps**: No clear guidance for different AI tools (Copilot vs. ChatGPT vs. agents)
- ❌ **Hard to maintain**: Changes required updates in multiple places

The new **`/.ai/` governance structure** solves these with:
- ✅ **Single source of truth**: All rules in one location
- ✅ **Clear inheritance**: SYSTEM.md → domain files → tool adapters
- ✅ **Separation of concerns**: Behavioral rules, domain knowledge, quality standards
- ✅ **Tool-specific adapters**: Clear guidance for each AI tool type
- ✅ **Easy to maintain**: Update once, propagates everywhere

---

## For Contributors

### If You're a Human Developer
1. **Read the centralized governance**: Start with [`/.ai/README.md`](../../.ai/README.md)
2. **Ignore deprecated files**: Don't reference `tcna-nj-hic-trade-expert.md` or `copy-voice-persuasion-strategy.md`
3. **Use supplemental files**: Leverage `QA_CHECKLIST.md` and `build-troubleshooting.md` for manual procedures
4. **Update centralized files**: Make changes in `/.ai/` structure, not here

### If You're Configuring an AI Tool
1. **Point to `/.ai/COPILOT.md`** (for GitHub Copilot)
2. **Point to `/.ai/GPT.md`** (for ChatGPT/API models)
3. **Point to `/.ai/CODEX.md`** (for autonomous agents)
4. **Do NOT reference** files in `.github/instructions/` (deprecated)

---

## Timeline

- **December 20, 2025**: Centralized governance structure created in `/.ai/`
- **December 20, 2025**: Legacy files marked as deprecated with migration notices
- **Future**: This directory may be archived or removed once transition is complete

---

## Questions?

See [`/.ai/README.md`](../../.ai/README.md) for complete documentation or [`docs/AI-GOVERNANCE-IMPLEMENTATION.md`](../../docs/AI-GOVERNANCE-IMPLEMENTATION.md) for implementation details.
