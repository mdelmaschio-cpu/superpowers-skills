---
name: Context Compression Strategies
description: Compress long agent sessions using anchored iterative summarization, opaque compression, or regenerative summaries to preserve decisions, artifact trails, and next actions while reducing token costs.
when_to_use: when agent sessions exceed context window limits, designing conversation summarization strategies, debugging agents that forget modified files, or building durable handoff summaries that preserve decisions, files, risks, and next actions
version: 1.3.0
languages: all
---

# Context Compression Strategies

When agent sessions generate millions of tokens of conversation history, compression becomes mandatory. The naive approach is aggressive compression to minimize tokens per request. The correct optimization target is **tokens per task**: total tokens consumed to complete a task, including re-fetching costs when compression loses critical information.

## When to Activate

Activate this skill when:
- Agent sessions exceed context window limits
- Codebases exceed context windows (5M+ token systems)
- Designing conversation summarization strategies
- Debugging cases where agents "forget" what files they modified
- Building evaluation frameworks for compression quality
- Creating durable handoff summaries that preserve decisions, files, risks, and next actions

Do not activate this skill for adjacent work:
- General token-efficiency tactics such as masking, prefix caching, or partitioning: `context-optimization`.
- Diagnosing why a long context is failing before choosing a mitigation: `context-degradation`.
- Writing raw outputs, logs, or plans to files without summarizing them: `filesystem-context`.
- Designing long-term semantic memory across sessions: `memory-systems`.

## Three Production-Ready Approaches

### 1. Anchored Iterative Summarization (recommended for most cases)

Best for long-running sessions where file tracking matters. Maintains structured, persistent summaries with explicit sections for session intent, file modifications, decisions, and next steps. When compression triggers, summarize only the newly-truncated span and merge with the existing summary rather than regenerating from scratch.

**Why**: prevents drift that accumulates when summaries are regenerated wholesale — each regeneration risks losing details the model considers low-priority but the task requires.

### 2. Opaque Compression

Reserve for short sessions where re-fetching costs are low and maximum token savings are required. Achieves 99%+ compression ratios but sacrifices interpretability entirely.

**Warning**: never use when debugging or artifact tracking is critical — there is no way to verify what was preserved without running probe-based evaluation.

### 3. Regenerative Full Summary

Use when summary readability is critical and sessions have clear phase boundaries. Generates detailed structured summaries on each compression trigger.

**Weakness**: cumulative detail loss across repeated cycles — each full regeneration may deprioritize details preserved in earlier summaries.

## Optimize for Tokens-Per-Task, Not Tokens-Per-Request

Measure total tokens consumed from task start to completion, not tokens per individual request. When compression drops file paths, error messages, or decision rationale, the agent must re-explore, re-read files, and re-derive conclusions — wasting far more tokens than the compression saved.

**Primary quality signal**: track re-fetching frequency. If the agent repeatedly asks to re-read files it already processed, compression is too aggressive.

## Structured Summaries (Mandatory Sections)

Build structured summaries with explicit sections that prevent silent information loss. Each section acts as a checklist the summarizer must populate, making omissions visible:

```markdown
## Session Intent
[What the user is trying to accomplish]

## Files Modified
- auth.controller.ts: Fixed JWT token generation
- config/redis.ts: Updated connection pooling

## Decisions Made
- Using Redis connection pool instead of per-request connections

## Current State
- 14 tests passing, 2 failing

## Next Steps
1. Fix remaining test failures
2. Run full test suite
```

## Compression Triggers

| Strategy | Trigger Point | Trade-off |
|----------|---------------|-----------|
| Fixed threshold | 70-80% context utilization | Simple but may compress too early |
| Sliding window | Keep last N turns + summary | Predictable context size |
| Importance-based | Compress low-relevance sections first | Complex but preserves signal |
| Task-boundary | Compress at logical task completions | Clean summaries but unpredictable timing |

Default to **sliding window with structured summaries** for coding agents.

## Compression Quality Ratios

| Method | Compression Ratio | Quality Score |
|--------|-------------------|---------------|
| Anchored Iterative | 98.6% | 3.70/5 (best quality) |
| Regenerative | 98.7% | 3.44/5 |
| Opaque | 99.3% | 3.35/5 (best compression) |

## The Three-Phase Compression Workflow for Large Codebases

1. **Research Phase**: Explore architecture, compress exploration into a single research document.
2. **Planning Phase**: Convert research into an implementation specification (a 5M-token codebase compresses to ~2,000 words).
3. **Implementation Phase**: Execute against the specification, keeping context focused on the spec plus active working files.

## Probe-Based Evaluation

Traditional metrics (ROUGE, embedding similarity) fail to capture functional compression quality. Use probe-based evaluation instead:

| Probe Type | Example Question |
|------------|-----------------|
| Recall | "What was the original error message?" |
| Artifact | "Which files have we modified?" |
| Continuation | "What should we do next?" |
| Decision | "What did we decide about the Redis issue?" |

## Gotchas

1. **Never compress tool definitions or schemas**: Compressing function call schemas destroys agent functionality entirely.
2. **Compressed summaries hallucinate facts**: Always validate compressed output against source material before discarding originals — especially file paths, error codes, and numeric values.
3. **Compression breaks artifact references**: File paths, commit SHAs, variable names get paraphrased or dropped. Preserve identifiers verbatim in dedicated sections.
4. **Early turns contain irreplaceable constraints**: The first few turns often contain task setup and architectural decisions that cannot be re-derived. Protect them from compression.
5. **Aggressive ratios compound across cycles**: A 95% compression ratio applied three times leaves only 0.0125% of original tokens.
6. **Code and prose need different compression**: Code needs verbatim preservation; prose compresses well because natural language is redundant.
