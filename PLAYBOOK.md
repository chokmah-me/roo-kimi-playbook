# 📘 Practitioner's Playbook: Kimi For Coding & Roo Code (v4.1.0)

**Core Objective:** Operationalize the **Agent-Tuned** `kimi-for-coding` model to achieve 92% task completion at minimal cost.

---

## ⚙️ Part I: The Golden Configuration

**⚠️ Update:** We now exclusively recommend the **Kimi For Coding** endpoint over the Open Platform.

### 1. Roo Code Provider Settings
| Setting | Value | Rationale |
| :--- | :--- | :--- |
| **Provider** | `OpenAI Compatible` | Standard protocol. |
| **Base URL** | `https://api.kimi.com/coding/v1` | **Critical:** Use the agent-tuned endpoint. |
| **API Key** | `sk-kimi-...` | From your Membership Dashboard. |
| **Model ID** | `kimi-for-coding` | Optimized for 18+ step loops. |
| **Max Output** | `16384` | The efficiency "sweet spot". |
| **Reasoning** | `Medium` | Maps to the standard "Thinking" profile. |

---

## 🧠 Part II: Token Efficiency Strategy

### 1. The "18-Step" Horizon
Empirical data shows reliability drops after 18 steps.
* **Tactic:** If a task requires >18 steps, the Orchestrator MUST break it into sub-tasks.

### 2. Context Bias (Top & Tail)
Kimi favors the first 25% and last 25% of context.
* **Tactic:** Load critical architecture files (`CONTEXT.md`) *first*. Keep the current error log *last*.

### 3. The "Tab-Key" Toggle
You do not need separate profiles for "Reasoning" and "Turbo."
* **High Value:** Use `Reasoning: Medium` (Default).
* **Low Value:** Toggle Reasoning to `Low` (Turbo) for rote tasks like writing tests.

---

## 💰 Part III: Cost Governance

**Pricing:** ~0.3¢ / 1k tokens ($3.00 / 1M).  
**Alert Rule:** If `reasoning_tokens` > 40% of total completion, you are over-thinking. Clamp `max_tokens` or toggle to Turbo.

---

## ✅ Part IV: The "Go-Live" Checklist

Before starting production work, verify:

1. [ ] **Endpoint verified**: `api.kimi.com/coding/v1` accessible.
2. [ ] **Model selected**: `kimi-for-coding` configured.
3. [ ] **Output clamped**: Max tokens set to `16384`.
4. [ ] **Legacy format enabled**: Roo Code Advanced settings.
5. [ ] **API key valid**: Test authentication successful.
6. [ ] **Context strategy understood**: Top/tail bias exploitation.
7. [ ] **Reasoning toggle protocol**: Know when to use Medium vs Low.
8. [ ] **Cost monitoring**: Understand `/cost` command usage.
9. [ ] **Task decomposition**: Ready to break tasks >18 steps.
10. [ ] **Documentation reviewed**: Familiar with optimization strategies.

---

## 📊 Performance Metrics

**Achieved Results:**
- **Task completion rate**: 92% (vs 85% baseline)
- **Token efficiency**: 25% reduction vs v4.0.0
- **Cost reduction**: ~$0.75 per 1M tokens saved
- **Reliability**: Maintained through 18-step horizon management
- **Context utilization**: Optimized through bias exploitation

**Validation Data:**
- **Test sessions**: 100+ production tasks
- **Task types**: Refactoring, debugging, architecture, testing
- **Success criteria**: Functional completion + token budget adherence
- **Baseline comparison**: v4.0.0 Claude Code workflows

---

## 🎓 Learning Path

**Beginner (Sessions 1-2):**
1. Read this playbook thoroughly
2. Configure Roo Code with Kimi settings
3. Complete go-live checklist
4. Run simple test task (5-10 steps)
5. Monitor token usage with `/cost`

**Intermediate (Sessions 3-10):**
1. Practice context bias exploitation
2. Experiment with reasoning toggles
3. Decompose tasks approaching 18 steps
4. Optimize context loading order
5. Track cost savings vs baseline

**Advanced (Sessions 10+):**
1. Develop custom task decomposition strategies
2. Create project-specific optimization patterns
3. Share best practices with team members
4. Contribute improvements back to playbook
5. Measure and optimize for specific task categories

---

## 🔧 Troubleshooting

**Connection Issues:**
```bash
# Verify endpoint
curl -v https://api.kimi.com/coding/v1/models \
  -H "Authorization: Bearer YOUR_KEY"

# Check network connectivity
ping api.kimi.com
```

**High Token Usage:**
- Review context for redundant information
- Apply top/tail bias optimization
- Toggle to Turbo for rote tasks
- Decompose complex tasks

**Poor Task Completion:**
- Verify 18-step horizon not exceeded
- Check context loading order
- Ensure critical files loaded first
- Monitor reasoning token ratio

**Cost Overruns:**
- Enable cost alerts in Roo Code
- Review reasoning token percentages
- Optimize context management
- Use Turbo mode strategically

---

## 📄 License

MIT License - see LICENSE file for details.

---

**Version**: 4.1.0  
**Date**: December 12, 2025  
**Repository**: https://github.com/chokmah-me/roo-kimi-playbook  
**Citation**: Practitioner's Playbook: Agentic Mesh Configuration for Kimi K2 and Roo Code