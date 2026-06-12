---
name: Memory Systems for Agents
description: Choose and implement persistent semantic memory architectures for agent systems requiring cross-session knowledge retention, entity tracking, temporal validity, and structured retrieval.
when_to_use: when implementing cross-session memory for agents, comparing memory frameworks (Mem0, Zep/Graphiti, Letta, Cognee, LangMem), designing entity tracking with temporal validity, or deciding between file-system memory vs vector stores vs knowledge graphs
version: 1.0.0
languages: all
---

# Memory Systems for Agents

This skill addresses persistent semantic memory architectures for agent systems requiring cross-session knowledge retention, entity tracking, temporal validity, graph or vector retrieval, memory consolidation, and memory benchmark selection.

## When to Activate

Activate this skill when:
- Implementing cross-session knowledge retention for agents
- Choosing between memory frameworks based on retrieval patterns
- Designing entity tracking with temporal validity
- Setting up memory benchmarks (LoCoMo, LongMemEval, DMR)
- Deciding between file-system memory vs vector stores vs knowledge graphs

Do not activate this skill for adjacent work:
- Session-scoped scratchpads and plan files: `filesystem-context`.
- Compacting conversation history into summaries: `context-compression`.
- Just-in-time context loading without persistent storage: `context-optimization`.

## Core Principle

**Start with the simplest viable layer and add complexity only when retrieval quality degrades.**

File-system memory can outperform specialized tools on some benchmarks, warranting validation before infrastructure investment.

## Framework Selection by Retrieval Pattern

| Framework | Best For |
|-----------|----------|
| **Mem0** | Multi-tenant systems with broad integrations |
| **Zep/Graphiti** | Bi-temporal modeling — tracking both when events occurred and when they were ingested; relationship reasoning |
| **Letta** | Agent introspection and stateful services with self-editing memory and tiered storage |
| **Cognee** | Dense semantic graphs with customizable extraction pipelines |
| **LangMem** | Memory tools tightly coupled to LangGraph workflows |

## Memory Layer Progression

Escalate only when retrieval quality at the current layer degrades:

1. **Working context** — in-prompt state for single-session tasks
2. **Session-scoped files** — markdown/YAML files for multi-turn tasks
3. **Cross-session key-value stores** — simple persistent lookup
4. **Vector stores** — semantic similarity retrieval
5. **Knowledge graphs** — relationship reasoning
6. **Temporal knowledge graphs** — bi-temporal modeling (Zep/Graphiti)

## Critical Design Principles

- **Measure retrieval quality first**: benchmark against LoCoMo, LongMemEval, or DMR before and after architectural changes.
- **Embed model consistency**: switching embedding models corrupts existing vector spaces — plan for migration costs upfront.
- **Memory consolidation**: implement periodic consolidation to merge related memories and prevent unbounded growth.
- **Temporal validity**: every memory entity needs validity bounds and explicit justification to enable auditing and conflict resolution.

## Gotchas

1. **Context stuffing**: loading all available memories into context degrades attention quality. Use selective retrieval, not bulk loading.
2. **Unbounded memory growth**: without consolidation policies, memory size grows indefinitely and retrieval quality degrades.
3. **Stale memories corrupt agent behavior**: implement expiry policies and revalidation triggers for time-sensitive information.
4. **Embedding model mismatches**: using different embedding models for indexing and querying degrades vector retrieval quality.
5. **Over-engineering prematurely**: file-system prototyping often matches specialized tool performance — validate need before adding infrastructure.
6. **Tool complexity ≠ retrieval quality**: benchmark evidence suggests that reliable retrieval matters more than framework sophistication.
