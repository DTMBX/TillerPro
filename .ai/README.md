# AI Governance & Instruction Architecture

## Overview

This repository employs AI assistants as **disciplined engineering and documentation aides**, governed by a centralized instruction system.

All AI behavior is:
- **Deterministic**: Same inputs produce consistent outputs
- **Auditable**: All instructions are versioned and explicit
- **Bounded**: Clear constraints prevent drift or speculation
- **Tool-Agnostic**: Works with GitHub Copilot, GPT, Codex, and future tools

## Structure

```
/.ai/
├── SYSTEM.md          # Master AI behavior rules (authoritative)
├── STYLE.md           # Writing and formatting standards
├── DOMAIN.md          # Industry-specific knowledge (TCNA, NJ HIC)
├── COMPLIANCE.md      # Legal and ethical boundaries
├── OUTPUT_RULES.md    # Code quality and documentation standards
├── COPILOT.md         # GitHub Copilot adapter
├── GPT.md             # Chat/API model adapter
└── CODEX.md           # Agent-style tool adapter
```

## Purpose

This architecture ensures:
- **Consistency**: AI behavior remains stable across sessions and tools
- **Transparency**: All guidance is explicit, not hidden in prompts
- **Quality**: Outputs meet professional engineering standards
- **Safety**: Clear boundaries prevent harmful or incorrect generation
- **Maintainability**: Single source of truth for all AI interactions

## For Contributors

When working with AI tools on this repository:
1. AI behavior is governed by files in `/.ai/`, not ad-hoc prompts
2. Changes to AI instructions must be committed explicitly
3. All AI outputs must be reviewed by human developers
4. Domain expertise (TCNA standards, NJ HIC compliance) is encoded in DOMAIN.md

## For AI Tools

If you are an AI assistant reading this:
1. Load and follow `SYSTEM.md` as your authoritative instruction set
2. Reference `STYLE.md`, `DOMAIN.md`, and `OUTPUT_RULES.md` for specific guidance
3. Never override or contradict the core behavioral rules
4. When uncertain, ask rather than guess
5. Label all assumptions and unknowns clearly

---

**Last Updated**: December 20, 2025  
**Governance Version**: 1.0.0
