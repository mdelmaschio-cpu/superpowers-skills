---
name: Multi-Agent Architecture Patterns
description: Design multi-agent systems using supervisor, swarm, or hierarchical topologies — with context isolation as the primary benefit, not organizational metaphor.
when_to_use: when single-agent context limits constrain task complexity, tasks decompose naturally into parallel subtasks, different subtasks require different tool sets or system prompts, or building production agent systems with multiple specialized components
version: 2.1.0
languages: all
---

# Multi-Agent Architecture Patterns

Multi-agent architectures distribute work across multiple language model instances, each with its own context window. The critical insight is that **sub-agents exist primarily to isolate context, not to anthropomorphize role division**.

## When to Activate

Activate this skill when:
- Single-agent context limits constrain task complexity
- Tasks decompose naturally into parallel subtasks
- Different subtasks require different tool sets or system prompts
- Building systems that must handle multiple domains simultaneously
- Scaling agent capabilities beyond single-context limits

Do not activate this skill for adjacent work:
- Deciding task-model fit, pipeline shape, or project-level cost: `project-development`.
- Designing hosted sandboxes, warm pools, remote session infrastructure: `hosted-agents`.
- Sharing orchestrator state through KV-cache compaction: `latent-briefing`.
- Designing the tools each agent exposes: `tool-design`.

## Core Concepts

Use multi-agent patterns when a single agent's context window cannot hold all task-relevant information. Context isolation is the primary benefit — each agent operates in a clean context without accumulated noise from other subtasks, preventing the telephone game problem where information degrades through repeated summarization.

## Three Dominant Patterns

### Pattern 1: Supervisor/Orchestrator

A central agent maintains global state, decomposes user objectives into subtasks, and routes to specialists.

```
User Query -> Supervisor -> [Specialist, Specialist, Specialist] -> Aggregation -> Final Output
```

**Choose when**: tasks have clear decomposition, coordination across domains is needed, or human oversight is important.

**Trade-offs**: strict workflow control and easier human-in-the-loop, but the supervisor context becomes a bottleneck, and the "telephone game" problem emerges where supervisors paraphrase sub-agent responses incorrectly.

**Fix for telephone game**: implement a `forward_message` tool that allows sub-agents to pass responses directly to users, bypassing supervisor synthesis.

### Pattern 2: Peer-to-Peer/Swarm

Any agent transfers control to any other through explicit handoff mechanisms.

**Choose when**: tasks require flexible exploration, rigid planning is counterproductive, or requirements emerge dynamically.

**Trade-offs**: no single point of failure and effective breadth-first scaling, but coordination complexity increases with agent count.

### Pattern 3: Hierarchical

Strategy (goal definition) → Planning (task decomposition) → Execution (atomic tasks)

**Choose when**: projects have clear hierarchical structure with different levels of abstraction.

## Token Economics Reality

Budget for substantially higher token costs. Multi-agent systems typically cost far more tokens than single-agent chat:

| Architecture | Relative Token Cost |
|---|---|
| Single agent chat | Baseline |
| Single agent with tools | 2-5x |
| Multi-agent system | 10-20x |

Model quality improvements frequently outperform raw token increases — consider upgrading models before adding agents.

## Context Isolation Mechanisms

Select the right mechanism for each subtask:
- **Instruction passing** — sub-agent receives only what it needs (default, best isolation)
- **File system memory** — agents read and write to persistent storage (scales best, adds latency)
- **Full context delegation** — shares the planner's entire context (defeats isolation purpose; use sparingly)

## Consensus and Coordination

**Avoid simple majority voting** — it treats hallucinations from weak models as equal to reasoning from strong models.

Use instead:
- **Weighted voting** — weight votes by agent confidence or domain expertise
- **Debate protocols** — structure agents to critique each other's outputs; adversarial critique yields higher accuracy than collaborative consensus
- **Trigger-based intervention** — detect stall and sycophancy patterns and intervene

## Failure Modes and Mitigations

| Failure | Mitigation |
|---------|------------|
| Supervisor bottleneck | Keep workers ≤5 per supervisor; add second supervisor tier |
| Coordination overhead | Minimize communication; batch results; measure actual time savings |
| Divergence | Define clear objective boundaries; set time-to-live limits |
| Error propagation cascades | Validate outputs before passing to consumers; add verification agent |

## Gotchas

1. **Supervisor bottleneck scaling**: At 5+ workers, the supervisor spends more tokens processing summaries than workers spend on actual tasks. Hard cap at 3-5 workers per supervisor.
2. **Token cost underestimation**: Multi-agent runs consistently cost far more than teams estimate — account for coordination overhead, retries, and consensus rounds.
3. **Sycophantic consensus**: Agents in debate patterns converge on agreeable answers, not correct ones. Assign explicit adversarial roles.
4. **Agent sprawl**: Adding more agents past 3-5 shows diminishing returns and increases coordination overhead quadratically.
5. **Telephone game in message-passing**: Use filesystem coordination instead of message-passing for state that multiple agents need to access faithfully.
6. **Error propagation cascades**: One agent's hallucination becomes another agent's "fact." Add validation checkpoints between agents.
7. **Over-decomposition**: A 10-step pipeline with 10 agents spends more tokens on handoffs than on actual work.
8. **Missing shared state**: Establish shared persistent storage before building multi-agent workflows.
