# 📘 Practitioner's Playbook: Kimi for Coding with Zoo Code & Kimi Code CLI (v5.0.0)

**Core Objective:** Operationalize the **Kimi for Coding** endpoint (currently backed by **Kimi K2.8 Preview**, with **K3** available) for long-horizon agentic work at predictable cost.

> **⚠️ What happened to Roo Code?** Roo Code was discontinued in April 2026 (final release v3.54.0, repo archived). This playbook targets **Zoo Code**, the community successor fork (Apache-2.0, actively maintained), and Moonshot's official **Kimi Code CLI**. Existing `.roo/` config paths work unchanged in Zoo Code.

---

## 🆕 What Changed Since v4.x (Dec 2025)

| v4.x assumption (Dec 2025) | v5.0.0 reality (Sept 2026) |
| :--- | :--- |
| Roo Code extension | **Zoo Code** (community successor) or **Kimi Code CLI** |
| `kimi-for-coding` = K2-era model | Same model ID, now **K2.8 Preview** (upgraded in place Sep 11, 2026); `k3`, `k3-256k`, `kimi-for-coding-highspeed` also available |
| Max output `16384` | `32768` |
| Reasoning: Medium/Low toggle | Effort levels `low` / `high` / `max` (third-party `medium` maps to `high`) |
| Reliability collapses after ~18 steps | Never an official limit; K2 Thinking (Nov 2025) was rated for 200–300 tool calls. Current models target long-horizon agency. Manage *your measured horizon* instead |
| Manual top/tail file ordering, `/clear` every 5–7 prompts | Zoo Code auto-condensation (v2) + Smart Code Folding + checkpoints handle overflow; prompt-cache hygiene matters more than ordering |
| ~$3.00 / 1M tokens | The `/coding/` endpoint is **subscription-quota based** (membership). Pay-per-token only applies to the separate Open Platform |
| "Legacy Format" critical | Use Zoo Code's **native Kimi Code provider (OAuth)** or Moonshot provider; Legacy Format is now only an OpenAI-compatible troubleshooting toggle |
| `/cost` command | Not built-in. Cost shows in the task header + History (with subtask roll-up) |

---

## ⚙️ Part I: The Golden Configuration

**Recommended:** Zoo Code's native **Kimi Code provider** (OAuth device-flow sign-in) — no API keys to manage, correct model defaults, first-class K3 support. Requires Zoo Code ≥ 3.72.

### Track A — Zoo Code, native Kimi Code provider (recommended)

| Setting | Value | Notes |
| :--- | :--- | :--- |
| **Provider** | `Kimi Code` (native) | OAuth device flow; sign in with your Kimi account |
| **Model ID** | `kimi-for-coding` | Default; runs **K2.8 Preview** (1M context) |
| **Alt models** | `k3`, `k3-256k`, `kimi-for-coding-highspeed` | `k3` = flagship (Moderato/Plus and above; 1M context needs Allegretto/Pro); `k3-256k` ≈ half quota; `highspeed` ≈ 5–6× faster output, 3× quota (Allegretto/Pro and above) |
| **Reasoning effort** | `high` (default) | `low` / `high` / `max`; default for `kimi-for-coding` is `max`, but `high` is the sane daily driver |

### Track B — Zoo Code, OpenAI-compatible (fallback / other tools)

| Setting | Value | Rationale |
| :--- | :--- | :--- |
| **Provider** | `OpenAI Compatible` | Standard protocol |
| **Base URL** | `https://api.kimi.com/coding/v1` | China; overseas: `https://api.kimi.ai/coding/v1` |
| **API Key** | `sk-kimi-...` | Kimi Code Console (max 5 keys). **Not** an Open Platform key — they are not interchangeable (401 otherwise) |
| **Model ID** | `kimi-for-coding` | K2.8 Preview |
| **Max Output** | `32768` | Current model limit |
| **Reasoning effort** | `high` | The documented levels are `low` / `high` / `max`. Some third-party clients also expose aliases (`medium`, `auto`, `off`, `none`, `ultra`/`xhigh`) — mapping behavior is client-specific, and the API returns HTTP 400 for values it doesn't accept. When in doubt, use the three documented levels. |

