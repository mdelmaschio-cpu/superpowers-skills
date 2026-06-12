---
name: LLM Project Development
description: Make project-level architectural decisions for LLM systems — evaluating whether LLMs suit a task, designing multi-stage batch or agent pipelines, and estimating token costs.
when_to_use: when evaluating whether an LLM is the right primitive for a specific task, designing multi-stage batch or agent pipelines, estimating token costs before building, or deciding whether to use a single LLM call vs a pipeline of deterministic and LLM stages
version: 1.0.0
languages: all
---

# LLM Project Development

This skill addresses project-level architectural decisions for LLM systems — the complete project scope rather than individual components. It covers whether a language model is the right primitive for the task at hand, the shape of a multi-stage batch or agent pipeline, and token and cost estimation.

## When to Activate

Activate this skill when:
- Evaluating whether an LLM is the right primitive for a given task
- Designing multi-stage batch or agent pipelines
- Estimating tokens and costs before building
- Deciding pipeline architecture (single LLM call vs multi-stage vs agent loop)
- Choosing between LLM processing vs deterministic alternatives

Do not activate this skill for adjacent work:
- Individual tool schemas, response formats: `tool-design`.
- Per-trajectory token-efficiency tactics: `context-optimization`.
- Agent topology decisions (supervisor vs swarm): `multi-agent-patterns`.
- Autonomous control loop engineering: `harness-engineering`.

## Task Fit Evaluation

**Tasks suited to LLM processing:**
- Synthesis across heterogeneous sources
- Subjective judgment with rubrics
- Natural language output from structured data
- Extraction from unstructured text
- Classification with fuzzy categories

**Tasks that should NOT use LLMs:**
- Precise computation (arithmetic, sorting, aggregation)
- Real-time requirements (<50ms response)
- Perfect accuracy needs (financial calculations, legal citations)
- Well-defined rule-based logic with enumerable cases

## Validation Methodology

Test one representative example with the target model before automating at scale. This manual prototyping validates feasibility and reveals constraints before infrastructure investment. Do not build pipelines around untested assumptions.

Key questions for the prototype:
1. Does the model produce the right output format consistently?
2. What prompt structure minimizes failures?
3. What is the actual token count vs estimate?
4. What error modes appear, and are they recoverable?

## Pipeline Architecture

Separate deterministic stages from expensive, non-deterministic LLM processing:

**Acquire → Prepare → Process → Parse → Render**

- **Acquire**: fetch raw data from sources
- **Prepare**: clean, normalize, chunk — deterministic
- **Process**: LLM calls — expensive, non-deterministic
- **Parse**: extract structured output from LLM responses — semi-deterministic
- **Render**: format for delivery — deterministic

This separation enables selective re-execution (re-run only Process when prompts change) and cost control (skip re-processing unchanged inputs).

**Use the file system as a state machine**: write intermediate outputs to disk at each stage boundary. This enables human-readable debugging, recovery from failures, and incremental re-processing.

## Cost Estimation

Before building, estimate:
1. Expected token count per document (input + output)
2. Number of documents to process
3. Model pricing per 1M tokens
4. Total estimated cost = (tokens/doc × docs × price/token)

Build in a 2-3x safety margin — actual token counts typically exceed estimates due to prompt overhead and error recovery.

## Gotchas

1. **Unvalidated assumptions**: building multi-stage pipelines around unproven LLM capabilities. Always prototype one example end-to-end before automating.
2. **Missing deterministic fallbacks**: agent loops without fallback logic for LLM failures. Design error recovery at each stage.
3. **Ignoring output variability**: LLMs produce different outputs on identical inputs. Design downstream stages to handle format variations.
4. **Cost underestimation**: actual token costs are typically 2-3x higher than initial estimates due to retries, error handling, and prompt overhead.
5. **Mixing LLM and deterministic logic**: interleaving LLM calls with business logic in the same function makes both harder to test and optimize separately.
