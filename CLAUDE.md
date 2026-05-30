# superpowers-skills

Community-editable skills library for Claude Code's superpowers plugin. This repo is automatically cloned by the superpowers plugin to `~/.config/superpowers/skills/`.

## Repository Purpose

A shared, community-maintained library of Claude Code skills organized by functional category. Users fork the repo, add new skills or improve existing ones, and contribute back via PRs. Skills are markdown files that give Claude structured guidance for specific task types.

## Structure

```
superpowers-skills/
├── README.md
├── LICENSE
└── skills/
    ├── REQUESTS.md                          # Wishlist: skills to create next
    ├── architecture/                        # Architecture & system design skills
    │   ├── ABOUT.md                         # Attribution for derived skills
    │   └── preserving-productive-tensions/  # One directory per skill
    │       └── SKILL.md
    ├── collaboration/                       # Team collaboration skills
    ├── debugging/                           # Debugging & troubleshooting skills
    ├── meta/                                # Skills about using skills
    ├── problem-solving/                     # General problem-solving skills
    ├── research/                            # Research & investigation skills
    ├── testing/                             # Testing strategies and patterns
    └── using-skills/                        # How to use Claude Code skills effectively
```

## How Skills Work

Each skill lives in its own directory inside a category folder. The directory name is the skill identifier. Every skill requires a `SKILL.md` file, and optionally an `ABOUT.md` for attribution.

**SKILL.md format:**
```yaml
---
name: skill-name-in-kebab-case
description: Trigger-phrase-rich description for model invocation. Include the
  exact situations, symptoms, and phrases that should invoke this skill.
---

# Skill Title

[Skill body: instructions, patterns, examples]
```

The `description` field is critical: the model selects skills based on how well the description matches the user’s request. Generic descriptions lead to the skill being skipped.

## Skill Categories

| Category | Purpose |
|----------|---------|
| `architecture/` | System design, structural patterns, trade-off analysis |
| `collaboration/` | Team workflows, communication, handoff patterns |
| `debugging/` | Diagnosing failures, root cause analysis, error patterns |
| `meta/` | Skills about working with Claude and Claude Code skills |
| `problem-solving/` | General reasoning and decision-making strategies |
| `research/` | Investigation, information synthesis, source evaluation |
| `testing/` | Test strategies, coverage, flaky test patterns |
| `using-skills/` | How to write, install, and invoke Claude Code skills |

## Adding a New Skill

1. Choose the right category directory. If none fits, propose a new one.
2. Create a new directory: `skills/<category>/<skill-name>/`
3. Create `SKILL.md` with YAML frontmatter (`name`, `description`) and the skill body.
4. If the skill is derived from another project, add `ABOUT.md` with attribution (see below).
5. Open a PR. Include sample output or a before/after example if the skill’s behavior isn’t immediately obvious.

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

[Explain what the original did and what you extracted or changed.]
```

## Requesting New Skills

When you encounter a situation where a skill would have helped but one doesn’t exist, add an entry to `skills/REQUESTS.md`:

```markdown
## [Short Descriptive Name]
**What I need:** One-line description
**When I'd use it:** Specific situations/symptoms
**Why I need this:** What makes this non-obvious or worth capturing
**Added:** YYYY-MM-DD
```

Be specific: "Flaky test debugging" beats "testing help". Include error messages or behavior patterns where possible. One skill per request.

## Conventions

- **One skill per directory** — don’t bundle multiple skills in one folder.
- **Kebab-case names** — directory name and `name` frontmatter must match.
- **Single-purpose** — if a `SKILL.md` handles multiple distinct scenarios, split it into separate skills.
- **Trigger-phrase-rich descriptions** — think about what the user actually types; write the description to match those patterns.
- **Attribution** — if derived from another repo, include `ABOUT.md`.
- **No build step** — this repo is plain markdown; no compilation, bundling, testing, or CI needed.

## Installation

This repo is consumed automatically by the superpowers plugin:

```
~/.config/superpowers/skills/
```

For manual install, clone into that path.

## Contributing

Fork → add or improve a skill → open a PR. The PR description should explain what the skill does, when it’s useful, and what makes it non-obvious. If you’re adding to an existing category, check whether a nearby skill already covers the use case.
