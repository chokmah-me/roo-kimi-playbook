# Kimi for Coding Playbook - Installation Guide

**Version 5.0.0** - Setup for Zoo Code and Kimi Code CLI (September 2026)

---

## 📋 Prerequisites

1. **Zoo Code extension** (VS Code Marketplace) *or* **Kimi Code CLI** installed
2. **Kimi membership** with Kimi Code access — Plus tier and above (https://www.kimi.com/code/)
3. **API key** (`sk-kimi-...`) from the Kimi Code Console, if using the OpenAI-compatible track
4. This playbook package extracted or cloned

> **Migrating from Roo Code?** Roo Code was discontinued in April 2026 (final release v3.54.0, repo archived). Install Zoo Code — it reads your existing `.roo/` config and `.clinerules` unchanged. Your Roo tasks/checkpoints do not migrate; start fresh tasks.

---

## 🚀 Three Setup Tracks

| Track | Harness | Auth | Best for |
|-------|---------|------|----------|
| **A** | Zoo Code (≥ 3.72) | OAuth sign-in (native Kimi Code provider) | Most users — recommended |
| **B** | Zoo Code or any OpenAI-compatible client | API key (`sk-kimi-...`) | Non-VS-Code tools, multi-client setups |
| **C** | Kimi Code CLI | API key or env config | Terminal-native workflows, CI |

---

## Track A: Zoo Code with the Native Kimi Code Provider (Recommended)

### Step 1: Install Zoo Code

1. Open VS Code → Extensions (`Ctrl+Shift+X`)
2. Search **"Zoo Code"** (publisher: Zoo-Code-Org) — *not* the archived "Roo Code" listing
3. Install; docs live at https://docs.zoocode.dev

### Step 2: Connect the Kimi Code Provider

1. Open the Zoo Code chat panel → click the gear icon (⚙️) → **Edit Provider Settings**
2. Select the **Kimi Code** provider (added in Zoo Code v3.72.0)
3. Complete the **OAuth device-flow sign-in** with your Kimi account
4. Select model: `kimi-for-coding` (default — K2.8 Preview)

No API key, Base URL, or Legacy Format fiddling needed — the provider sets correct endpoints and output-token defaults.

### Step 3: Pick Your Model

| Model ID | Actual model | Context | When to use |
|----------|--------------|---------|-------------|
| `kimi-for-coding` | K2.8 Preview | 1M | Default daily driver |
| `k3` | K3 | 1M | Hardest problems (requires Pro tier) |
| `k3-256k` | K3 | 256K | K3 quality at ~half quota burn |
| `kimi-for-coding-highspeed` | K2.7 Code HighSpeed | 256K | ~5–6× faster output when latency matters (3× quota) |

1M context on `k3`/`highspeed` requires Pro tier and above.

### Step 4: Configure Effort

- Reasoning effort: **`high`** for daily work
- `low` for rote tasks (formatting, boilerplate tests)
- `max` for architecture and gnarly debugging (note: default on `kimi-for-coding` is `max` — dial down for routine work)

---

## Track B: OpenAI-Compatible (API Key)

### Step 1: Get a Key

Create an API key (max 5 per account) in the **Kimi Code Console**. ⚠️ This is **not** an Open Platform key — keys are not interchangeable, and using the wrong one returns 401.

### Step 2: Configure the Provider

| Setting | Value |
|---------|-------|
| **Provider** | `OpenAI Compatible` |
| **Base URL** | `https://api.kimi.com/coding/v1` (China) or `https://api.kimi.ai/coding/v1` (overseas) |
| **API Key** | `sk-kimi-...` |
| **Model ID** | `kimi-for-coding` |
| **Max Output** | `32768` |
| **Reasoning effort** | `high` |

**Effort mapping** (per official docs): if your tool only offers `medium`, it maps to `high`; `ultra`/`xhigh` map to `max`; `none` disables thinking. Unknown values return HTTP 400.

### Step 3: Troubleshooting Format Issues

If you see garbled responses or malformed tool calls, try the **Legacy Format** toggle in Advanced settings. In 2026 this could not be confirmed as required for current models — treat it as a fallback, and prefer Track A (native provider) which avoids the issue entirely.

### Step 4: Verify

```bash
curl -H "Authorization: Bearer sk-kimi-YOUR-KEY" \
     https://api.kimi.com/coding/v1/models
```

A JSON model list = success. 401 = wrong key type or missing plan entitlement.

---

## Track C: Kimi Code CLI

The CLI speaks the OpenAI and Anthropic protocols natively (no proxies) — the same endpoints work with Codex/Claude-Code-style configurations.

```bash
# Anthropic protocol
export ANTHROPIC_BASE_URL="https://api.kimi.com/coding/"
export ANTHROPIC_AUTH_TOKEN="sk-kimi-..."

# or OpenAI protocol
export OPENAI_BASE_URL="https://api.kimi.com/coding/v1"
export OPENAI_API_KEY="sk-kimi-..."
```

Overseas users: replace `api.kimi.com` with `api.kimi.ai`. Model IDs and effort levels are the same as Track A. Per the Kimi Code terms, do **not** tamper with the client User-Agent — it is grounds for suspension.

---

## 📁 Files to Copy to Your Project

```bash
cp .clinerules /path/to/your/project/
cp -r .roo /path/to/your/project/
cp PLAYBOOK.md INSTALLATION_GUIDE.md EVERYDAY_USE_CASES.md /path/to/your/project/
```

- **`.clinerules`** — verification-first instructions, horizon management, safety rails
- **`.roo/rules.md`** — provider settings, effort protocol, cache hygiene, cost governance
- Zoo Code also reads **`AGENTS.md`** and `.roo/rules-*` mode files recursively — run **`/init`** in the chat to generate them from your codebase

---

## ✅ Verification Checklist

- [ ] Zoo Code connected (Track A) or `curl /models` returns JSON (Tracks B/C)
- [ ] Model `kimi-for-coding` selected; effort `high`
- [ ] Max output `32768` (Track B only)
- [ ] Test message completes; cost estimate visible in the task header
- [ ] Checkpoints enabled; Destructive Command Guard on
- [ ] `AGENTS.md` generated (`/init`) or present
- [ ] Rules files copied (`.clinerules`, `.roo/rules.md`)
- [ ] Membership tier confirmed (Plus+; Pro+ for `k3` 1M / highspeed 1M)

## 🎯 First Test Session

1. Open the chat → new task: *"What does this project do? Read AGENTS.md and summarize the architecture."*
2. Ask it to make a trivial change and run the project's tests.
3. Check the task header: tokens in/out + estimated cost.
4. Open History and confirm the task is recorded with subtask roll-up.

---

## 🏢 Enterprise Routing Note

For teams needing centralized budgets/limits, route the **Open Platform** (https://api.moonshot.ai/v1 — pay-as-you-go, model IDs like `kimi-k3`, `kimi-k2.7-code`) through your own LLM gateway. Remember: Open Platform keys **do not** work against `/coding/`, and per-token rates there (K3 $3.00/$15.00 per 1M; K2.7 Code $0.95/$4.00; cache-hit ~$0.16–$0.30) are separate from Kimi Code membership quota.

---

## 📞 Support

1. **Zoo Code**: https://docs.zoocode.dev · https://github.com/Zoo-Code-Org/Zoo-Code
2. **Kimi Code**: https://www.kimi.com/code/docs/en/
3. **This playbook**: `PLAYBOOK.md` (troubleshooting section)

---

**Installation Complete!**

**Version**: 5.0.0
**Date**: September 30, 2026
