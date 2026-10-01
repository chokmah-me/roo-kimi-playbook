---
description: Report this session's quota/cost position and the top burn reducers that apply
argument-hint: ""
mode: any
---

# /costcheck

1. Read the task header: tokens in/out and estimated cost for the current task.
2. Open History and note the subtask roll-up — what is the fan-out ratio
   versus a single-thread run?
3. Report, in under 10 lines:
   - current task cost and quota-window risk (are we near the 5-hour wall?),
   - the top 2 burn reducers that apply right now: drop effort to `low` for
     rote work; stop fanning out subagents; avoid mid-session rule/AGENTS.md
     edits that bust the prompt cache; defer `k3` / `max` effort to where it pays.
