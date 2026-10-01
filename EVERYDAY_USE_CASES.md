# Everyday Use Cases - Kimi for Coding, Zoo Code & Kimi Code CLI v5.0.0

**Practical examples for common development tasks** (September 2026)

---

## 🚀 Quick Reference

| Task Type | Mode | Effort | Subagents? | Token Budget (single-thread) |
|-----------|------|--------|-----------|------------------------------|
| **Bug Fix** | Debug/Code | `high` | No | 8K–20K |
| **Test Writing** | Code | `low` | No | 4K–10K |
| **Refactoring** | Orchestrator → Code | `high` | Yes — isolate the extraction | 15K–40K total |
| **Code Review** | Ask/Architect | `high` | Yes — parallel per-file reviews | 12K–30K |
| **Documentation** | Code | `low` | No | 4K–8K |
| **Architecture** | Architect → Orchestrator | `max` → `high` | Yes — research subagents | 25K–60K total |

> There is **no fixed step limit**. Budgets above assume a single-thread session; parallel subagent fan-out typically multiplies total tokens ~3–7× — spend it only where tasks are independent.

---

## 🐛 Use Case 1: Bug Fix

### Scenario
"Button click doesn't update the counter"

### Session Flow

**Step 1: Context arrives automatically**
AGENTS.md and `.roo/rules` load at task start. The failing test output or error log goes in the *first* message — recent context is weighted most heavily.

**Step 2: Triage (Debug mode, effort `high`)**
```
Analyze the counter update flow and identify the root cause of:
"TypeError: Cannot read property 'count' of undefined"
```
Agent reads the relevant files just-in-time; cap any single file read (grep for ranges rather than dumping 2000 lines).

**Step 3: Fix (Code mode, effort `high`)**
```
Fix the root cause. Minimal diff; no refactors.
```

**Step 4: Verify**
```
Run the counter tests and confirm the fix.
```

**Total**: ~10K–15K tokens ✅ · If the session derails, roll back to the checkpoint and retry with the error log — don't push a poisoned conversation forward.

---

## 🧪 Use Case 2: Test Writing

### Scenario
Add unit tests for a new API endpoint

### Session Flow

**Step 1: Load context**
```
Read src/api/userEndpoints.ts and src/types/User.ts, then propose a test plan before writing anything.
```

**Step 2: Generate (Code mode, effort `low`)**
```
Generate the test suite following the plan and existing test conventions.
```
`low` effort is right for mechanical generation against a clear spec.

**Step 3: Run and close gaps (effort `high` if failures are subtle)**
```
Run the tests. For each failure, diagnose and fix — don't paper over assertions.
```

**Total**: ~6K–10K tokens ✅ — one of the cheapest, highest-confidence tasks. Batch several test files in one session for a stable prompt cache.

---

## ♻️ Use Case 3: Refactoring (Orchestrator + Subagent)

### Scenario
Extract a reusable component from a 500+ line monolithic file

### Session Flow

**Step 1: Plan (Architect mode, effort `max`)**
```
Read src/components/Dashboard.tsx and identify the best extraction candidates.
Propose an extraction plan: new component boundaries, prop interfaces, import updates.
```
Human reviews the plan — this is the cheapest place to catch a mistake.

**Step 2: Delegate (Orchestrator mode)**
```
Spawn a subtask: extract UserProfile per the approved plan, run typecheck and tests, and return a summary + test results.
```
The subagent works in an isolated context window and returns only the summary — your orchestrator context stays clean (the "Boomerang" pattern, now native).

**Step 3: Review the diff (Code mode, effort `high`)**
```
Review the subtask's diff for behavior changes and convention drift.
```

**Total**: ~25K–40K tokens with fan-out ✅ · Rollback safety: the subtask ran on its own checkpoint.

**When *not* to delegate**: if the extraction touches 2 files and takes 10 minutes, do it directly — subagent overhead isn't free.

---

## 👀 Use Case 4: Code Review (Parallel Subagents)

### Scenario
Review a PR with 5 changed files

### Session Flow

**Step 1: Triage the diff yourself (Ask mode, effort `high`)**
```
Summarize what this PR changes and which files carry the behavioral risk.
```

**Step 2: Parallel review (Orchestrator mode)**
```
Spawn one subtask per high-risk file: review for security, correctness, and convention violations. Return findings as a ranked list with file:line references.
```
Subagents review in parallel, each in an isolated context — total latency ≈ one review, cost ≈ 5.

**Step 3: Synthesize (effort `high`)**
```
Merge the findings, deduplicate, and produce the final review comment.
```

