---
name: Agent Evaluation Methods
description: Build agent evaluation systems with deterministic checks, regression suites, multi-dimensional rubrics, quality gates, and production monitoring for agent pipelines.
when_to_use: when building agent evaluation frameworks, designing regression suites to catch performance regressions, creating quality gates for agent pipelines, setting up production monitoring, or choosing between deterministic checks vs LLM-as-judge evaluation
version: 1.0.0
languages: all
---

# Evaluation Methods for Agent Systems

Agent evaluation requires fundamentally different approaches than traditional software testing. Agents make dynamic decisions, are non-deterministic between runs, and often lack single correct answers.

## When to Activate

Activate this skill when:
- Building agent evaluation systems from scratch
- Designing deterministic checks and regression suites
- Creating multi-dimensional rubrics for subjective quality
- Setting up quality gates for agent pipelines
- Establishing production monitoring for agent performance
- Choosing between evaluation methodologies

Do not activate this skill for adjacent work:
- LLM-as-judge systems with pairwise comparison and bias mitigation: `advanced-evaluation`.
- Harness engineering for autonomous agent control loops: `harness-engineering`.
- Token cost and latency optimization: `context-optimization`.

## Core Principle: Outcome-Focused Assessment

Rather than checking whether agents follow specific procedural steps, evaluations should measure whether agents **achieve the right outcome via a reasonable process**.

## Multi-Dimensional Scoring

Single metrics obscure failures. Track separate dimensions including:
- Factual accuracy
- Completeness
- Citation accuracy
- Source quality
- Tool efficiency

## Evaluation Methodology

**Deterministic checks** (always apply first):
- Schema validation on structured outputs
- Regex/pattern matching for known-format fields
- Exact-match tests for factual questions with known answers
- Performance thresholds (latency, token count)

**Rubric-based LLM evaluation** (for subjective quality):
- Define quality dimensions before implementation
- Create descriptive rubrics with clear level definitions (1-5 scale with anchored examples)
- Build test sets stratified by complexity (simple → medium → complex → very complex)
- Require evidence before the score: judge must anchor its decision in observable output features before emitting a number

## Building the Test Set

1. Stratify by complexity — include simple, medium, complex, and very complex examples
2. Cover failure modes explicitly — include edge cases and known degradation scenarios
3. Include adversarial examples — test robustness to misleading context
4. Avoid contamination — do not train on the same examples used for evaluation

## Performance Drivers

Research indicates token usage is the primary driver of measured performance variance, with tool calls and model selection as secondary factors. Account for these when comparing evaluation runs across different configurations.

## Production Monitoring

Supplement automated evaluation with:
- Sampling-based human review (5-10% of production traffic)
- User feedback signals (thumbs up/down, corrections)
- Regression triggers on key metrics
- Canary testing before full deployment

## Evaluation Pitfalls

1. **Metric gaming**: optimizing scores rather than actual quality — add dimensions that are hard to game simultaneously.
2. **Test set contamination**: using examples the agent has seen during development — maintain held-out evaluation sets.
3. **Single-run evaluation**: agent non-determinism means single-run scores are noisy — average over multiple runs.
4. **Treating evaluation as a one-time gate**: evaluation is ongoing monitoring, not a pre-launch checkbox.
5. **Ignoring failure modes**: test sets skewed toward success cases miss real production degradation.
6. **Proxy metrics as goals**: when a proxy metric becomes the target, it ceases to be a good proxy (Goodhart's Law).
7. **Missing baselines**: always establish a baseline before changes — without it, you cannot tell if an optimization helped.
8. **LLM judge self-enhancement bias**: models rate their own outputs higher — use different models for generation vs. evaluation.