### Track C — Kimi Code CLI

Moonshot's official CLI supports the OpenAI- and Anthropic-compatible endpoints natively (no proxies). Configure via environment / config file per the [Kimi Code docs](https://www.kimi.com/code/docs/en/):

```bash
export ANTHROPIC_BASE_URL="https://api.kimi.com/coding/"   # Anthropic protocol
export ANTHROPIC_AUTH_TOKEN="sk-kimi-..."
# or OpenAI protocol:
export OPENAI_BASE_URL="https://api.kimi.com/coding/v1"
export OPENAI_API_KEY="sk-kimi-..."
```

Model selection via `kimi-for-coding` / `k3` / `k3-256k` / `kimi-for-coding-highspeed`.

### ⚠️ Compliance note

Moonshot's terms explicitly prohibit tampering with the client User-Agent. Tools that rely on UA spoofing to access the `/coding/` endpoint risk membership suspension. Use official clients or documented OpenAI/Anthropic-compatible connections only.

---

## 🧠 Part II: Horizon & Context Strategy

### 1. Horizon management (replaces the "18-step limit")

The old 18-step ceiling was anecdotal K2-era behavior, not a model property. Moonshot's K2 Thinking (Nov 2025) was rated for **200–300 consecutive tool invocations**; K2.7/K2.8/K3 are positioned for long-horizon agency. There is no verified fixed ceiling for current models.

**Tactics that actually matter:**
- **Measure your own 80% horizon.** Benchmarks show 80%-success horizons run 4–5× shorter than 50% horizons. Track at what task length *your* workflows start needing rework, and decompose anything beyond that.
- **Self-correction beats length limits.** A 30-step task with intermediate verification (tests, checkpoints) outperforms a 15-step task without it.
- **Use subagents for isolation.** Delegate heavy exploration/implementation to subagents in isolated context windows; they return a summary + test result ("Boomerang"). This is now native Orchestrator behavior in Zoo Code — not a prompt trick.
- **Parallelize where independent.** Parallel subagent fan-out costs roughly ~7× the tokens of a single-thread session — spend it only where tasks are genuinely independent.

### 2. Context engineering (replaces manual top/tail ordering)

Zoo Code handles overflow automatically: **Intelligent Context Condensation v2** (LLM summarization near the limit), **Smart Code Folding** (preserves code maps across condensations), and **checkpoints** for rollback. Hand-managing file order against a hard token ceiling is no longer necessary.

**What still matters:**
- **Prompt-cache hygiene is the highest-leverage habit.** Cached input is ~5× cheaper than uncached on the Open Platform, and rewriting history busts the cache. Keeping full history usually beats aggressive summarization on cost *and* quality. **Compact rarely and deliberately.**
- **Stable prefixes.** Keep AGENTS.md / rules / large static docs early and unchanged in the session; don't edit them mid-task.
- **Critical instructions belong in files, not chat.** Lost-in-the-middle bias is real — persistent rules go in `AGENTS.md` and `.roo/rules/`, not buried mid-conversation.
- **Cap tool output.** Truncating oversized tool outputs is the cheapest single context saving (measured ~38% cost-per-turn reduction in 2026 evals).

---

## 💰 Part III: Cost Governance

> Volatile numbers (exact prices, tier availability, model IDs) live in
> **`REFERENCE.md`** — verified 2026-09-30 against the official Kimi Code
> docs. Re-verify before spending money.

### Kimi Code endpoint (subscription)

