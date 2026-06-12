---
name: Latent Briefing and KV Cache Memory Sharing
description: Share memory between orchestrator and worker agents at the representation level via KV cache compaction (Attention Matching) — eliminating token explosion in hierarchical agent systems without text summarization.
when_to_use: when designing orchestrator-worker systems where workers need access to prior orchestrator state efficiently, evaluating alternatives to LLM summarization for cross-agent state transfer, implementing KV cache compaction as an inference primitive, or debugging token explosion in recursive hierarchical agent graphs
version: 1.2.0
languages: all
---

# Latent Briefing and KV Cache Memory Sharing

Hierarchical multi-agent systems often pay for the same context twice. The orchestrator accumulates a long reasoning trajectory, but each worker usually receives only a narrow text handoff. Passing the full trajectory fixes coverage but drives token cost up on every worker call. Summarization introduces latency and information loss.

Latent Briefing addresses this by sharing memory at the **representation level** rather than the text level. The core idea is to compact the orchestrator trajectory in the worker model's KV cache, keeping positions most relevant to the current worker task. The method builds on **Attention Matching (AM)** KV cache compaction.

## When to Activate

Activate this skill when:
- Designing orchestrator-worker or supervisor-specialist systems where workers need access to prior orchestrator state without replaying the full trajectory as text
- Evaluating alternatives to LLM summarization or RAG for cross-agent state transfer
- Implementing KV cache compaction as a first-class inference primitive
- Debugging token explosion in recursive, hierarchical, or tool-heavy agent graphs

Do not activate this skill for adjacent work:
- API-only stacks where internal KV tensors are inaccessible: use `context-compression`, `memory-systems`, or `multi-agent-patterns`.
- Ordinary persistent memory, entity tracking, or graph retrieval: `memory-systems`.
- General multi-agent topology without representation-level state sharing: `multi-agent-patterns`.
- Prefix caching, masking, or budget policy without KV state transformation: `context-optimization`.

## Why Text-Only Mitigations Fall Short

| Approach | Primary Weakness |
|----------|-----------------|
| LLM summarization | High latency, lossy abstraction, no guarantee summary preserves what the next subtask needs |
| Retrieval / RAG | Depends on chunking and embeddings; can miss cross-chunk or cross-step dependencies |
| Pass full trajectory | Cost scales with every worker call; irrelevant context can degrade worker quality |

## The Attention Matching Engine

Latent Briefing adapts AM for multi-agent inference:

1. Use **task-guided query vectors** derived from the current worker prompt (not generic samples).
2. Aggregate scores into a **shared global mask** instead of per-head independent subsets.
3. Use a robust threshold such as `median + tau * MAD` rather than fixed top-k per head.

**Infrastructure precondition**: Latent Briefing is only practical when the system controls the worker inference runtime closely enough to inspect or transform KV state. It is a poor default for API-only stacks.

## Decision Framework

| Need | Prefer | Why |
|------|--------|-----|
| Stable repeated prefix with minimal logic changes | Prefix caching | Cheapest optimization; no information loss |
| Human-readable and auditable cross-step state | Structured notes or summarization | Easy to inspect and store |
| Sparse lookup across a large external corpus | Retrieval / RAG | Finds documents efficiently |
| Worker needs task-specific slices of orchestrator state and runtime access exists | Latent Briefing | Transfers relevant latent state without replaying all text |

## Example Scenario

```
Call 1: trajectory T1 -> worker answers subquestion A
Call 2: trajectory T2 = T1 + new reasoning + reply A
        compact KV(T2) using the task prompt for B
        worker answers subquestion B
```

The task prompt for B decides which parts of T2 survive into the compacted worker state.

## Practical Guidance

- **Define the shared memory boundary first**: decide exactly what enters the trajectory cache before designing compaction.
- **Tune on validation data**: track task accuracy, worker tokens, total tokens, retention rate, and compaction overhead together.
- **Measure end-to-end latency**: compaction only pays off if compaction + generation beats the best text-layer alternative for the same quality target.
- **Use strong baselines**: compare against prefix caching, structured notes, retrieval, and selective text handoff.

## Gotchas

1. **Infrastructure access is the first gate**: if the runtime cannot inspect and rewrite worker KV state, Latent Briefing is a research idea, not a deployable technique.
2. **Shared model space matters**: KV compaction is defined in a specific model's attention space. Do not assume latent handoff works cleanly across unrelated model families.
3. **Threshold is workload-dependent**: one global `tau` rarely works across long vs short context and easy vs hard tasks.
4. **Benchmark scope is narrow**: public results focus on long-document QA. Code generation, math, and multi-document synthesis may behave differently.
5. **Weak baselines inflate the apparent win**: compare against strong text-level alternatives before claiming a system-level advantage.
