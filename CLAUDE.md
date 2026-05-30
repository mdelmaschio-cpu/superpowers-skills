# CLAUDE.md — superpowers-skills

Community-editable skills library for the Claude Code **superpowers** plugin. Skills teach proven problem-solving techniques to AI assistants working in Claude Code sessions.

## What This Repo Is

The superpowers plugin clones this repository to `~/.config/superpowers/skills/` and makes skills available to Claude Code sessions. When a session starts, Claude reads `skills/using-skills/SKILL.md` to learn how to discover and use all other skills. Skills are markdown reference guides—not scripts—that describe techniques for Claude to apply.

## Repository Structure

```
superpowers-skills/
├── README.md
├── .gitignore
├── LICENSE
└── skills/
    ├── REQUESTS.md                    # Wish list for skills not yet created
    ├── using-skills/                  # Entry point: how to use the wiki
    │   ├── SKILL.md                   # Loaded at session start—mandatory workflows
    │   ├── find-skills                # Shell script: search skills by keyword
    │   └── skill-run                  # Shell script: run a skill directly
    ├── architecture/                  # Design decision skills
    ├── collaboration/                 # Human-AI teamwork skills
    ├── debugging/                     # Bug diagnosis skills
    ├── meta/                          # Skills for writing and maintaining skills
    ├── problem-solving/               # Creative reasoning techniques
    ├── research/                      # Knowledge investigation skills
    └── testing/                       # Test quality and TDD skills
```

Each skill lives in its own directory:

```
skills/<category>/<skill-name>/
├── SKILL.md          # Required — main reference document
├── *.md              # Optional — heavy reference material (100+ lines)
├── *.sh / *.py       # Optional — reusable scripts or tools
└── test-*.md         # Optional — subagent test scenarios
```

## Skills Inventory

### architecture
| Skill | When to Use |
|---|---|
| `preserving-productive-tensions` | when oscillating between equally valid approaches that optimize for different legitimate priorities |

### collaboration
| Skill | When to Use |
|---|---|
| `brainstorming` | when partner describes any feature or project idea, before writing code or implementation plans |
| `dispatching-parallel-agents` | when facing 3+ independent failures that can be investigated without shared state |
| `executing-plans` | when partner provides a complete implementation plan to execute in controlled batches |
| `finishing-a-development-branch` | when implementation is complete and you need to decide how to integrate the work |
| `receiving-code-review` | when receiving code review feedback before implementing suggestions |
| `remembering-conversations` | when partner mentions past discussions or seeking historical context about decisions |
| `requesting-code-review` | when completing tasks or before merging, to verify work meets requirements |
| `subagent-driven-development` | when executing implementation plans with independent tasks using fresh subagents |
| `using-git-worktrees` | when starting feature work that needs isolation from current workspace |
| `writing-plans` | when design is complete and you need detailed implementation tasks |

### debugging
| Skill | When to Use |
|---|---|
| `defense-in-depth` | when invalid data causes failures deep in execution |
| `root-cause-tracing` | when errors occur deep in execution and you need to trace back to find the original trigger |
| `systematic-debugging` | when encountering any bug, test failure, or unexpected behavior, before proposing fixes |
| `verification-before-completion` | when about to claim work is complete, before committing or creating PRs |

### meta (skills for writing skills)
| Skill | When to Use |
|---|---|
| `gardening-skills-wiki` | when adding, removing, or reorganizing skills, or to maintain wiki health |
| `pulling-updates-from-skills-repository` | when syncing local skills with upstream changes |
| `sharing-skills` | when you've developed a broadly useful skill and want to contribute it upstream |
| `testing-skills-with-subagents` | when creating or editing skills, before deployment |
| `writing-skills` | when creating new skills, editing existing skills |

### problem-solving
| Skill | When to Use |
|---|---|
| `collision-zone-thinking` | when conventional approaches feel inadequate, forcing unrelated concepts together |
| `inversion-exercise` | when stuck on unquestioned assumptions or feeling forced into "the only way" |
| `meta-pattern-recognition` | when noticing the same pattern across 3+ different domains |
| `scale-game` | when uncertain about scalability or validating architecture for production volumes |
| `simplification-cascades` | when implementing the same concept multiple ways or complexity is spiraling |
| `when-stuck` | when stuck and unsure which problem-solving technique to apply |

### research
| Skill | When to Use |
|---|---|
| `tracing-knowledge-lineages` | when questioning "why do we use X", before abandoning approaches |

