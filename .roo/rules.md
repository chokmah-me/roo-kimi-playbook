# Zoo Code Rules - Kimi for Coding Configuration (v5.0.0)

## Provider Settings
**Recommended**: Native `Kimi Code` provider (OAuth, Zoo Code ≥ 3.72) or native `Moonshot` provider
**Fallback (OpenAI Compatible)**:
- Base URL: `https://api.kimi.com/coding/v1` (overseas: `https://api.kimi.ai/coding/v1`)
- Model: `kimi-for-coding` (K2.8 Preview) · Max Output: `32768` · Effort: `high`
- Model IDs: `kimi-for-coding` (default) · `k3` / `k3-256k` (Moderato/Plus+; 1M needs Allegretto/Pro) · `kimi-for-coding-highspeed` (Allegretto/Pro+)

## Critical Rules
1. **NEVER** tamper with the client User-Agent — Kimi Code terms prohibit it (membership suspension risk)
2. **NEVER** mix key types: Open Platform keys fail on `/coding/` and vice versa (401)
3. **ALWAYS** keep durable rules in AGENTS.md / `.roo/rules/`, not mid-conversation
4. **ALWAYS** verify: run tests after every behavior change; roll back to a checkpoint on derailment
5. **MONITOR** quota burn: task header + History (subtask roll-up); set model prices for accurate estimates

## Effort Protocol
- `low`: formatting, boilerplate, docs, mechanical test generation
- `high`: daily driver — implementation, debugging, review (default)
- `max`: architecture, ambiguous multi-system problems
- The documented API levels are `low` / `high` / `max`; third-party client aliases (`medium`, `auto`, `off`, `ultra`/`xhigh`) map client-side and are not portable — prefer the three documented levels

## Context Strategy (harness-managed)
- Auto-condensation v2 + Smart Code Folding handle overflow — no manual `/clear` rituals; start a new task per unit of work
- Load large stable files early and don't edit rules/AGENTS.md mid-session (cache invalidation)
- Read files just-in-time; grep for ranges instead of dumping files > ~500 lines
- Cap oversized tool outputs — cheapest single context saving (~38% cost/turn in 2026 evals)
- Durable designs/decisions go in `docs/` files, not chat

## Horizon Management (replaces the 18-step rule)
- No fixed step ceiling: current models are rated for hundreds of tool calls
- Measure your own rework threshold; decompose work beyond it
- Self-correction > length limits: verify intermediate results on long tasks
- Delegate heavy/isolated work to subagents (Orchestrator `new_task`); they return summary + test results
- Parallel subagents multiply tokens ~3–7× — only for genuinely independent work, cap at 2–3 concurrent

## Financial Safety Rails
- **Kimi Code is subscription-quota**: 5-hour rolling window + monthly total (Andante minimum; Moderato/Plus for `k3`; Allegretto/Pro for `k3` 1M / `highspeed`) — full table in the repo's `REFERENCE.md`
- **Burn rates**: `k3` (1M) ≈ 2× `k3-256k` · `highspeed` ≈ 3× — reserve `k3`/`max` for problems that need them
- **Extra Usage wallet**: keep topped up for deadline bursts
- **Open Platform (separate)**: K3 $3.00/$15.00 per 1M; K2.7 Code $0.95/$4.00; cache-hit input ~$0.16–$0.30
- **Alert**: hitting the 5-hour window repeatedly = under-tiered or over-delegating

## Mode Engineering
- **Architect** (`max`/`high`): planning, design, read-only analysis
- **Code** (`high`): implementation, edits, test runs
- **Ask** (`low`): Q&A and explanation
- **Debug** (`high`): root-cause analysis
- **Orchestrator**: decomposition + delegation; per-mode API profiles, sticky per subtask

## Error Handling & Loop Prevention
- If tool output contradicts your assumption: STOP and report — don't force the narrative
- Never retry the same failed command more than once without changing something
- Repeating sequence > 3 times: STOP, roll back to checkpoint, reassess
- Destructive Command Guard stays enabled

## Skills & Commands
- AGENTS.md is the cross-tool standard — keep it current (`/init` to bootstrap, or the `templates/AGENTS.md` starter)
- Reusable workflows go in `.roo/commands/*.md` (frontmatter: description, argument-hint, mode) — see the `costcheck.md` example
- Skills (`SKILL.md`) for loadable capabilities — bodies load on demand
- MCP servers live in `.roo/mcp.json` (project) or the extension's MCP settings (global); restrict per mode with `allowedMcpServers` in custom modes — keep the list minimal, every server's tools are listed in every prompt
