# Kimi K2 & Roo Code Playbook v4.1.3

**Practitioner's Playbook: Agentic Mesh Configuration for Kimi K2 & Roo Code**

Complete configuration guide for optimizing Kimi K2's agent-tuned model with Roo Code.

**Latest Release**: v4.1.3 (Enhanced with Kimi K2 efficiency optimizations)

## 📦 Package Contents

### Core Configuration Files
- **`.clinerules`** - Critical instruction set for AI assistants
- **`.roo/rules.md`** - Roo Code specific configuration rules

### Documentation
- **`PLAYBOOK.md`** - Main Kimi K2 configuration guide
- **`INSTALLATION_GUIDE.md`** - Step-by-step setup instructions
- **`EVERYDAY_USE_CASES.md`** - Practical usage examples
- **`VERSION_CHANGELOG.md`** - Version history and changes

## 🚀 Quick Start

### For New Projects

Copy these files to your project root:

```bash
# Copy configuration files
cp .clinerules /path/to/your/project/
cp -r .roo /path/to/your/project/

# Copy documentation for reference
cp PLAYBOOK.md /path/to/your/project/
cp INSTALLATION_GUIDE.md /path/to/your/project/
cp EVERYDAY_USE_CASES.md /path/to/your/project/
```

### Configuration Files Explained

#### `.clinerules` - Critical Instructions
```bash
# 🛑 CRITICAL INSTRUCTION SET 🛑
# 1. NO ACTION WITHOUT CONTEXT: Read CONTEXT.md first
# 2. VERIFY FIRST: First tool call MUST be read_file("CONTEXT.md")
# 3. 18-STEP LIMIT: Stop and ask for sub-task breakdown if exceeded
# 4. NO RAW DUMPS: Output Specifications or Diffs only

# 🔄 The "Boomerang" Handoff
# - Orchestrator: Expect "Boomerang" return (Summary + Test Result)
# - Code Node: Return results immediately. Do not hold context open
```

#### `.roo/rules.md` - Roo Code Configuration
```bash
# Provider Settings
Provider: OpenAI Compatible
Base URL: https://api.kimi.com/coding/v1
Model: kimi-for-coding
Max Output: 16384
Reasoning: Medium

# Critical Rules
1. ALWAYS enable Legacy Format in Roo Code Advanced settings
2. NEVER exceed 18 steps without decomposition
3. ALWAYS load CONTEXT.md first (top bias exploitation)
4. MONITOR reasoning token ratio (alert if >40%)
5. USE /cost command every 5-7 prompts

# Context Strategy
- Load critical files FIRST (first 25% of context)
- Keep error logs LAST (last 25% of context)
- Remove redundant information regularly
- Use /clear before complex tasks

# Reasoning Toggle
- Medium (default): Complex logic, architecture, refactoring
- Low (Turbo): Tests, docs, formatting, simple fixes

# Cost Governance
- Target: $3.00 per 1M tokens
- Alert: Reasoning tokens >40% of total
- Reset: Every 18 steps or when cost exceeds budget
```

## 📚 Documentation Guide

### 1. Installation Guide (`INSTALLATION_GUIDE.md`)
Complete setup instructions including:
- Roo Code provider configuration
- Legacy format enablement
- API verification
- Troubleshooting

### 2. Everyday Use Cases (`EVERYDAY_USE_CASES.md`)
Practical examples for:
- Bug fixes (13K tokens, 11-17 steps)
- Test writing (7K tokens, Turbo mode)
- Refactoring (28K tokens, requires decomposition)
- Code review (20K tokens, 12-20 steps)
- Documentation (7K tokens, Turbo mode)
- Architecture design (33K tokens, requires decomposition)

### 3. Main Playbook (`PLAYBOOK.md`)
Comprehensive Kimi K2 configuration including:
- Token efficiency metrics
- Configuration guide
- Cost governance
- Performance metrics (92% task completion)
- Learning paths

### 4. Version Changelog (`VERSION_CHANGELOG.md`)
Complete version history from v4.0.0 to v4.1.0

## 🎯 Key Metrics Achieved

- **Task Completion**: 92% (vs 85% baseline)
- **Token Efficiency**: 25% reduction vs v4.0.0
- **Cost**: $3.00 per 1M tokens
- **Reliability**: 18-step horizon management
- **Context Optimization**: Top/tail bias exploitation

## 🔧 Configuration Summary

**Critical Settings**:
- **Endpoint**: `https://api.kimi.com/coding/v1`
- **Model**: `kimi-for-coding`
- **Max Output**: `16384`
- **Reasoning**: `Medium` (toggle to Low for rote tasks)
- **Legacy Format**: **ENABLED** (critical for compatibility)

## 📖 Usage Workflow

1. **Start**: `/clear` then load critical files first
2. **Monitor**: Use `/cost` every 5-7 prompts
3. **Optimize**: Toggle reasoning (Medium/Low) based on task
4. **Reset**: Clear context every 18 steps or when needed

## 📞 Support

For issues or questions:
- Check `INSTALLATION_GUIDE.md` for troubleshooting
- Review `EVERYDAY_USE_CASES.md` for examples
- See `PLAYBOOK.md` for comprehensive configuration

## 📄 License

MIT License

**Version**: 4.1.3
**Date**: December 12, 2025
**Repository**: https://github.com/chokmah-me/roo-kimi-playbook
**Release**: https://github.com/chokmah-me/roo-kimi-playbook/releases/tag/v4.1.3