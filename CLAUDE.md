# Superpowers Skills

This repository is a library of Claude Code skills — proven techniques and process guides. Skills are located in `skills/` organized by category.

**Skills root:** `SUPERPOWERS_SKILLS_ROOT=/home/user/superpowers-skills`

---

## Mandatory Workflow: Before ANY Task

1. **Check the skills index below** for relevant skills.
2. **If a relevant skill exists, you MUST use it:**
   - Use Read tool with full path: `${SUPERPOWERS_SKILLS_ROOT}/skills/category/skill-name/SKILL.md`
   - Read the ENTIRE file, not just the frontmatter
   - Announce: "I've read the [Skill Name] skill and I'm using it to [purpose]"
   - Follow it exactly
3. **If the skill has a checklist**, create TodoWrite todos for EVERY item.

> Read `skills/using-skills/SKILL.md` for the full workflow.

---

## Skills Index

### Using Skills (start here)
| Skill | When to Use | Path |
|-------|-------------|------|
| Getting Started with Skills | when starting any conversation | `skills/using-skills/SKILL.md` |

### Architecture
| Skill | When to Use | Path |
|-------|-------------|------|
| Preserving Productive Tensions | when oscillating between equally valid approaches that optimize for different legitimate priorities | `skills/architecture/preserving-productive-tensions/SKILL.md` |

### Collaboration
| Skill | When to Use | Path |
|-------|-------------|------|
| Brainstorming Ideas Into Designs | when partner describes any feature or project idea, before writing code or implementation plans | `skills/collaboration/brainstorming/SKILL.md` |
| Dispatching Parallel Agents | when facing 3+ independent failures that can be investigated without shared state or dependencies | `skills/collaboration/dispatching-parallel-agents/SKILL.md` |
| Executing Plans | when partner provides a complete implementation plan to execute in controlled batches with review checkpoints | `skills/collaboration/executing-plans/SKILL.md` |
| Finishing a Development Branch | when implementation is complete, all tests pass, and you need to decide how to integrate the work | `skills/collaboration/finishing-a-development-branch/SKILL.md` |
| Code Review Reception | when receiving code review feedback, before implementing suggestions | `skills/collaboration/receiving-code-review/SKILL.md` |
| Remembering Conversations | when partner mentions past discussions, debugging familiar issues, or seeking historical context | `skills/collaboration/remembering-conversations/SKILL.md` |
| Requesting Code Review | when completing tasks, implementing major features, or before merging | `skills/collaboration/requesting-code-review/SKILL.md` |
| Subagent-Driven Development | when executing implementation plans with independent tasks in the current session | `skills/collaboration/subagent-driven-development/SKILL.md` |
| Using Git Worktrees | when starting feature work that needs isolation from current workspace | `skills/collaboration/using-git-worktrees/SKILL.md` |
| Writing Plans | when design is complete and you need detailed implementation tasks | `skills/collaboration/writing-plans/SKILL.md` |

### Debugging
| Skill | When to Use | Path |
|-------|-------------|------|
| Systematic Debugging | when encountering any bug, test failure, or unexpected behavior, before proposing fixes | `skills/debugging/systematic-debugging/SKILL.md` |
| Root Cause Tracing | when errors occur deep in execution and you need to trace back to find the original trigger | `skills/debugging/root-cause-tracing/SKILL.md` |
| Verification Before Completion | when about to claim work is complete, fixed, or passing, before committing or creating PRs | `skills/debugging/verification-before-completion/SKILL.md` |
| Defense-in-Depth Validation | when invalid data causes failures deep in execution, requiring validation at multiple system layers | `skills/debugging/defense-in-depth/SKILL.md` |

### Testing
| Skill | When to Use | Path |
|-------|-------------|------|
| Test-Driven Development (TDD) | when implementing any feature or bugfix, before writing implementation code | `skills/testing/test-driven-development/SKILL.md` |
| Testing Anti-Patterns | when writing or changing tests, adding mocks, or tempted to add test-only methods to production code | `skills/testing/testing-anti-patterns/SKILL.md` |
| Condition-Based Waiting | when tests have race conditions, timing dependencies, or inconsistent pass/fail behavior | `skills/testing/condition-based-waiting/SKILL.md` |

### Problem-Solving
| Skill | When to Use | Path |
|-------|-------------|------|
| When Stuck - Problem-Solving Dispatch | when stuck and unsure which problem-solving technique to apply | `skills/problem-solving/when-stuck/SKILL.md` |
| Simplification Cascades | when implementing the same concept multiple ways, accumulating special cases, or complexity is spiraling | `skills/problem-solving/simplification-cascades/SKILL.md` |
| Collision-Zone Thinking | when conventional approaches feel inadequate and you need breakthrough innovation | `skills/problem-solving/collision-zone-thinking/SKILL.md` |
| Meta-Pattern Recognition | when noticing the same pattern across 3+ different domains | `skills/problem-solving/meta-pattern-recognition/SKILL.md` |
| Scale Game | when uncertain about scalability, edge cases unclear, or validating architecture | `skills/problem-solving/scale-game/SKILL.md` |
| Inversion Exercise | when stuck on unquestioned assumptions or feeling forced into "the only way" | `skills/problem-solving/inversion-exercise/SKILL.md` |

### Research
| Skill | When to Use | Path |
|-------|-------------|------|
| Tracing Knowledge Lineages | when questioning "why do we use X", before abandoning approaches, or evaluating "new" ideas | `skills/research/tracing-knowledge-lineages/SKILL.md` |

### Meta
| Skill | When to Use | Path |
|-------|-------------|------|
| Writing Skills | when creating new skills, editing existing skills, or verifying skills work before deployment | `skills/meta/writing-skills/SKILL.md` |
| Testing Skills With Subagents | when creating or editing skills, before deployment | `skills/meta/testing-skills-with-subagents/SKILL.md` |
| Sharing Skills | when you've developed a broadly useful skill and want to contribute it upstream | `skills/meta/sharing-skills/SKILL.md` |
| Gardening Skills Wiki | when adding, removing, or reorganizing skills, or periodically to maintain wiki health | `skills/meta/gardening-skills-wiki/SKILL.md` |
| Pulling Updates from Skills Repository | when updating to latest skill versions from upstream | `skills/meta/pulling-updates-from-skills-repository/SKILL.md` |

---

## Iron Laws

- **NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST** (TDD)
- **NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST** (Systematic Debugging)
- **NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE** (Verification Before Completion)
- **NO SKILL WITHOUT FAILING TEST FIRST** (Writing Skills)