**Total**: ~20K–30K tokens ✅ · Budget tip: cap concurrency at 2–3 for quota-sensitive accounts; the 4th and 5th reviews rarely change the outcome.

---

## 📝 Use Case 5: Documentation

### Scenario
Document a new API endpoint

### Session Flow

**Step 1: Generate (Code mode, effort `low`)**
```
Read src/routes/newEndpoint.ts and generate API documentation with request/response examples, following docs/ existing style.
```

**Step 2: Self-check (effort `low`)**
```
Verify every documented field, status code, and example against the actual implementation. Fix mismatches.
```

**Total**: ~5K–8K tokens ✅ — run in a batch with other docs tasks to keep the cache warm.

---

## 🏗️ Use Case 6: Architecture Design

### Scenario
Design a new microservice for user notifications

### Session Flow

**Step 1: Research (Architect mode, effort `max`)**
```
Read docs/ARCHITECTURE.md, src/services/README.md, and the existing email/push services. Summarize the patterns this service must follow.
```

**Step 2: Design (Architect mode, effort `max`)**
```
Design the notification microservice: interfaces, data flow, failure modes, scaling characteristics. Present 2 options with trade-offs.
```

**Step 3: Validation subagent**
```
Spawn a subtask: adversarially review this design for scalability, security, and operational blind spots. Return a critique.
```

**Step 4: Implementation plan (Orchestrator mode)**
```
Break the approved design into independently testable work packages, each small enough to complete in one session.
```

**Total**: ~30K–60K tokens across sessions ✅ · The design lives in a file (`docs/DESIGN-notifications.md`), not in chat — future sessions read the file, keeping context cheap and the prompt cache stable.

---

## 💡 Best Practices for Everyday Use

### 1. Let the harness manage context
Auto-condensation and Smart Code Folding handle overflow. Don't run ritual `/clear`s; start a **new task** per unit of work instead. Don't edit rules or AGENTS.md mid-session — it busts the prompt cache.

### 2. Put durable knowledge in files
Designs, decisions, and conventions go in `docs/` + AGENTS.md. Chat is for the current task only.

### 3. Choose effort deliberately
- `low`: formatting, boilerplate, docs, mechanical tests
- `high`: daily driver — implementation, debugging, review
- `max`: architecture, ambiguous multi-system problems

### 4. Delegate for isolation, not for show
Subagents pay off for: parallel independent work, heavy-context reads (return summary only), disposable experiments. They cost ~3–7× the tokens of a single-thread run.

### 5. Verify, then verify again
Tests after every behavior change; checkpoints before risky operations; Destructive Command Guard stays enabled.

### 6. Measure your own horizon
Log where sessions start needing rework. Decompose work beyond *your* threshold — nobody else's number (18 steps or otherwise) applies to your repo.

---

## 📊 Cost Tracking

Costs show in the **task header** (tokens in/out + estimated $) and aggregate in **History**, including subtask roll-up. Set input/output prices in Model Configuration for accurate estimates.

### Reference points (Sept 2026)

Full numbers live in **`REFERENCE.md`** (verified 2026-09-30). The shape:

- **Kimi Code membership**: quota-based — 5-hour rolling window + monthly total. Practical limit is your tier, not a dollar meter. `k3` (1M) burns ≈2× `k3-256k`; `highspeed` ≈ 3×.
- **Open Platform pay-as-you-go** (separate product): K3 $3.00 in / $15.00 out per 1M; K2.7 Code $0.95 / $4.00; cache-hit input ~$0.16–$0.30.

### Rough monthly shape (individual, daily use)

- Mostly `kimi-for-coding` @ `high`, occasional `k3`: comfortably within **Plus** tier
- Daily `k3` + parallel subagent fan-out: plan for **Pro**
- Keep the Extra Usage wallet topped up if a deadline week might burst the quota

---

## 📈 Success Metrics

Track these for your projects:

| Metric | Target | How to Measure |
|--------|--------|----------------|
| **Task success without rework** | >85% | Sessions / month that passed tests first time |
| **Rework beyond horizon** | declining | Your session log |
| **Cost per completed task** | trend down | Task header + History |
| **Fan-out ratio** | ≤3× for ≤2 subagents; low end of the 3–7× band | History subtask roll-up |
| **Cache-friendly sessions** | stable prefixes, no mid-session rule edits | Self-review |

---

**Version**: 5.0.0
**Applies to**: Kimi for Coding endpoint (K2.8 Preview / K3) with Zoo Code or Kimi Code CLI
**Last Updated**: September 30, 2026
