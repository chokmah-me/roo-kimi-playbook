# Reference — Volatile Facts (single source of truth)

Facts Moonshot can change without notice live here. **Last verified: September 30, 2026**
against the [Kimi Code docs](https://www.kimi.com/code/docs/en/) and the
[Moonshot Open Platform](https://platform.moonshot.ai). Re-verify anything you
will act on (tier, price, model ID) on those pages before spending money.

The strategy docs (`PLAYBOOK.md`, `EVERYDAY_USE_CASES.md`, `.roo/rules.md`)
link here instead of repeating these numbers.

## Endpoints

| Product | Protocol | Base URL |
| :--- | :--- | :--- |
| Kimi Code (`/coding/`) | OpenAI-compatible | China: `https://api.kimi.com/coding/v1` · Overseas: `https://api.kimi.ai/coding/v1` |
| Kimi Code (`/coding/`) | Anthropic-compatible | China: `https://api.kimi.com/coding/` · Overseas: `https://api.kimi.ai/coding/` |
| Open Platform (separate product) | OpenAI-compatible | Overseas: `https://api.moonshot.ai/v1` · China: `https://api.moonshot.cn/v1` |

Kimi Code keys (`sk-kimi-...`, max 5 per account, from the Kimi Code Console)
do **not** work on the Open Platform and vice versa (401 otherwise).

## Model IDs on the Kimi Code endpoint

| Model ID | Actual model | Context | Minimum tier (per official docs) | Effort levels |
| :--- | :--- | :--- | :--- | :--- |
| `kimi-for-coding` | K2.8 Preview | 1M | Andante | `low` / `high` / `max` |
| `k3` | K3 (flagship) | 1M | Moderato / Plus; **1M context needs Allegretto / Pro** | `low` / `high` / `max` |
| `k3-256k` | K3 | 256K | Moderato / Plus | `low` / `high` / `max` |
| `kimi-for-coding-highspeed` | K2.7 Code HighSpeed | 256K | Allegretto / Pro | `low` / `high` / `max` |

Notes:
- `k3` and `k3-256k` return identical results within 256K context; `k3-256k`
  does not support video input.
- Max output tokens on the endpoint: **32768** (native providers set this for you;
  set it manually on the OpenAI-compatible track).
- Kimi Code CLI model aliases use the form `kimi-code/<model-id>`
  (e.g. `kimi -m kimi-code/k3`).

## Membership tiers & quota

| Tier (official naming) | ≈ Price/mo (Sept 2026) | `kimi-for-coding` | `k3` / `k3-256k` | `highspeed` / `k3` 1M |
| :--- | :--- | :---: | :---: | :---: |
| Andante | $19 | ✓ | – | – |
| Moderato / Plus | $39 | ✓ | ✓ | – |
| Allegretto / Pro | $99 | ✓ | ✓ | ✓ |
| Allegro | $199 | ✓ | ✓ | ✓ |

- Quota: rolling **5-hour window** + **monthly total**; optional **Extra Usage**
  wallet (pay-as-you-go top-up) covers overage.
- Quota burn (relative): `k3` (1M) ≈ **2×** `k3-256k`; `highspeed` ≈ **3×**.
- New subscriptions were briefly paused in July 2026 (K3 GPU capacity) —
  check current availability on the membership page.

## Open Platform pricing (pay-as-you-go, per 1M tokens, Sept 2026)

| Model | Input | Cached input | Output |
| :--- | :--- | :--- | :--- |
| Kimi K3 | $3.00 | $0.30 | $15.00 |
| Kimi K2.7 Code | $0.95 | $0.19 | $4.00 |
| Kimi K2.6 | $0.95 | $0.16 | $4.00 |

Batch API: 60% of standard (K2.6 / K2.7 Code; K3 not supported).
Cached input is ~5× cheaper than uncached — the economic argument for
prompt-cache hygiene in `PLAYBOOK.md` Part II.