The `/coding/` endpoint bills against **membership quota**, not per token:
- Quota windows: rolling 5-hour rate window + monthly total (weekly cap removed for new plans)
- Tiers use the official naming: **Andante** (~$19) → **Moderato / Plus** (~$39) → **Allegretto / Pro** (~$99) → **Allegro** (~$199) per month
- Availability per the official docs: `kimi-for-coding` from **Andante** up; `k3` / `k3-256k` from **Moderato / Plus**; `highspeed` and `k3` 1M context from **Allegretto / Pro**
- Optional **Extra Usage** wallet (pay-as-you-go top-up) for overage
- ⚠️ New subscriptions were briefly paused in July 2026 (K3 GPU capacity) — check current availability on the membership page
- Quota burn differs by model: `k3` (1M) ≈ **2×** `k3-256k`; `highspeed` ≈ **3×**

### Open Platform (pay-as-you-go, separate product)

Full price table in `REFERENCE.md`. Summary (Sept 2026): K3 $3.00/$15.00 per 1M
in/out; K2.7 Code $0.95/$4.00; cache-hit input ~$0.16–$0.30; batch API at 60%
(K2.6/K2.7 Code only). **Open Platform keys do not work on `/coding/` and vice versa.**

### Alert rules (v5)

- **Quota rhythm**: if you keep hitting the 5-hour window, you are under-tiered or over-delegating — route rote work to `low` effort, and reserve `k3` / `max` effort for problems that actually need them.
- **Fan-out discipline**: parallel subagents multiply cost; cap concurrency at 2–3 unless tasks are independent and large.
- **Track per task**: Zoo Code shows tokens + estimated cost in the task header and History (subtask roll-up included). Set input/output prices in Model Configuration to make estimates accurate.

---

## 🏗️ Part IV: Workflow Architecture

### Modes (Zoo Code)

| Mode | Use for | Suggested model/effort |
| :--- | :--- | :--- |
| **Architect** | Planning, schema/PRD analysis, read-only design | `k3` or `kimi-for-coding` @ `high`/`max` |
| **Code** | Implementation, edits, test runs | `kimi-for-coding` @ `high` |
| **Ask** | Q&A, explanation, no edits | `kimi-for-coding` @ `low` |
| **Debug** | Root-cause analysis | `kimi-for-coding` @ `high` |
| **Orchestrator** | Decomposition, delegation, `new_task` subagents | plan on strong model, delegate freely |

Modes support **per-mode API profiles** (v3.48+ lock toggle), and profiles are **sticky per subtask** — a subagent keeps the model it was spawned with even if you switch profiles mid-task.

### Verification loops (now structural, not prompt tricks)

- **Tests after every behavior change.** Make "run the tests" the default closing step of a Code-mode task.
- **Checkpoints** (shadow-git): created per task and per subtask; roll back instead of arguing with a derailed session.
- **Destructive Command Guard**: Zoo Code flags dangerous shell commands — keep it enabled.
- **Custom commands**: put repeatable workflows (e.g. a cost check) in `.roo/commands/*.md` with frontmatter; run `/init` to generate `AGENTS.md` + mode-specific rules.

### Skills & AGENTS.md

- **AGENTS.md** is the cross-tool standard (25+ tools read it; Zoo Code loads it recursively). One file, project root, kept current.
- **Skills** (`SKILL.md` bundles) are an open standard — use them for reusable capabilities; bodies load on demand (progressive disclosure).

### MCP servers

