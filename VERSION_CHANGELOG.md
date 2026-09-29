# Version Changelog

All notable changes to the Kimi for Coding & Zoo Code Playbook (formerly the Kimi K2 & Roo Code Playbook) will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [5.0.0] - 2026-09-30

### Breaking Changes
- **Harness: Roo Code → Zoo Code.** Roo Code was discontinued April 2026 (final release v3.54.0; repo archived). All instructions now target **Zoo Code**, the Apache-2.0 community successor fork (docs.zoocode.dev), plus Moonshot's official **Kimi Code CLI** as a third setup track. Legacy `.roo/` config paths work unchanged.
- **Model: K2-era → K2.8 Preview / K3.** The `kimi-for-coding` model ID now runs Kimi K2.8 Preview (upgraded in place September 11, 2026): 1M context, max output **32768** (was 16384). New endpoint model IDs: `k3`, `k3-256k`, `kimi-for-coding-highspeed`.
- **Reasoning toggle replaced by effort levels:** `low` / `high` / `max` (third-party `medium` maps to `high`; `ultra`/`xhigh` map to `max`).
- **Removed the "18-step limit."** Never an official limit; K2 Thinking (Nov 2025) was rated for 200–300 tool calls. Replaced with measured-horizon management and continuous verification.
- **Cost model corrected:** the `/coding/` endpoint is subscription-quota based (membership; 5-hour rolling window + monthly total), not ~$3.00/1M. Per-token pricing moved to a separate "Open Platform" table (K3 $3.00/$15.00; K2.7 Code $0.95/$4.00 per 1M).
- **"Legacy Format" demoted** from critical to an OpenAI-compatible troubleshooting fallback; recommended path is Zoo Code's native Kimi Code provider (OAuth, v3.72+).
- **`/cost` and `/clear` are not built-in commands.** Cost shows in the task header + History (subtask roll-up); repeatable checks ship as custom `.roo/commands/`.

### Added
- **Kimi Code CLI track** — OpenAI/Anthropic protocol configuration, no proxies
- **Horizon management** — measure your own 80% horizon; decompose beyond it; subagent isolation
- **Harness-managed context** — auto-condensation v2, Smart Code Folding, checkpoints; prompt-cache hygiene rules (stable prefixes, compact rarely, no mid-session rule edits)
- **Orchestrator-native workflows** — parallel subagents with isolated contexts ("Boomerang"), per-mode/sticky API profiles, Destructive Command Guard
- **AGENTS.md + skills** — cross-tool config standard, `/init` bootstrap, `.roo/commands/` conventions
- **Compliance note** — User-Agent tampering prohibited by Kimi Code terms
- **Key-type pitfall documented** — Open Platform keys ≠ Kimi Code keys (401)

### Removed
- LiteLLM proxy detail section (replaced by a short enterprise routing note)
- Manual top/tail file-ordering rituals and 5–7 prompt `/clear` cadence
- Self-reported v4.x performance claims (92% / 25% reduction) — replaced with honest benchmark context and self-measurement targets

### Sources
Kimi Code docs (kimi.com/code/docs/en), Moonshot Open Platform pricing (platform.moonshot.ai), Zoo Code releases/docs (github.com/Zoo-Code-Org, docs.zoocode.dev), Kimi K2 Thinking model card (Hugging Face), Steel.dev SWE-bench Verified leaderboard (Sep 2026), Anthropic 2026 Agentic Coding Trends, METR time-horizon analyses.

## [4.1.3] - 2025-12-12

### Added
- **`.clinerules`** - Critical instruction set for AI assistants
  - 95% success threshold within 18 sequential tool calls
  - 28+ step failure threshold
  - File size limits (500 lines)
  - Error loop prevention (max 1 retry)
  - Boomerang handoff pattern

- **`.roo/rules.md`** - Roo Code specific configuration
  - Financial safety rails ($5/day budget, $10 balance alerts)
  - Mode engineering (Architect/Code/Orchestrator modes)
  - Prompt caching strategies (75% target)
  - Hybrid model strategy (Kimi/DeepSeek)
  - Performance targets (92% completion, $0.50-$0.75/task)
  - Error handling & loop prevention
  - Context management limits (8k tokens routine, 200k+ for reviews)

- **`INSTALLATION_GUIDE.md`** - Complete setup instructions
  - Roo Code provider configuration
  - Legacy format enablement (critical)
  - API verification steps
  - Troubleshooting section
  - First test session template
  - LiteLLM proxy setup (optional enterprise feature)

- **`EVERYDAY_USE_CASES.md`** - 6 practical usage examples
  - Bug fixes (13K tokens, 11-17 steps)
  - Test writing (7K tokens, Turbo mode)
  - Refactoring (28K tokens, requires decomposition)
  - Code review (20K tokens, 12-20 steps)
  - Documentation (7K tokens, Turbo mode)
  - Architecture design (33K tokens, requires decomposition)

### Changed
- **Removed all Zenodo files** - Focused purely on configuration
  - Deleted: ZENODO_DESCRIPTION, ZENODO_UPDATE_STEPS, ZENODO_METADATA_GUIDE
  - Deleted: ZENODO_TROUBLESHOOTING, README_ZENODO
  - Repository now contains only essential configuration and documentation

