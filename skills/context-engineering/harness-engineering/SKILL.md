---
name: Harness Engineering
description: Design the control system around an autonomous agent — locked and editable surfaces, durable logs, novelty gates, pruning, rollback, PR preparation, and human approval boundaries.
when_to_use: when building autonomous research or experimentation loops, designing agent environments with locked metrics and editable code, creating PR-producing or background agents, evaluating whether an agent can safely run without frequent human prompts, or preventing agents from gaming benchmarks or weakening rubrics
version: 1.1.0
languages: all
---

# Harness Engineering

Harness engineering designs the control system around an agent: what it may edit, how it receives feedback, where it writes state, how failures recover, and who can approve irreversible actions. The harness is the difference between a helpful agent session and an autonomous loop that can run for days without corrupting its objective.

## When to Activate

Activate this skill when:
- Building autonomous research or experimentation loops
- Designing an agent environment with locked metrics and editable code or content
- Creating PR-producing or background agents
- Evaluating whether an agent can safely run without frequent human prompts
- Adding novelty, ablation, pruning, rollback, or durable logging to an agent workflow
- Preventing agents from gaming benchmarks, weakening rubrics, or losing state across compaction

Do not activate this skill for adjacent work:
- General quality gates, regression suites, or outcome metrics: `evaluation`.
- Tool schemas, response formats, and recovery errors for harness tools: `tool-design`.
- Project-level task-model fit, pipeline shape, and cost planning: `project-development`.
- Remote sandbox, warm-pool, and hosted session infrastructure: `hosted-agents`.

## Harness Boundary

Separate the agent from the environment it operates inside. The agent proposes actions; the harness defines allowed surfaces, feedback, persistence, and promotion rules.

| Surface | Examples | Rule |
|---------|----------|------|
| Locked | Eval metric, rubric, validation script, merge policy | Agent may read and propose changes, but cannot score itself with modified rules |
| Editable | Skill draft, experiment file, prompt, config under test | Agent may mutate during the loop |
| Append-only | Results log, research thread, rejected ideas | Agent may append, not rewrite |
| Human-controlled | Merge, production deploy, credentials, destructive operations | Requires explicit human approval |

## Tight Feedback Loops

Autonomy works when feedback is fast, unambiguous, and hard to game. The minimal pattern: one editable file, one locked evaluation file, fixed wall-clock budget, one scalar metric, git rollback, and a durable results log.

For open-ended research-to-skill work, replace the scalar metric with locked rubrics, deterministic structure checks, source traceability, and human review thresholds.

## Durable State

Long-running agents must externalize state. Store plans, source queues, results, failures, and handoffs in files so future agents can resume without relying on chat history.

Use append-only logs for:
- What was tried
- What improved or failed
- Why a candidate was kept, discarded, or routed to review
- Which upstream sources were checked
- What the next agent should do

## Search Discipline

Agents tend to exploit the nearest surface, stack complexity, and under-run pruning. Add explicit search rules:

1. Refresh upstream sources on a schedule.
2. Require novelty checks before spending large budgets.
3. Preserve rejected attempts to avoid rediscovery.
4. Run leave-one-out pruning when a stack has multiple additions.
5. Reward simplification when quality is equal.
6. Use separate verification before promotion.

## The Autoresearch Loop Pattern

```text
read locked context -> choose hypothesis -> edit allowed surface -> commit/checkpoint
-> run evaluator -> log result -> keep if better -> discard or rollback if worse
-> repeat
```

Required properties:
- The evaluator is outside the editable surface.
- Failed attempts leave an audit trail.
- Rollback is cheap.
- The agent has a policy for crashes and timeouts.

## Harness Design Checklist

1. Define the objective in one sentence.
2. Identify locked, editable, append-only, and human-controlled surfaces.
3. Choose the feedback mechanism: scalar metric, rubric, deterministic tests, human review, or combination.
4. Define keep, discard, crash, timeout, and review states.
5. Create a durable thread log before the loop starts.
6. Add source refresh, mechanism-registry novelty, and pruning rules for long-running loops.
7. Define what the agent may do without asking and what requires approval.
8. Validate the harness on one known good and one known bad artifact.

## File Layout

```text
research-run/
  THREAD.md
  sources/
    queue.md
    evaluations/
  proposals/
  logs/
    results.tsv
    rejected.md
  drafts/
```

## Metric Gaming Resistance

Assume an optimizing agent will learn the harness. Guard against:
- Editing evaluation code or rubrics and then using the new version for self-approval
- Adding verbose content that pleases a judge but harms skill activation
- Citing unretrieved sources
- Optimizing aggregate scores while failing a critical dimension
- Avoiding failed results in the log

Mitigation: lock rubrics per run, report per-dimension scores, require source retrieval evidence, preserve rejected attempts, and route governance changes to human review.

## Gotchas

1. **Mutable evaluator**: if the agent can edit the metric, it may optimize the benchmark instead of the task. Keep rubrics and eval code locked during the run.
2. **Chat-only memory**: long runs fail after compaction when plans live only in conversation history. Write thread logs and result files from the start.
3. **No discard record**: without rejected-attempt logs, agents repeat failed ideas.
4. **Complexity accretion**: agents stack changes and rarely remove them. Require pruning rounds and reward equal-quality simplification.
5. **Premature novelty claims**: agents label recombinations as novel. Compare against existing repo skills, source queue, and rejected logs.
6. **Human approval ambiguity**: "prepare a PR" is not "merge a PR." Make approval boundaries explicit in the harness.
