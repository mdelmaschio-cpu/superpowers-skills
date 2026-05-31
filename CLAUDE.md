# superpowers-skills

Community-editable skills library for Claude Code's superpowers plugin. Automatically cloned to `~/.config/superpowers/skills/` by the superpowers plugin.

## Project Overview

This repository is a shared, community-maintained library of Claude Code skills organized by functional category. Skills are markdown files that give Claude structured guidance for specific task types — they tell Claude *how* to approach a particular class of problem rather than solving any one problem directly.

Users fork the repo, add new skills or improve existing ones, and contribute back via pull requests. The superpowers plugin automatically clones this repo to `~/.config/superpowers/skills/` so that installed skills are available to Claude Code sessions.

**License:** MIT, Copyright 2025 Jesse Vincent

## Repository Structure

```
superpowers-skills/
├── README.md                  # Short overview and installation notes
├── CLAUDE.md                  # This file — AI assistant guidance
├── LICENSE                    # MIT license
└── skills/
    ├── REQUESTS.md            # Wishlist: skills community members want created
    ├── architecture/          # System design and structural pattern skills
    │   ├── ABOUT.md           # Attribution for derived skills
    │   └── preserving-productive-tensions/
    │       └── SKILL.md
    ├── collaboration/         # Team workflows, git, communication, handoffs
    │   └── remembering-conversations/   # The ONLY skill with executable code
    │       ├── SKILL.md
    │       ├── package.json
    │       ├── src/
    │       └── tests/
    ├── debugging/             # Diagnosing failures, root cause analysis
    ├── meta/                  # Skills about using and managing skills
    ├── problem-solving/       # Reasoning, ideation, decision-making
    ├── research/              # Investigation and knowledge synthesis
    ├── testing/               # Test strategies, TDD, anti-patterns
    └── using-skills/          # How to write, install, and invoke skills
```

**Important:** This is a plain-markdown repository. There is no build step, no bundler, no CI pipeline, and no test suite — except for the `remembering-conversations` skill, which is Node.js/TypeScript and has its own `npm test`.

## Skills Directory — Categories

| Category | Purpose | Approximate Count |
|----------|---------|-------------------|
| `architecture/` | System design, structural patterns, trade-off analysis | ~2 |
| `collaboration/` | Team workflows, git branching, communication, handoff patterns | ~10 |
| `debugging/` | Diagnosing failures, root cause analysis, error patterns | ~4 |
| `meta/` | Skills about working with Claude Code skills themselves | ~5 |
| `problem-solving/` | General reasoning, ideation, and decision-making strategies | ~6 |
| `research/` | Investigation, information synthesis, knowledge lineage | ~1 |
| `testing/` | Test strategies, TDD, flaky tests, anti-patterns | ~3 |
| `using-skills/` | How to write, install, and invoke Claude Code skills | ~1 |

