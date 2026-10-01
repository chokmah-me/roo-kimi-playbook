# Kimi for Coding, Zoo Code & Kimi Code CLI Playbook v5.0.0

**Practitioner's Playbook for agentic coding with the Kimi for Coding endpoint (Kimi K2.8 Preview / K3)**

> **⚠️ Roo Code was discontinued in April 2026** (final release v3.54.0; repository archived read-only). This playbook targets **Zoo Code** — the Apache-2.0 community successor fork that continues the Roo Code lineage — and Moonshot's official **Kimi Code CLI**. All legacy `.roo/` configuration paths work unchanged in Zoo Code.

## 🆕 What's New in v5.0.0 (September 2026)

- **Harness updated**: Roo Code → **Zoo Code** (+ Kimi Code CLI track)
- **Model updated**: `kimi-for-coding` now runs **K2.8 Preview** (1M context, max output 32768, effort levels `low`/`high`/`max`); `k3`, `k3-256k`, `kimi-for-coding-highspeed` also on the endpoint
- **"18-step limit" removed**: replaced with measured-horizon management; current models are rated for hundreds of tool calls
- **Cost model corrected**: the `/coding/` endpoint is **subscription-quota** (membership tiers); per-token pricing lives on the separate Open Platform
- **Tier availability corrected against the official docs**: `kimi-for-coding` from Andante up; `k3`/`k3-256k` from Moderato/Plus; `highspeed` and `k3` 1M from Allegretto/Pro
- **Context rituals replaced**: Zoo Code auto-condensation + checkpoints + AGENTS.md supersede manual file-ordering and `/clear` cadence
- **Legacy Format demoted**: use Zoo Code's native Kimi Code provider (OAuth) instead

## 📦 Package Contents

### Core Configuration Files
- **`.clinerules`** - Critical instruction set (Cline-family harnesses; Zoo Code / Kimi Code CLI users treat `.roo/rules.md` as authoritative)
- **`.roo/rules.md`** - Zoo Code specific configuration rules (Zoo Code reads the same `.roo/` paths)
- **`.roo/commands/costcheck.md`** - Example custom command (`/costcheck`): quota/cost position report
- **`templates/AGENTS.md`** - Starter AGENTS.md for projects that can't run `/init`

### Setup Scripts
- **`setup.sh`** / **`setup.ps1`** - Copy the config files (and starter AGENTS.md) into a project directory

### Documentation
- **`PLAYBOOK.md`** - Main configuration & strategy guide
- **`REFERENCE.md`** - Volatile facts in one place: endpoints, model IDs, tiers, quota, prices (verified 2026-09-30)
- **`INSTALLATION_GUIDE.md`** - Step-by-step setup for all three tracks
- **`EVERYDAY_USE_CASES.md`** - Practical usage examples
- **`VERSION_CHANGELOG.md`** - Version history and changes

## 🚀 Quick Start

### For New Projects

```bash
# Option 1: setup script (copies config + starter AGENTS.md if none exists)
./setup.sh /path/to/your/project/
# PowerShell:
# .\setup.ps1 -Target C:\path\to\your\project
```

```bash
# Option 2: manual copy
cp .clinerules /path/to/your/project/
cp -r .roo /path/to/your/project/
cp templates/AGENTS.md /path/to/your/project/AGENTS.md  # if the project has none

# Copy documentation for reference
cp PLAYBOOK.md REFERENCE.md /path/to/your/project/
cp INSTALLATION_GUIDE.md /path/to/your/project/
cp EVERYDAY_USE_CASES.md /path/to/your/project/
```

Then install Zoo Code from the VS Code Marketplace (publisher `ZooCodeOrganization`: `code --install-extension ZooCodeOrganization.zoo-code`) or the Kimi Code CLI, and follow `INSTALLATION_GUIDE.md`.

### Configuration Summary

**Track A — Zoo Code, native Kimi Code provider (recommended):**
- Provider: `Kimi Code` (OAuth sign-in) · Model: `kimi-for-coding` · Effort: `high`

**Track B — Zoo Code, OpenAI-compatible:**
- Base URL: `https://api.kimi.com/coding/v1` (overseas: `https://api.kimi.ai/coding/v1`)
- Model: `kimi-for-coding` · Max Output: `32768` · Effort: `high`

**Track C — Kimi Code CLI:**
- `ANTHROPIC_BASE_URL=https://api.kimi.com/coding/` or `OPENAI_BASE_URL=https://api.kimi.com/coding/v1` with your `sk-kimi-...` key

## 🎯 Key Facts (Sept 2026)

- **Model**: `kimi-for-coding` = K2.8 Preview (1M context); `k3` = flagship (1M); `k3-256k` ≈ half quota; `kimi-for-coding-highspeed` ≈ 5–6× faster, 3× quota
- **Tiers** (official naming): Andante (~$19) → Moderato/Plus (~$39) → Allegretto/Pro (~$99) → Allegro (~$199). `kimi-for-coding` from Andante up; `k3`/`k3-256k` from Moderato/Plus; `highspeed` and `k3` 1M from Allegretto/Pro
- **Billing**: membership quota (5-hour rolling window + monthly total); Extra Usage wallet for overage; Open Platform is a separate pay-as-you-go product ($0.95–$3.00 input / $4.00–$15.00 output per 1M)
- **Context**: auto-condensation + Smart Code Folding + checkpoints; prompt-cache hygiene beats manual ordering
- **Horizon**: no fixed step ceiling — measure your own, decompose beyond it, verify continuously
- **Volatile details** (exact prices, tier availability, model IDs): see **`REFERENCE.md`**, verified 2026-09-30

## 📚 Documentation Guide

1. **`INSTALLATION_GUIDE.md`** — Zoo Code / Kimi Code CLI setup, provider tracks, verification
2. **`REFERENCE.md`** — endpoints, model IDs, tier availability, quota, prices (the numbers that drift; check here first)
3. **`PLAYBOOK.md`** — strategy: horizon management, context engineering, cost governance, workflow architecture, benchmarks
4. **`EVERYDAY_USE_CASES.md`** — 6 worked examples with effort levels, subagent delegation, and token estimates
5. **`VERSION_CHANGELOG.md`** — full history, v4.x preserved in git tags

## 🔧 Daily Workflow

1. **Start**: fresh task, AGENTS.md + rules auto-loaded
2. **Delegate**: Orchestrator mode for multi-part work; subagents return summary + test result
3. **Verify**: tests after every change; checkpoints for rollback
4. **Monitor**: task header + History (tokens, estimated cost, subtask roll-up)

## 📞 Support

- Zoo Code docs: https://docs.zoocode.dev
- Kimi Code docs: https://www.kimi.com/code/docs/en/
- Open Platform: https://platform.moonshot.ai

## 📄 License

MIT License

**Version**: 5.0.0
**Date**: September 30, 2026
**Repository**: https://github.com/chokmah-me/roo-kimi-playbook
