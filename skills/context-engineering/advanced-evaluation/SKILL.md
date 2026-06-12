---
name: Advanced Agent Evaluation (LLM-as-Judge)
description: Build production-grade LLM-as-judge evaluation systems using direct scoring, pairwise comparison, systematic bias mitigation, and calibrated rubric generation.
when_to_use: when building LLM-as-judge evaluation systems, implementing pairwise comparison for subjective quality tasks, mitigating position/length/self-enhancement biases in automated evaluation, or scaling evaluation beyond what human review can cover
version: 1.0.0
languages: all
---

# Advanced Agent Evaluation (LLM-as-Judge)

LLM-as-judge systems enable scalable, nuanced evaluation of agent outputs beyond what deterministic checks can cover. The challenge is systematic bias: LLM judges exhibit position bias, length bias, and self-enhancement bias that inflate scores without reflecting real quality.

## When to Activate

Activate this skill when:
- Building LLM-as-judge evaluation for subjective quality dimensions
- Implementing pairwise comparison to measure relative quality
- Mitigating systematic biases in automated evaluation scores
- Generating calibrated rubrics with clear level definitions
- Scaling evaluation beyond human review capacity

Do not activate this skill for adjacent work:
- Deterministic checks, regression suites, and quality gates: `evaluation`.
- Harness engineering for autonomous agent loops: `harness-engineering`.

## Two Primary Methodologies

### Direct Scoring

Apply when objective criteria exist. A single LLM rates one response on a defined scale.

**Best for**: factual accuracy, instruction following, format compliance, citation quality.

**Calibration requirement**: provide anchor examples for each score level. Without anchors, judges use different scales for equivalent quality, making scores incomparable across runs.

### Pairwise Comparison

Apply when subjective judgment matters most. The judge compares two responses and picks the better one.

**Best for**: overall quality, helpfulness, tone, creativity, depth.

**Why it outperforms direct scoring for subjective tasks**: pairwise comparison correlates better with human preference because it mimics how humans actually compare options rather than applying arbitrary scales.

**Critical process**: single-pass pairwise evaluation is insufficient. Required steps:
1. Evaluate response pair (A, B) — record winner
2. Swap positions: evaluate pair (B, A) — record winner
3. Check consistency: if results disagree, apply majority vote or mark as "tie"
4. Report confidence tied to agreement rate

## Bias Mitigation Strategies

### Position Bias (most common)
First-position responses receive preferential treatment regardless of quality.

**Mitigation**: always evaluate twice with swapped positions, then apply majority vote or consistency check.

### Length Bias
Longer outputs score higher regardless of quality — judges conflate verbosity with thoroughness.

**Mitigation**: explicitly prompt to ignore length and apply length-normalized scoring. Add "do not penalize concise responses" to judge system prompts.

### Self-Enhancement Bias
Models rate their own outputs higher when used as evaluators.

**Mitigation**: use a different model for generation vs. evaluation. Never use the same model family.

### Sycophancy in Evaluation
Judges agree with stated "correct" answers rather than evaluating independently.

**Mitigation**: do not reveal the "expected" answer to the judge. Evaluate responses blindly.

## Evidence-Based Scoring

Require evidence before the score in scoring prompts — the judge must anchor its decision in observable output features before emitting a number.

**Prompt pattern**:
```
Step 1: Quote the specific passage that demonstrates [criterion].
Step 2: Explain why this passage meets or fails the criterion.
Step 3: Assign a score from 1-5.
```

This prevents judges from rationalizing scores post-hoc rather than grounding them in evidence.

## Rubric Generation

Generate rubrics with:
1. Clear dimension definitions (what you're measuring)
2. Anchored level descriptions (concrete examples of 1/2/3/4/5)
3. Distinguishing criteria between adjacent levels
4. Edge case guidance for common ambiguous inputs

## Scaling Strategies

- **Batch evaluation**: group similar evaluations to improve judge consistency
- **Cascaded evaluation**: use fast cheap judges for initial filtering, expensive judges for borderline cases
- **Spot-check human review**: regularly compare judge decisions to human decisions to detect judge drift

## Gotchas

1. **Single-pass pairwise is unreliable**: always evaluate both orderings and check for consistency.
2. **Rubric drift over time**: rubrics become outdated as agent capabilities improve — schedule quarterly rubric reviews.
3. **Judge model updates break calibration**: when the judge model is updated, re-calibrate scores against the held-out human evaluation set.
4. **Confidence without calibration**: high judge confidence does not mean high accuracy — validate judge confidence against actual agreement rates.
