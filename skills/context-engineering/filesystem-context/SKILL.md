---
name: Filesystem-Based Context Engineering
description: Use filesystem storage as an overflow layer for agent context when token limits constrain available space — dynamic context discovery, scratch pads, plan persistence, and sub-agent workspaces.
when_to_use: when tool outputs exceed 2000 tokens, tasks span multiple conversation turns and context must persist, multiple agents need shared state, or designing dynamic context discovery patterns that pull relevant context on demand rather than pre-loading everything
version: 1.0.0
languages: all
---

# Filesystem-Based Context Engineering for Agents

Context windows are limited while tasks often require more information than fits in a single window. Files enable agents to store and retrieve effectively unlimited context through a manageable interface.

## When to Activate

Activate this skill when:
- Tool outputs exceed ~2000 tokens and need to be offloaded
- Tasks span multiple conversation turns requiring durable state
- Multiple agents need shared state without message-passing overhead
- Designing dynamic context discovery — pulling relevant context on demand
- Building durable scratchpads for long-running agent loops

Do not activate this skill for adjacent work:
- Summarizing long conversations into handoff summaries: `context-compression`.
- General token-efficiency tactics: `context-optimization`.
- Long-term semantic memory with entity tracking: `memory-systems`.

## Core Principle: Dynamic Over Static

Prefer **dynamic context discovery** — pulling relevant context on demand — over static inclusion. Static content consumes tokens regardless of utility and reduces space for task-specific needs.

## Four Context Failure Modes

1. **Missing context** — information is absent; fix by persisting outputs to files
2. **Under-retrieved context** — retrieved content lacks necessary detail; fix through structured files and grep-friendly formats
3. **Over-retrieved context** — excessive retrieval wastes tokens; fix by offloading bulk content and returning references
4. **Buried context** — niche information scattered across files; fix using combined glob, grep, and semantic search

## Core Patterns

### Scratch Pads
Redirect large tool outputs (>2000 tokens) to files with summaries returned to context. The agent reads the summary but can always fetch the full file if needed.

### Plan Persistence
Store structured plans in YAML for re-reading across conversation turns. This allows long-running tasks to survive context compaction without losing the plan.

### Sub-Agent Workspaces
Route findings through filesystem isolation rather than message chains. Each sub-agent writes its results to files; the coordinator reads only what it needs.

### Dynamic Skill Loading
Store skill definitions as files, loading only when relevant rather than pre-loading all skills into context.

### Terminal Persistence
Automatically save and grep through logs instead of loading full terminal histories into context.

### Self-Modification
Agents can update their own instruction files across sessions (with validation guards).

## Practical Activation Criteria

**Use filesystem patterns when:**
- Tool outputs exceed ~2000 tokens
- Tasks span multiple turns
- Multiple agents need shared state

**Avoid when:**
- Tasks complete in a single turn
- Latency is critical (filesystem access adds overhead)

## Implementation Gotchas

1. **Unbounded scratch directory growth**: implement cleanup policies to avoid disk exhaustion in long-running agents.
2. **Race conditions in multi-agent file access**: use file locking or append-only semantics when multiple agents write to shared files concurrently.
3. **Stale file references after moves**: maintain a registry of active file paths and update it when files are moved or renamed.
4. **Grep-hostile formats**: format stored data for searchability — plain text or structured YAML/JSON over binary formats.
5. **Missing cleanup at session end**: implement session teardown that extracts important artifacts before the workspace is recycled.