### testing
| Skill | When to Use |
|---|---|
| `condition-based-waiting` | when tests have race conditions, timing dependencies, or inconsistent pass/fail behavior |
| `test-driven-development` | when implementing any feature or bugfix, before writing implementation code |
| `testing-anti-patterns` | when writing or changing tests, adding mocks, or tempted to add test-only methods |

## SKILL.md Format

Every skill MUST have this structure:

```markdown
---
name: Human-Readable Name
description: One-line summary of what this does
when_to_use: when [concrete trigger/symptom — start with "when"]
version: 5.1.0
languages: all | [typescript, python] | etc
---

# Skill Name

## Overview
Core principle in 1-2 sentences.

## When to Use
Bullet list with symptoms and use cases. When NOT to use.

## Quick Reference
Scannable table or bullets.

## Implementation
Inline code for simple patterns. Link to file for heavy reference.

## Common Mistakes
What goes wrong and how to fix it.
```

### Frontmatter Rules

- `name` — human-readable, title case
- `description` — one line, what the skill does (not when)
- `when_to_use` — MUST start with "when"; describe the *problem symptom*, not the language keyword; technology-agnostic unless the skill itself is technology-specific
- `version` — increment on every edit
- `languages` — `all` if language-agnostic

### Naming Conventions

- Directories: `kebab-case`, verb-first, active voice
- Good: `condition-based-waiting`, `root-cause-tracing`, `using-git-worktrees`
- Bad: `async-helpers`, `debugging-techniques`, `git-worktree-usage`
- Gerunds work well for processes: `creating-skills`, `dispatching-parallel-agents`

## Development Workflow

### Creating a New Skill

Skills use **TDD applied to process documentation**. Follow RED-GREEN-REFACTOR:

1. **RED — Establish baseline**: Run a subagent on the problem *without* the skill. Document what it gets wrong and which rationalizations it uses. You must watch the failure before writing.
2. **GREEN — Write minimal skill**: Write `SKILL.md` that addresses the specific failures observed. Run the scenario again with the skill. Agent should now comply.
3. **REFACTOR — Close loopholes**: Agent found a new rationalization? Add an explicit counter. Re-test until bulletproof.

**Iron Law: No skill without a failing test first. No exceptions.**

### Editing an Existing Skill

Same TDD cycle applies. Edit without testing = violation. Increment `version` in frontmatter on every edit.

### Token Efficiency

- `using-skills/SKILL.md` loads into every conversation — keep it under 150 words per workflow section
- Other frequently-loaded skills: under 200 words total
- Move long API references or heavy content to separate files; reference them from SKILL.md
- Don't repeat content covered in cross-referenced skills

### Supporting Files

Add supporting files only when:
- **Heavy reference** (100+ lines of API docs, syntax): break out to `reference.md`
- **Reusable tool**: scripts, templates — keep them in the skill directory
- **Test scenarios**: `test-academic.md`, `test-pressure-1.md`, etc.

Flowcharts (Graphviz `.dot`) only for non-obvious decisions. See `skills/meta/writing-skills/graphviz-conventions.dot` for style conventions.

### CSO — Claude Search Optimization

Skills must be discoverable by future Claude instances:

- Use rich `when_to_use` with concrete symptom words (`race condition`, `flaky`, `zombie`, `ENOTEMPTY`)
- Repeat key concepts in description, when_to_use, overview, and section headers
- Cross-reference other skills using path format without `@` prefix: `skills/testing/test-driven-development`
- Never use `@link` in cross-references — it force-loads the file and burns context

### Git Workflow

- Development branch: `claude/claude-md-docs-nI6a7`
- Push to that branch, then open a PR to `main`
- Upstream for updates: `obra/superpowers-skills` (pull via `skills/meta/pulling-updates-from-skills-repository`)
- To contribute a skill upstream: see `skills/meta/sharing-skills`

## Key Conventions for AI Assistants

1. **Read skills before using them.** The session-start hook loads `using-skills/SKILL.md` only. Read the actual skill with the Read tool using the full path before acting.
2. **Announce skill usage.** After reading: "I've read the [Skill Name] skill and I'm using it to [purpose]."
3. **Create TodoWrite entries for every checklist item** in skills that have checklists. Mental tracking fails.
4. **Never skip the brainstorming skill** (`skills/collaboration/brainstorming/SKILL.md`) for feature or design work.
5. **Never skip TDD** (`skills/testing/test-driven-development/SKILL.md`) for implementation work — specific instructions describe WHAT, not permission to skip process.
6. **`skills/REQUESTS.md`** is where skill ideas are tracked before creation.

## Contributing

Fork the repo, develop on a feature branch, and submit a PR. See `skills/meta/sharing-skills/SKILL.md` for the full sharing workflow.