Skills in `problem-solving/`, `architecture/`, and `research/` are derived from the [Microsoft Amplifier](https://github.com/microsoft/amplifier) project.

## How Skills Work

Each skill lives in its own directory inside a category folder. The directory name is the skill identifier. Every skill requires a `SKILL.md` file, and optionally an `ABOUT.md` for attribution.

### SKILL.md Format

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

### How the Model Selects Skills

The model discovers and selects skills by matching the `description` field (and skill body text) against the user's request. This means:

- **The `description` field is the primary invocation mechanism** — write it for skill-selection, not for humans reading the README.
- Generic descriptions cause skills to be skipped. Specific trigger phrases, symptom descriptions, and concrete scenarios cause skills to be selected.
- If users report a skill is not being selected, the description needs more trigger phrases — not more body content.

### Attribution (ABOUT.md)

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

## How to Add a New Skill

1. **Choose a category.** Pick the most appropriate subdirectory under `skills/`. If none fits, propose a new category in the PR description.
2. **Create the skill directory:** `skills/<category>/<skill-name>/`
   - Directory name must be kebab-case.
   - Directory name must exactly match the `name` field in frontmatter.
3. **Write `SKILL.md`** with valid YAML frontmatter (`name`, `description`, required; `version` and `languages` recommended).
4. **Write the skill body.** Include an overview, step-by-step instructions, and at minimum one concrete example.
5. **If derived from another project,** add `ABOUT.md` with full attribution.
6. **Test the skill** using subagents under realistic pressure scenarios (time pressure, sunk cost, authority pressure, exhaustion) before submitting. A skill that fails under pressure is not ready.
7. **Open a PR.** The description must explain: what the skill does, when it's useful (specific symptoms), what makes the guidance non-obvious, and how you tested it.

## How to Request a New Skill

Add an entry to `skills/REQUESTS.md`:

```markdown
## [Short Descriptive Name]
**What I need:** One-line description
**When I'd use it:** Specific situations/symptoms
**Why I need this:** What makes this non-obvious or worth capturing
**Added:** YYYY-MM-DD
```

Be specific — "Flaky test debugging" beats "testing help". Include error messages or behavior patterns where possible.

## Skill Quality Standards

### Authoring Rules

| Rule | Detail |
|------|--------|
| One skill per directory | Never bundle multiple skills in one folder |
| Kebab-case names | Directory name and `name` frontmatter must match exactly |
| Single-purpose | If a SKILL.md handles multiple distinct scenarios, split into separate skills |
| Explicit loophole closure | For discipline-enforcing skills, add a rationalization table listing common excuses and counters |
| Red flags list | Include a self-check section for when the model is tempted to skip the guidance |
| No examples dilution | One excellent example beats multi-language variations |
| No build step | Plain markdown only (except `remembering-conversations`) |
| Attribution required | Always add `ABOUT.md` when derived from another project |

### Claude Search Optimization (CSO)

The model discovers skills by matching descriptions against the user's request. Optimize for discoverability:

- **Active verb-first naming:** `creating-skills` not `skill-creation`
- **Rich trigger phrases:** Include concrete symptoms, error messages, and user phrases in the description
- **Symptom-mapped sections:** Map each guidance item to a specific trigger (e.g. "when you feel stuck and can't see a path forward")
- **Keywords throughout:** Scatter related terms, tool names, and domain vocabulary in the body
- **Token-efficient getting-started skills:** Keep under 150 words; longer skills use cross-references

### TDD-Based Skill Development

Skills are developed using a test-first approach — the **Iron Law: no skill without a failing test first.**

1. **RED:** Run a baseline test — confirm the unguided model exhibits the target failure behavior
2. **GREEN:** Write minimal skill content that fixes the specific failure
3. **REFACTOR:** Close loopholes and explicitly pre-empt rationalizations

Test skills using subagents with pressure scenarios:
- Time pressure ("we're already late")
- Sunk cost ("we've invested too much")
- Authority pressure ("the boss wants this now")
- Exhaustion ("we've tried everything")

## The `remembering-conversations` Tool

The `collaboration/remembering-conversations/` skill is the only one with executable code. It provides semantic search over past Claude Code conversations.

**Stack:** Node.js, TypeScript, `better-sqlite3`, `sqlite-vec` (vector similarity search), `@xenova/transformers` (local embeddings), `@anthropic-ai/claude-agent-sdk`

**Scripts** (run from `skills/collaboration/remembering-conversations/`):

```bash
npm run index      # Index conversation history into SQLite + vector store
npm run search     # Search indexed conversations
npm test           # Run Vitest test suite
npm run test:watch # Watch mode
```

**How it works:** Conversations are embedded locally (no API call) via `@xenova/transformers`, stored in `sqlite-vec` for approximate nearest-neighbor search, with exact text-match fallback.

**When editing this skill's code:** Always run `npm test` after any changes. This is the only skill in the repo with automated tests.

## Installation

The superpowers plugin consumes this repo automatically:

```
~/.config/superpowers/skills/
```

For manual installation, clone the repo into that path.

## Contributing

Fork → add or improve a skill → open a PR.

The PR description must explain:
- What the skill does
- When it's useful (specific symptoms or situations)
- What makes the guidance non-obvious
- How you tested it (what failure mode did it fix?)

Check neighboring skills in the same category before adding to avoid duplication.

## How AI Assistants Should Behave in This Repository

- **Optimize descriptions for discoverability** — the `description` field is the primary invocation mechanism; write it for skill-selection, not for humans reading the README.
- **Test against real failure modes** — every skill should be validated by confirming it fixes a specific model failure under realistic pressure.
- **Keep skills focused** — if a skill starts handling multiple scenarios, split it.
- **Close loopholes explicitly** — document the rationalizations users make to skip the skill's guidance, then counter each one.
- **No build system** — do not introduce compilation, bundling, or CI pipelines (except for `remembering-conversations`, which already has them).
- **Attribution is required** — always add `ABOUT.md` when a skill derives from another project.
- **Descriptions drive invocation** — if users report a skill isn't being selected, the description needs more trigger phrases, not more body content.
- **Do not rename or move skill directories** without updating the `name` frontmatter to match exactly.
- **Do not create new top-level category directories** without a PR discussion — propose in the PR description instead.
