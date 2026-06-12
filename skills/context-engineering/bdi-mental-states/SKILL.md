---
name: BDI Mental States for Agents
description: Model agent cognition using Belief-Desire-Intention (BDI) architecture combined with RDF semantic representation for explainable, reasoning-capable agents with formal mental states.
when_to_use: when designing agents that need explainable reasoning with auditable mental state transitions, implementing BDI cognitive architecture with semantic linked data, creating agents that consume and produce RDF triples with formal mental states, or building systems that require temporal validity and justification for every belief
version: 1.0.0
languages: all
---

# BDI Mental States for Agents

This skill provides a framework for modeling agent cognition using Belief-Desire-Intention (BDI) architecture combined with RDF semantic representation. The T2B2T (Triples-to-Beliefs-to-Triples) paradigm creates a closed loop where agents consume RDF input, execute BDI deliberation, then project results back as linked data for downstream systems.

## When to Activate

Activate this skill when:
- Designing agents that need explainable reasoning with auditable mental state transitions
- Implementing BDI cognitive architecture with semantic linked data
- Creating agents that consume and produce RDF triples with formal mental states
- Building systems that require temporal validity and justification for every belief
- Needing compositional belief modeling (selective updates without full replacement)

Do not activate this skill for adjacent work:
- Persistent memory without BDI semantics: `memory-systems`.
- Agent topology decisions (supervisor vs swarm): `multi-agent-patterns`.
- Context window and attention mechanics: `context-fundamentals`.

## BDI Architecture Overview

**Three mental state types:**
- **Beliefs**: what the agent knows or assumes to be true about the world
- **Desires**: goals the agent wants to achieve
- **Intentions**: committed plans the agent is currently pursuing

**Endurants vs Perdurants:**
- **Endurants** (persistent states): beliefs, desires, intentions — exist at a point in time
- **Perdurants** (temporal processes): events that create or modify mental states — this separation is essential because BDI reasoning requires distinguishing what persists from what happens

## The T2B2T Paradigm

```
RDF Input (Triples) → Belief Formation → Desire Derivation → Intention Commitment → RDF Output (Triples)
```

This closed loop enables:
- Downstream systems to consume agent reasoning as structured linked data
- Auditing of every mental state transition
- Integration with semantic knowledge bases

## Six-Pass Workflow

1. **Define world states**: enumerate relevant entities and relationships in the domain
2. **Create beliefs**: map observed facts to formal belief structures with temporal bounds
3. **Derive desires**: identify goals that emerge from current beliefs
4. **Commit intentions**: select the highest-priority achievable desires as current intentions
5. **Project results**: express intention outcomes as RDF triples for downstream consumption
6. **Validate using competency questions**: test whether the model can answer questions it should be able to answer

## Temporal Validity

Every mental entity requires:
- **Valid from/to**: when the belief was acquired and when it expires
- **Justification**: the evidence or source that supports the belief
- **Confidence level**: certainty of the belief

This enables auditing, conflict resolution, and belief expiry policies.

## Scalability Guidance

- Start with 5-10 core ontology classes rather than over-engineering
- Keep belief chains to three levels or fewer to prevent reasoning cost explosion
- Use `hasPart` relations for compositional modeling — allows selective belief updates without full replacement
- Implement competency questions as regression tests for the knowledge model

## Critical Distinctions from Adjacent Skills

| Concern | This Skill | Adjacent Skill |
|---------|-----------|---------------|
| Cognitive architecture semantics | BDI mental states | — |
| Persistence without BDI semantics | — | `memory-systems` |
| Agent topology | — | `multi-agent-patterns` |

## Gotchas

1. **Belief without justification**: beliefs without justification are unauditable and conflict-prone — require source provenance for every belief created.
2. **Missing temporal bounds**: beliefs without validity windows accumulate indefinitely and corrupt reasoning with stale information.
3. **Over-deep belief chains**: chains deeper than 3 levels make reasoning cost explode — flatten or partition.
4. **Conflating desires with intentions**: desires are possible goals; intentions are committed plans. Conflating them removes the deliberation step that selects between competing desires.
5. **Ignoring perdurant-endurant distinction**: treating events the same as states makes temporal reasoning incorrect — model events as processes that create or modify states, not as states themselves.