- **Updated README.md** - Clear copy-paste instructions
  - What to copy to your project
  - Configuration files explained
  - Documentation guide
  - Quick start workflow

- **Streamlined package** - Only essential files for users
  - 7 files total (was 10)
  - ~35 KB total size (was ~74 KB)
  - Focus on actionable configuration templates

### Performance Metrics
- **Task completion rate**: 92% (vs 85% baseline in v4.0.0)
- **Token efficiency**: 25% reduction through context bias exploitation
- **Reliability**: Maintained through 18-step horizon management
- **Cost optimization**: $3.00 per 1M tokens with monitoring alerts

## [4.0.0] - 2025-12-11

### Added
- **NIST ACTS Integration** - Advanced Combinatorial Testing System
  - ACTSGenerator class for covering array generation
  - ACTSRunner class for test execution
  - 85 test configurations for 100% 3-way coverage
  - 99.4% reduction from exhaustive testing (13,824 tests)
  
- **NIST CCM Integration** - Combinatorial Coverage Measurement
  - CCMAnalyzer class for coverage analysis
  - 100% 2-way and 3-way coverage validation
  - Missing combination identification
  - Publication-quality coverage reports

- **CombinatorialTestingOrchestrator** - Complete workflow coordination
  - Automated pipeline from test generation to coverage analysis
  - Progress tracking and execution monitoring
  - JSON result export for reproducible research
  - CLI interface (scripts/run_acts.py)

- **Comprehensive Test Suite**
  - 13 unit tests for all integration modules
  - Tests for generator, runner, and analyzer
  - Mock integration tests
  - Edge case handling

- **Documentation**
  - docs/ACTS_INTEGRATION.md (600+ lines)
  - THESIS_VALIDATION_RESULTS.md (500+ lines)
  - API documentation with examples
  - Troubleshooting guide

### Validation Results
- **Test configurations**: 85 (vs 13,824 exhaustive)
- **Runtime**: ~2 hours (vs 347 hours exhaustive)
- **Coverage**: 100% 3-way parameter interactions
- **Success rate**: 100% (85/85 tests show ACP superiority)
- **Average improvement**: +42.3% reward (ACP vs Traditional)
- **Effect size**: Cohen's d = 5.447 (extremely large)
- **p-value**: < 10⁻¹⁶ (highly significant)

### Changed
- Enhanced validation capabilities with industry-standard tools
- Improved research reproducibility with NIST methodology
- Expanded thesis integration support

## [3.0.0] - 2025-12-11

### Added
- Version 3.0 with fully configurable parameters
- Advanced parameter control for sensitivity analysis
- Vulnerability distribution options (uniform, bimodal, exponential, concentrated)
- Configurable ACP strength, network size, connectivity
- Variable attacker learning rates
- Automated parameter sweep functionality
- Statistical confidence level options (90%, 95%, 99%)
- Bootstrap validation with configurable samples

### Changed
- Refactored to support parameter configuration
- Enhanced statistical analysis capabilities
- Improved documentation structure

## [2.0.0] - 2025-12-10

### Added
- Parallel power analysis with 1000+ episodes
- Statistical validation with confidence intervals
- Bootstrap validation (10,000 samples)
- Publication-quality visualization (300 DPI)
- Comprehensive scaling analysis

### Performance
- Achieved 322 episodes/second on standard hardware
- Linear scaling up to CPU core count
- Memory-efficient implementation for large-scale runs

### Statistical Validation
- Statistical power: 100% (exceeds 95% threshold)
- Effect size: Cohen's d = 5.447 (extremely large effect)
- p-value: < 10^-16 (highly significant)
- Sample size: 500+ episodes per group

## [1.0.0] - 2025-12-09

### Added
- Initial implementation of ACP simulation
- Basic cognitive attacker model (IBLT-based)
- Pessimistic defender baseline
- Optimistic ACP defender
- Network environment simulation
- Basic statistical analysis

### Features
- 100-episode quick test
- Cognitive latency exploitation
- Memory poisoning via deception
- Action distribution analysis

## Version Numbering

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR** version: Incompatible API changes or fundamental algorithm changes
- **MINOR** version: New features, backward-compatible
- **PATCH** version: Bug fixes, backward-compatible

**Current Version**: 5.0.0

**Release Process**:
1. Update version number in `README.md` and `VERSION_CHANGELOG.md`
2. Commit changes: `git commit -m "release: version X.Y.Z"`
3. Create tag: `git tag -a vX.Y.Z -m "Version X.Y.Z"`
4. Push to repository: `git push origin master && git push origin vX.Y.Z`
5. Create GitHub release with release notes

## Links

- [GitHub Repository](https://github.com/chokmah-me/roo-kimi-playbook)
- [Latest Release](https://github.com/chokmah-me/roo-kimi-playbook/releases/tag/v5.0.0)
- [Issues](https://github.com/chokmah-me/roo-kimi-playbook/issues)
- [Documentation](https://github.com/chokmah-me/roo-kimi-playbook/blob/master/README.md)
