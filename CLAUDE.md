# superpowers-skills

Community-editable skills library for Claude Code's superpowers plugin. Automatically cloned to `~/.config/superpowers/skills/` by the superpowers plugin.

## Repository Purpose

A shared, community-maintained library of Claude Code skills organized by functional category. Users fork the repo, add new skills or improve existing ones, and contribute back via PRs. Skills are markdown files that give Claude structured guidance for specific task types.

## Structure

```
superpowers-skills/
├── README.md
├── CLAUDE.md
├── LICENSE                    # MIT, Copyright 2025 Jesse Vincent
└── skills/
    ├── REQUESTS.md            # Wishlist: skills to create next
    ├── architecture/          # Architecture & system design skills
    │   ├── ABOUT.md           # Attribution for derived skills
    │   └── preserving-productive-tensions/
    ├── collaboration/         # Team collaboration & git workflow skills (10 skills)
    │   └── remembering-conversations/  # Node.js semantic search tool
    │       ├── SKILL.md
    │       ├── package.json
    │       ├── src/
    │       └── tests/
    ├── debugging/             # Debugging & troubleshooting skills (4 skills)
    ├── meta/                  # Skills about using/managing skills (5 skills)
    ├── problem-solving/       # Reasoning & decision-making strategies (6 skills)
    ├── research/              # Investigation & knowledge synthesis (1 skill)
    ├── testing/               # Test strategies & anti-patterns (3 skills)
    └── using-skills/          # How to use Claude Code skills effectively (1 skill)
```

## How Skills Work

Each skill lives in its own directory inside a category folder. The directory name is the skill identifier. Every skill requires a `SKILL.md` file, and optionally an `ABOUT.md` for attribution.

**SKILL.md format:**
```yaml
---
name: skill-name-in-kebab-case
description: Trigger-phrase-rich description for model invocation. Include the
  exact situations, symptoms, and phrases that should invoke this skill.
version: X.Y.Z
languages: all | [typescript, python, etc]
---

# Skill Title

## Overview
Core principle in 1-2 sentences.

## [Custom Sections]
Instructions, patterns, examples, red flags, rationalizations to avoid
```

The `description` field is critical: the model selects skills based on how well the description matches the user's request. Generic descriptions lead to the skill being skipped. Write it as if someone is searching for help with that exact problem.

## Skill Categories

| Category | Purpose |
|----------|---------|
| `architecture/` | System design, structural patterns, trade-off analysis |
| `collaboration/` | Team workflows, git branching, communication, handoff patterns |
| `debugging/` | Diagnosing failures, root cause analysis, error patterns |
| `meta/` | Skills about working with Claude Code skills themselves |
| `problem-solving/` | General reasoning, ideation, and decision-making strategies |
| `research/` | Investigation, information synthesis, knowledge lineage |
| `testing/` | Test strategies, TDD, flaky tests, anti-patterns |
| `using-skills/` | How to write, install, and invoke Claude Code skills |

## TDD-Based Skill Development

Skills are developed using a test-first approach — the **Iron Law: no skill without a failing test first**.

1. **RED**: Run a baseline test — confirm the unguided model exhibits the target failure behavior.
2. **GREEN**: Write minimal skill content that fixes the specific failure.
3. **REFACTOR**: Close loopholes and explicitly pre-empt rationalizations.

Test skills using subagents with pressure scenarios:
- Time pressure ("we're already late"), sunk cost ("we've invested too much"), authority pressure ("the boss wants this now"), exhaustion ("we've tried everything")
- A skill that fails under pressure is not ready for production.

## Writing Skills: Claude Search Optimization (CSO)

The model discovers skills by matching the `description` and `when_to_use` fields against the user's request. Optimize for discoverability:

- **Active verb-first naming**: `creating-skills` not `skill-creation`
- **Rich trigger phrases**: Include concrete error messages, symptoms, and user phrases in the description
- **Symptom-mapped `when_to_use`**: Map each line to a specific trigger ("when you feel stuck and can't see a path forward")
- **Token-efficient getting-started skills**: Keep under 150 words; longer skills should use `@link` cross-references
- **Keywords throughout**: Scatter related terms, tool names, and domain vocabulary in the body

## Skill File Conventions

- **One skill per directory** — never bundle multiple skills in one folder.
- **Kebab-case names** — directory name and `name` frontmatter must match exactly.
- **Single-purpose** — if a SKILL.md handles multiple distinct scenarios, split into separate skills.
- **Explicit loophole closure** — for discipline-enforcing skills, add a rationalization table listing common excuses and counters.
- **Red flags list** — include a self-check section the model can use when it's tempted to skip the skill's guidance.
- **No examples dilution** — one excellent example beats multi-language variations.
- **No build step** — this repo is plain markdown. No compilation, bundling, testing, or CI pipeline (except the remembering-conversations Node.js tool).

## The remembering-conversations Tool

The `collaboration/remembering-conversations/` skill is the only one with executable code. It provides semantic search over past Claude Code conversations.

**Stack:** Node.js, TypeScript, `better-sqlite3`, `sqlite-vec` (vector similarity), `@xenova/transformers` (local embeddings), `@anthropic-ai/claude-agent-sdk`

**Scripts (run from the skill directory):**
```bash
npm run index    # Index conversation history into SQLite + vector store
npm run search   # Search indexed conversations
npm test         # Run Vitest test suite
npm run test:watch
```

**How it works:** Conversations are embedded locally (no API call) via @xenova/transformers, stored in sqlite-vec for ANN search, with exact text match fallback. The SKILL.md documents installation hooks for automatic indexing.

**When editing this skill's code:** run `npm test` after changes — it's the only skill with automated tests.

## Attribution (ABOUT.md)

When a skill is derived from another project, add `ABOUT.md` alongside `SKILL.md`:

```markdown
# <Category> Skills - Attribution

This skill was derived from [Source Project](URL).

**Source Repository:**
- Name: <name>
- URL: <url>
- Commit: <sha>
- Date: YYYY-MM-DD

## Skills Derived

**From <agent/component name>:**
- <skill-name> - What was adapted and why

## What Was Adapted

[Explain what the original did and what you changed.]
```

Skills in `problem-solving/`, `architecture/`, and `research/` are derived from the [Microsoft Amplifier](https://github.com/microsoft/amplifier) project.

## Adding a New Skill

1. Choose the right category directory. If none fits, propose a new one in the PR.
2. Create: `skills/<category>/<skill-name>/SKILL.md`
3. Fill in YAML frontmatter with `name`, `description`, and optionally `version` and `languages`.
4. Write the skill body. Include an overview, instructions, and at minimum one concrete example.
5. If derived from another project, add `ABOUT.md` with full attribution.
6. Test the skill with subagents under realistic pressure scenarios before submitting.
7. Open a PR. Describe what the skill does, when it's useful, and what makes it non-obvious.

## Requesting New Skills

Add an entry to `skills/REQUESTS.md` when a skill would have helped but doesn't exist:

```markdown
## [Short Descriptive Name]
**What I need:** One-line description
**When I'd use it:** Specific situations/symptoms
**Why I need this:** What makes this non-obvious or worth capturing
**Added:** YYYY-MM-DD
```

Be specific: "Flaky test debugging" beats "testing help". Include error messages or behavior patterns where possible.

## Installation

Consumed automatically by the superpowers plugin:
```
~/.config/superpowers/skills/
```

For manual install, clone into that path.

## Contributing

Fork → add or improve a skill → open a PR. The PR description should explain what the skill does, when it's useful, and what makes it non-obvious. Check neighboring skills in the category before adding to avoid duplication.