- **Zoo Code**: project-level MCP config lives in `<project>/.roo/mcp.json` (hot-reloaded on save); global servers are managed in the extension's MCP settings. Restrict servers per mode with `allowedMcpServers` in custom modes — e.g. give Architect the docs/search servers, keep Code lean.
- **Kimi Code CLI**: MCP servers are configured in `~/.kimi-code/config.toml` — see the [CLI docs](https://www.kimi.com/code/docs/en/).
- **Start minimal.** Every configured server's tools are listed in every prompt, so unused servers tax context and quota on every turn. One web/docs server and one browser/automation server (only if you need it) is plenty to start.
- **Vet servers like dependencies.** MCP servers run as subprocesses with your user's privileges. Prefer Skills over MCP when the capability is prompt knowledge rather than live data — skills load on demand, MCP tools are always listed.

---

## ✅ Part V: The "Go-Live" Checklist

1. [ ] **Harness installed**: Zoo Code (≥ 3.72) or Kimi Code CLI; Roo Code replaced if still present (frozen, no patches).
2. [ ] **Auth working**: native Kimi Code provider OAuth sign-in, or `sk-kimi-...` key verified against `/coding/v1`.
3. [ ] **Model selected**: `kimi-for-coding` default; `k3` for hard problems (Moderato/Plus+; 1M needs Allegretto/Pro); `highspeed` when latency matters.
4. [ ] **Max output 32768** (OpenAI-compatible track only — native provider sets this for you).
5. [ ] **Effort protocol understood**: `low` rote / `high` daily driver / `max` architecture & gnarly debugging.
6. [ ] **AGENTS.md present**: run `/init` or hand-write; rules live in files, not chat.
7. [ ] **Checkpoints enabled** and Destructive Command Guard on.
8. [ ] **Quota understood**: your tier, the 5-hour window, per-model burn rates.
9. [ ] **Horizon baseline noted**: how long your tasks run before rework — decompose beyond it.
10. [ ] **Cache hygiene**: stable session prefixes; no mid-session rule edits; compact rarely.

---

## 📊 Benchmark Context & Metrics

**External benchmarks (Sept 2026):** SWE-bench Verified — Kimi K3 **93.4%**, frontier cluster ~96–97%. Verified is near saturation; the informative signals are now SWE-bench Pro, Terminal-Bench 2.0, and METR time-horizons (50% horizons for frontier models are in the multi-hour range and doubling every ~4 months).

**Track these yourself** (per project, per month):

| Metric | Target | How to measure |
| :--- | :--- | :--- |
| Task success without rework | >85% | Successful sessions / total |
| Cost per completed task | trend down | Task header + History |
| Quota rhythm | never hit 5-hour wall | membership dashboard |
| Subagent fan-out ratio | ≤3× for ≤2 subagents; stay at the low end of the 3–7× band | History roll-up |
| Rework rate beyond horizon | declining | your own log |

The v4.x "92% completion / 25% token reduction" figures were self-reported from a 100-task sample on the K2-era model; treat them as historical, not current guarantees.

---

## 🔧 Troubleshooting

**401 Unauthorized:**
- Wrong key type: Open Platform keys fail on `/coding/` and vice versa.
- Entitlement: `k3` and 1M context require Allegretto/Pro tier — 401 is also used for plan-entitlement failures.

**403 Provider refused (client not whitelisted):**
- The `/coding/` endpoint whitelists client identifiers. After some client updates (e.g. Zoo Code v3.56.0 changed its OpenAI-compatible identifier), requests fail with `403` / `access_terminated_error` ("only available for Coding Agents such as…") even with a valid key.
- Fix: update Zoo Code to the latest release (the whitelist catches up), or sidestep the question entirely with Track A — the native Kimi Code provider.

**Garbled responses / tool-call format errors (OpenAI-compatible track only):**
- Try the "Legacy Format" toggle in Advanced settings. In 2026 this could not be confirmed as required — the native Kimi Code provider avoids the question entirely. Prefer Track A.

**Context degradation on long sessions:**
- Don't manually `/clear` — let condensation handle it; roll back to a checkpoint if the session derails; check that mid-session rule edits haven't busted your prompt cache.

**Quota exhaustion:**
- Check the 5-hour window vs monthly total on the membership dashboard; move rote work to `low` effort; defer `k3`/`max` to where it pays.

**Endpoint verification:**
```bash
curl -H "Authorization: Bearer sk-kimi-..." \
     https://api.kimi.com/coding/v1/models
```

---

## 📄 License

MIT License - see LICENSE file for details.

---

**Version**: 5.0.0
**Date**: September 30, 2026
**Repository**: https://github.com/chokmah-me/roo-kimi-playbook
**Targets**: Zoo Code (community successor to Roo Code) + Kimi Code CLI, via the Kimi for Coding endpoint (K2.8 Preview / K3)
