---
name: Context Degradation Patterns
description: Diagnose and mitigate context degradation — lost-in-middle failures, context poisoning, distraction, confusion, and clash — with specific detection signals and mitigation strategies.
when_to_use: when agent performance degrades unexpectedly during long conversations, debugging cases where agents produce incorrect or irrelevant outputs, designing systems that must handle large contexts reliably, or investigating lost-in-middle phenomena
version: 2.1.0
languages: all
---

# Context Degradation Patterns

Diagnose and fix context failures before they cascade. Context degradation is not binary — it is a continuum that manifests through five distinct, predictable patterns: lost-in-middle, poisoning, distraction, confusion, and clash. Each pattern has specific detection signals and mitigation strategies. Treat degradation as an engineering problem with measurable thresholds, not an unpredictable failure mode.

## When to Activate

Activate this skill when:
- Agent performance degrades unexpectedly during long conversations
- Debugging cases where agents produce incorrect or irrelevant outputs
- Designing systems that must handle large contexts reliably
- Evaluating context engineering choices for production systems
- Investigating "lost in middle" phenomena in agent outputs
- Analyzing context-related failures in agent behavior

Do not activate this skill for adjacent work:
- Explaining foundational context mechanics without an active failure: `context-fundamentals`.
- Applying token-efficiency tactics after the failure pattern is known: `context-optimization`.
- Designing a compression or handoff summary strategy: `context-compression`.
- Persisting large outputs, logs, or scratch state outside the prompt: `filesystem-context`.

## Core Concepts

Structure context placement around the attention U-curve: beginning and end positions receive reliable attention, while middle positions suffer materially reduced recall accuracy in long-context experiments. This is not a model bug but a consequence of attention mechanics.

Treat context poisoning as a circuit breaker problem. Once a hallucination, tool error, or incorrect retrieved fact enters context, it compounds through repeated self-reference. Detection requires tracking claim provenance; recovery requires truncating to before the poisoning point or restarting with verified-only context.

Filter aggressively before loading context — even a single irrelevant document measurably degrades performance on relevant tasks. Models cannot "skip" irrelevant context; they must attend to everything provided.

Isolate task contexts to prevent confusion. When context contains multiple task types or switches between objectives, models incorporate constraints from the wrong task.

Resolve context clash through priority rules, not accumulation. When multiple correct-but-contradictory sources appear in context, mark contradictions explicitly, establish source precedence, and filter outdated versions before they enter context.

## The Five Degradation Patterns

### 1. Lost-in-Middle

Place critical information at the beginning and end of context, never in the middle. The U-shaped attention curve means middle-positioned information suffers 10-40% reduced recall accuracy. For contexts over 4K tokens, this effect becomes significant.

**Detection signals**: correct information exists in context but the model ignores it, responses contradict provided data, or the model "forgets" instructions given earlier in a long prompt.

### 2. Context Poisoning

Validate all external inputs before they enter context. Tool outputs, retrieved documents, and model-generated summaries are the three primary poisoning vectors.

**Detection signals**: degraded output quality on previously-successful tasks, tool misalignment, and hallucinations that persist despite explicit correction.

**Recovery**: remove poisoned content, not by adding corrections on top. Truncate to before the poisoning point, restart with clean context preserving only verified information.

### 3. Context Distraction

Curate what enters context rather than relying on models to ignore irrelevant content. Even a single distractor document triggers measurable performance degradation.

**Mitigation**: apply relevance filtering before loading retrieved documents. Prefer tool-call-based access over pre-loading.

### 4. Context Confusion

Segment different tasks into separate context windows. Context confusion is distinct from distraction — it concerns the model applying wrong-context constraints to the current task.

**Signs**: responses addressing the wrong aspect of a query, tool calls appropriate for a different task, outputs mixing requirements from multiple sources.

### 5. Context Clash

Establish source priority rules before conflicts arise. Multiple pieces of information can be individually correct but mutually contradictory.

**Mitigation**: implement version filtering to exclude outdated information before it enters context. When contradictions are unavoidable, mark them explicitly with structured conflict annotations.

## The Four-Bucket Mitigation Framework

**Write** — Save context outside the window using scratchpads, file systems, or external storage. Use when context utilization exceeds 70% of the window.

**Select** — Pull only relevant context into the window through retrieval, filtering, and prioritization. Use when distraction or confusion symptoms appear.

**Compress** — Reduce tokens while preserving information through summarization, abstraction, and observation masking. Use when context is growing but all content is relevant.

**Isolate** — Split context across sub-agents or sessions to prevent any single context from growing past its degradation threshold.

## Empirical Thresholds

Degradation onset varies significantly by model family and task type. As a general rule, expect degradation to begin at 60-70% of the advertised context window for complex retrieval tasks.

Performance doesn't degrade gradually — degradation follows a non-linear cliff edge pattern. Models maintain stable output until a threshold (typically 8K–16K tokens, varying by model), then drop sharply. Set compaction triggers at 70% of known onset point, not at degradation itself.

## Guidelines

1. Monitor context length and performance correlation during development
2. Place critical information at beginning or end of context
3. Implement compaction triggers before degradation becomes severe
4. Validate retrieved documents for accuracy before adding to context
5. Use versioning to prevent outdated information from causing clash
6. Segment tasks to prevent context confusion across different objectives
7. Design for graceful degradation rather than assuming perfect conditions
8. Test with progressively larger contexts to find degradation thresholds

## Gotchas

1. **Normal variance looks like degradation**: Establish a baseline over multiple runs and look for sustained, correlated decline tied to context growth.
2. **Model-specific thresholds go stale**: Re-benchmark quarterly and after any major model update.
3. **Needle-in-haystack scores create false confidence**: Real workloads require multi-fact reasoning; needle tests measure single-fact retrieval only.
4. **Contradictory retrieved documents poison silently**: Implement contradiction detection in the retrieval layer before documents enter context.
5. **Prompt quality problems masquerade as degradation**: Verify the same prompt works correctly at low context lengths before diagnosing degradation.
6. **Degradation is non-linear with a cliff edge**: Set compaction triggers at 70% of known onset, not at the onset itself.
