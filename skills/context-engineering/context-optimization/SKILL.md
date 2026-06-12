---
name: Context Optimization Techniques
description: Extend effective context capacity through KV-cache optimization, observation masking, compaction, and context partitioning — ordered by impact and risk.
when_to_use: when context budgets or token costs constrain task complexity, observation masking can replace verbose tool outputs with retrievable references, prefix or KV-cache hit rate needs improvement, or retrieval scoping can reduce irrelevant loaded context
version: 2.1.0
languages: all
---

# Context Optimization Techniques

Context optimization extends the effective capacity of limited context windows through strategic compression, masking, caching, and partitioning. Effective optimization increases useful capacity without requiring larger models or longer windows — but only when applied with measurement discipline.

## When to Activate

Activate this skill when:
- Context budgets or token costs constrain task complexity
- Observation masking can replace verbose tool outputs with retrievable references
- Prefix or KV-cache hit rate needs improvement
- Retrieval scoping can reduce irrelevant loaded context
- Context partitioning can extend effective capacity across agents
- Budget triggers are needed for masking, compaction, or partitioning

Do not activate this skill for adjacent work:
- Explaining why attention or context windows behave this way: `context-fundamentals`.
- Diagnosing active lost-in-middle, poisoning, distraction, confusion, or clash: `context-degradation`.
- Designing a structured handoff summary for a long conversation: `context-compression`.
- Storing large outputs, plans, or logs as files: `filesystem-context`.

## Four Primary Strategies (in priority order)

### 1. KV-Cache Optimization (cheapest — apply first)

Reorder and stabilize prompt structure so the inference engine reuses cached Key/Value tensors. Low quality risk, immediate cost and latency savings.

Apply this ordering in every prompt:
1. System prompt (most stable — never changes within a session)
2. Tool definitions (stable across requests)
3. Frequently reused templates and few-shot examples
4. Conversation history
5. Current query and dynamic content (least stable — always last)

**Target**: 70%+ cache hit rate → 50%+ cost reduction, 40%+ latency reduction.

**Critical**: even a single whitespace change in the prefix invalidates the entire cached block downstream. Remove timestamps, session counters, and request IDs from system prompts.

### 2. Observation Masking (largest capacity gains)

Replace verbose tool outputs with compact references once their purpose has been served. The original content remains retrievable if needed.

**Rules**:
- **Never mask**: observations critical to the current task, most recent turn, active reasoning chains, error outputs during debugging.
- **Mask after 3+ turns**: verbose outputs whose key points have been extracted. Replace with: `[Obs:{ref_id} elided. Key: {summary}. Full content retrievable.]`
- **Always mask immediately**: repeated/duplicate outputs, boilerplate headers.

**Target**: 60-80% reduction in masked observations, <2% quality impact.

### 3. Compaction (for accumulated context)

Summarize accumulated context when utilization exceeds 70%, then reinitialize with the summary.

Priority order for what to compress: tool outputs first (consume 80%+ of tokens), then old conversation turns, then retrieved documents. **Never compress the system prompt**.

**Target**: 50-70% token reduction with <5% quality degradation.

### 4. Context Partitioning (for tasks exceeding single window)

Split work across sub-agents with isolated contexts when a single window cannot hold the full problem. Plan partitioning when estimated task context exceeds 60% of the window limit.

**Warning**: coordination has real token cost — only partition when the savings exceed the overhead (typically requires 3+ independent subtasks).

## Optimization Decision Framework

| Context Composition | First Action | Second Action |
|---|---|---|
| Tool outputs dominate (>50%) | Observation masking | Compaction of remaining turns |
| Retrieved documents dominate | Summarization | Partitioning if docs are independent |
| Message history dominates | Compaction with selective preservation | Partitioning for new subtasks |
| Multiple components contribute | KV-cache optimization first, then layer masking + compaction |
| Near-limit with active debugging | Mask resolved tool outputs only — preserve error details |

## Budget Management

Allocate explicit token budgets across context categories before the session begins:

```yaml
budgets:
  tool_outputs: 35%
  message_history: 30%
  retrieved_documents: 20%
  reserved_buffer: 15%
triggers:
  tool_outputs_over_budget: mask resolved observations
  total_context_over_70_percent: compact message history
  repeated_irrelevant_retrievals: tighten retrieval scope
```

## Performance Targets

| Technique | Token Reduction | Quality Impact | Latency |
|-----------|----------------|----------------|---------|
| Compaction | 50-70% | <5% degradation | <10% overhead |
| Masking | 60-80% | <2% impact | near-zero |
| Cache optimization | — | none | 40%+ reduction |
| Partitioning | net savings after coordination | varies | depends on subtask count |

## Gotchas

1. **Whitespace breaks KV-cache**: Even a single whitespace change invalidates the entire cache block downstream. Pin system prompts as immutable strings.
2. **Timestamps in system prompts destroy cache hit rates**: Move dynamic metadata into a user message or separate tool result appended after the stable prefix.
3. **Compaction under pressure loses critical state**: When the model performing compaction is itself at >85% utilization, its summarization quality degrades. Trigger compaction at 70-80%, not 90%+.
4. **Masking error outputs breaks debugging loops**: During active debugging (error in the last 3 turns), suspend masking for all error-related observations.
5. **Partitioning overhead can exceed savings**: For fewer than 3 independent subtasks, coordination overhead often exceeds context savings.
6. **Cache miss cost spikes after deployment changes**: Reordering tools or rewording the system prompt invalidates the entire prefix cache. Roll out prompt changes gradually.
7. **Compaction creates false confidence in stale summaries**: After compaction, re-validate the summary against the current task goal before proceeding.
