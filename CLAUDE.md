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
    ├── architecture/          # System design patterns (1 skill) — from Microsoft Amplifier
    │   ├── ABOUT.md
    │   └── preserving-productive-tensions/
    ├── architecture-design/   # Architecture, real estate & product data skills (39 skills) — from AlpacaLabsLLC
    │   ├── ABOUT.md
    │   ├── studio/            # Dispatcher for all architecture skills
    │   ├── skills-menu/       # List/navigate all available skills
    │   ├── project-dossier/   # Project dossier management
    │   ├── decision/          # Document design decisions
    │   ├── nyc-*/             # NYC due diligence (landmarks, DOB permits/violations, ACRIS, HPD, BSA, property-report)
    │   ├── environmental-analysis/ site-history/ mobility-analysis/ demographics-analysis/
    │   ├── zoning-analysis-nyc/ zoning-envelope/
    │   ├── workplace-programmer/ occupancy-calculator/
    │   ├── spec-writer/       # Technical product specifications
    │   ├── epd-*/             # Sustainability: EPD parse/research/compare/to-spec
    │   ├── product-*/         # Materials research: research/spec-bulk-fetch/cleanup/spec-pdf-parser/
    │   │                      #   image-processor/data-import/enrich/match/pair
    │   ├── master-schedule/   # Master materials schedule
    │   ├── csv-to-sif/ sif-to-csv/
    │   ├── slide-deck-generator/ color-palette-generator/ resize-images/
    │   └── ...
    ├── collaboration/         # Team collaboration & git workflow skills (10 skills)
    │   ├── brainstorming/
    │   ├── dispatching-parallel-agents/
    │   ├── executing-plans/
    │   ├── finishing-a-development-branch/
    │   ├── receiving-code-review/
    │   ├── remembering-conversations/  # Only skill with executable code
    │   │   ├── SKILL.md
    │   │   ├── INDEXING.md
    │   │   ├── DEPLOYMENT.md
    │   │   └── tool/          # Node.js/TypeScript source + CLI scripts
    │   ├── requesting-code-review/
    │   ├── subagent-driven-development/
    │   ├── using-git-worktrees/
    │   └── writing-plans/
    ├── context-engineering/   # LLM context & agent system skills (15 skills) — from muratcankoylan
    │   ├── ABOUT.md
    │   ├── context-fundamentals/   # Context window mechanics
    │   ├── context-degradation/    # Lost-in-middle, poisoning, distraction
    │   ├── context-compression/    # Compacting long agent sessions
    │   ├── context-optimization/   # Token budgeting, KV-cache, partitioning
    │   ├── multi-agent-patterns/   # Supervisor, swarm, hierarchical topologies
    │   ├── tool-design/            # Tool descriptions, schemas, MCP namespacing
    │   ├── filesystem-context/     # Files as overflow context / durable scratchpad
    │   ├── hosted-agents/          # Remote sandboxed agent infrastructure
    │   ├── latent-briefing/        # KV-cache memory sharing between agents
    │   ├── memory-systems/         # Cross-session memory: Mem0, Zep, Letta, Cognee
    │   ├── evaluation/             # Deterministic checks, rubrics, quality gates
    │   ├── advanced-evaluation/    # LLM-as-judge, pairwise comparison, bias
    │   ├── harness-engineering/    # Autonomous agent control loops, rollback
    │   ├── project-development/    # LLM project architecture, cost estimation
    │   └── bdi-mental-states/      # BDI cognitive architecture with RDF semantics
    ├── debugging/             # Debugging & troubleshooting skills (4 skills)
    │   ├── defense-in-depth/
    │   ├── root-cause-tracing/
    │   ├── systematic-debugging/
    │   └── verification-before-completion/
    ├── legal/                 # Swiss legal practice skills (6 skills)
    │   ├── ABOUT.md
    │   ├── swiss-code-obligations/        # Search/cite the Swiss Code of Obligations (CO/OR/RS 220)
    │   ├── analisi-contratto-co/          # Analyze contracts against CO provisions
    │   ├── redazione-clausole-co/         # Draft CO-compliant contract clauses
    │   ├── parere-legale/                 # Structure a formal Swiss legal opinion
    │   ├── ricerca-giurisprudenza-svizzera/ # Research Swiss case law (BGE/ATF)
    │   └── due-diligence-legale-svizzera/  # Swiss legal due diligence checklist
    ├── meta/                  # Skills about using/managing skills (5 skills)
    │   ├── gardening-skills-wiki/  # Wiki health check scripts
    │   ├── pulling-updates-from-skills-repository/
    │   ├── sharing-skills/
    │   ├── testing-skills-with-subagents/
    │   └── writing-skills/
    ├── problem-solving/       # Reasoning & decision-making strategies (6 skills) — from Microsoft Amplifier
    │   ├── ABOUT.md
    │   ├── collision-zone-thinking/
    │   ├── inversion-exercise/
    │   ├── meta-pattern-recognition/
    │   ├── scale-game/
    │   ├── simplification-cascades/
    │   └── when-stuck/
    ├── research/              # Investigation & knowledge synthesis (1 skill) — from Microsoft Amplifier
    │   ├── ABOUT.md
    │   └── tracing-knowledge-lineages/
    ├── testing/               # Test strategies & anti-patterns (3 skills)
    │   ├── condition-based-waiting/
    │   ├── test-driven-development/
    │   └── testing-anti-patterns/
    └── using-skills/          # How to use Claude Code skills effectively (1 skill)
        ├── SKILL.md
        ├── find-skills        # Shell script: list/filter available skills
        └── skill-run          # Shell script: invoke a skill by name
```

## How Skills Work

Each skill lives in its own directory inside a category folder. The directory name is the skill identifier. Every skill requires a `SKILL.md` file, and optionally an `ABOUT.md` for attribution.

**SKILL.md frontmatter format:**
```yaml
---
name: Human-Readable Skill Name
description: One-line summary of what this skill does
when_to_use: when [trigger situations and symptoms that signal this skill applies]
version: X.Y.Z
languages: all | [typescript, python, etc]
---
```

Note: `when_to_use` (not `description`) is the primary field the model uses for skill selection. Write it to complete the sentence "Use [skill-path] when [your text]". Include concrete symptoms, error messages, and situations. Keep it technology-agnostic unless the skill is technology-specific.

## Skill Categories

| Category | Purpose | Count |
|----------|---------|-------|
| `architecture/` | System design, structural patterns, trade-off analysis | 1 |
| `architecture-design/` | Architecture practice, NYC due diligence, sustainability (EPD), materials research, product data, presentations | 39 |
| `collaboration/` | Team workflows, git branching, communication, handoff patterns | 10 |
| `context-engineering/` | LLM context management, multi-agent patterns, memory systems, evaluation, harness engineering | 15 |
| `debugging/` | Diagnosing failures, root cause analysis, error patterns | 4 |
| `legal/` | Swiss legal practice: CO statutory research, contract analysis/drafting, legal opinions, case-law research, due diligence | 6 |
| `meta/` | Skills about working with Claude Code skills themselves | 5 |
| `problem-solving/` | General reasoning, ideation, and decision-making strategies | 6 |
| `research/` | Investigation, information synthesis, knowledge lineage | 1 |
| `testing/` | Test strategies, TDD, flaky tests, anti-patterns | 3 |
| `using-skills/` | How to write, install, and invoke Claude Code skills | 1 |

## Key Conventions for Skill Authoring

### Frontmatter Rules

- `name`: Human-readable, title-case (e.g. "Systematic Debugging")
- `when_to_use`: rich trigger phrases starting with "when" — this is what drives skill selection; optimize for discoverability
- `description`: one-line summary
- `version`: semver (X.Y.Z)
- `languages`: `all` or a specific list — drives context-aware invocation

### Claude Search Optimization (CSO)

The model discovers skills by matching `when_to_use` and skill body against the user's request. Optimize for discoverability:

- **`when_to_use` starts with "when"**: Designed to complete "Use [skill] when [text]"
- **Concrete symptoms in `when_to_use`**: Describe the *problem* not the language-specific symptom ("race conditions" not "setTimeout")
- **Active verb-first naming**: `creating-skills` not `skill-creation`; gerunds work well for processes
- **Rich trigger phrases**: Include symptoms, error messages, and user phrases throughout the body
- **Symptom-mapped sections**: Map each guidance item to a specific trigger scenario
- **Keywords throughout**: Scatter related terms, tool names, and domain vocabulary in the body
- **Token-efficient frequently-loaded skills**: Keep under 150-200 words; longer skills use cross-references
- **Cross-references without `@` prefix**: Use `skills/category/skill-name` not `@skills/...` — `@` force-loads and burns context

### Skill Quality Standards

- **One skill per directory** — never bundle multiple skills in one folder
- **Kebab-case directory names** — directory name and `name` frontmatter are separate (name is human-readable)
- **Single-purpose** — if a SKILL.md handles multiple distinct scenarios, split into separate skills
- **Explicit loophole closure** — for discipline-enforcing skills, add a rationalization table listing common excuses and counters
- **Red flags list** — include a self-check section the model uses when tempted to skip the skill's guidance
- **One excellent example** — beats multi-language variations every time
- **No build step** — this repo is plain markdown (except `remembering-conversations/tool/`)

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

Skills in `problem-solving/`, `architecture/`, and `research/` are derived from the [Microsoft Amplifier](https://github.com/microsoft/amplifier) project.

Skills in `architecture-design/` are derived from [skills-for-architects](https://github.com/AlpacaLabsLLC/skills-for-architects) by AlpacaLabsLLC (imported 2026-06-12).

Skills in `context-engineering/` are derived from [Agent-Skills-for-Context-Engineering](https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering) by muratcankoylan (imported 2026-06-12).

## TDD-Based Skill Development

Skills are developed using a test-first approach — the **Iron Law: no skill without a failing test first**.

1. **RED**: Run a baseline test — confirm the unguided model exhibits the target failure behavior
2. **GREEN**: Write minimal skill content that fixes the specific failure
3. **REFACTOR**: Close loopholes and explicitly pre-empt rationalizations

Test skills using subagents with pressure scenarios:
- Time pressure ("we're already late"), sunk cost ("we've invested too much"), authority pressure ("the boss wants this now"), exhaustion ("we've tried everything")
- A skill that fails under pressure is not ready for production

See `skills/meta/testing-skills-with-subagents/` for the detailed testing process, pressure scenario formats, and worked examples.

## The remembering-conversations Tool

The `collaboration/remembering-conversations/` skill is the only one with executable code. It provides semantic search over past Claude Code conversations.

**Stack:** Node.js, TypeScript (ES2022/ESNext modules), `better-sqlite3`, `sqlite-vec` (vector similarity), `@xenova/transformers` (local embeddings, all-MiniLM-L6-v2, 384 dims), `@anthropic-ai/claude-agent-sdk`

**Tool directory structure:**
```
tool/
├── index-conversations     # Main indexer CLI (executable)
├── search-conversations    # Search CLI (executable)
├── install-hook            # Install sessionEnd hook
├── migrate-to-config.sh    # Migration helper
├── test-deployment.sh      # End-to-end deployment tests
├── test-install-hook.sh    # Hook installer tests
├── package.json
├── tsconfig.json
├── prompts/
│   └── search-agent.md     # Subagent prompt template
└── src/
    ├── db.ts               # SQLite + sqlite-vec database layer
    ├── embeddings.ts       # @xenova/transformers embeddings
    ├── indexer.ts          # Core indexing logic
    ├── parser.ts           # JSONL conversation parser
    ├── paths.ts            # Path resolution utilities
    ├── search.ts           # Search logic (vector + text)
    ├── summarizer.ts       # Claude Haiku/Sonnet summarization
    ├── types.ts            # Shared TypeScript types
    ├── verify.ts           # Index verification and repair
    ├── db.test.ts
    ├── search-agent-template.test.ts
    └── verify.test.ts
```

**Scripts (run from `tool/` directory):**
```bash
cd skills/collaboration/remembering-conversations/tool
npm install          # Install dependencies first
npm run index        # Index conversation history (./index-conversations)
npm run search       # Search indexed conversations (./search-conversations)
npm test             # Run Vitest test suite
npm run test:watch   # Watch mode
```

**CLI usage:**
```bash
# Index
./index-conversations                    # Index all conversations
./index-conversations --cleanup          # Process only unindexed
./index-conversations --verify           # Check index health
./index-conversations --repair           # Fix issues from --verify
./index-conversations --rebuild          # Nuclear: delete + rebuild (with confirm)
./install-hook                           # Install sessionEnd auto-indexing hook

# Search
./search-conversations "query"           # Vector similarity (default)
./search-conversations --text "exact"    # Exact text match
./search-conversations --both "query"    # Both modes combined
./search-conversations --after 2025-01-01 --limit 5 "topic"
```

**Storage paths (at runtime):**
- Archive: `~/.config/superpowers/conversation-archive/<project>/<uuid>.jsonl`
- Summaries: `~/.config/superpowers/conversation-archive/<project>/<uuid>-summary.txt`
- Database: `~/.config/superpowers/conversation-index/db.sqlite`

**How it works:** Conversations are embedded locally (no API call) via @xenova/transformers and stored in sqlite-vec for ANN search. Summaries are generated via Claude Haiku (Sonnet fallback, ~$0.01-0.02/conversation). Exact text match serves as fallback.

**When editing this skill's code:** run `npm test` after changes — it's the only skill with automated tests.

## Wiki Health Tools

The `meta/gardening-skills-wiki/` skill includes shell scripts for checking wiki health:

```bash
# Run all checks (from ~/.config/superpowers/skills/)
~/.claude/skills/meta/gardening-skills-wiki/garden.sh

# Individual checks
check-links.sh          # Validate @-references and cross-links
check-naming.sh         # Validate kebab-case, frontmatter presence
check-index-coverage.sh # Validate INDEX files are complete
analyze-search-gaps.sh  # Find missing skills / coverage gaps
```

Run these after adding, removing, or reorganizing skills.

## Development Workflow

### Adding a New Skill

1. Choose the right category directory. If none fits, propose a new one in the PR.
2. Create: `skills/<category>/<skill-name>/SKILL.md`
3. Fill in YAML frontmatter: `name`, `when_to_use`, `description`, `version`, and optionally `languages`.
4. Write the skill body. Include overview, instructions, and at minimum one concrete example.
5. If derived from another project, add `ABOUT.md` with full attribution.
6. Test the skill with subagents under realistic pressure scenarios before submitting (see `skills/meta/testing-skills-with-subagents/`).
7. Run `garden.sh` to verify no broken links or naming issues.
8. Open a PR. Describe what the skill does, when it's useful, and what makes it non-obvious.

### Requesting New Skills

Add an entry to `skills/REQUESTS.md`:

```markdown
## [Short Descriptive Name]
**What I need:** One-line description
**When I'd use it:** Specific situations/symptoms
**Why I need this:** What makes this non-obvious or worth capturing
**Added:** YYYY-MM-DD
```

Be specific: "Flaky test debugging" beats "testing help". Include error messages or behavior patterns where possible.

### Contributing Back Upstream

Use the `meta/sharing-skills/` skill for the full workflow:

```bash
cd ~/.config/superpowers/skills/
git checkout -b "add-<skill-name>-skill"
# create/edit skill
git add skills/<category>/<skill-name>/
git commit -m "Add <skill-name> skill"
git push -u origin "add-<skill-name>-skill"
gh pr create --repo obra/superpowers-skills --title "Add <skill-name> skill" --body "..."
```

Each skill gets its own branch and PR — never batch multiple skills in one PR.

### Pulling Upstream Updates

Use the `meta/pulling-updates-from-skills-repository/` skill. Quick version:

```bash
cd ~/.config/superpowers/skills/
git stash   # if needed
git fetch upstream
git merge --ff-only @{u}
git stash pop   # if stashed
```

## Installation

Consumed automatically by the superpowers plugin:
```
~/.config/superpowers/skills/
```

For manual install, clone into that path.

## How AI Assistants Should Behave Here

- **`when_to_use` drives invocation** — not `description`. If users report a skill isn't being selected, the `when_to_use` field needs more trigger phrases and symptom descriptions
- **Test against real failure modes** — every skill should be validated by confirming it fixes a specific model failure under realistic pressure (RED-GREEN-REFACTOR for documentation)
- **Keep skills focused** — if a skill starts handling multiple scenarios, split it into separate skills
- **Close loopholes explicitly** — document the rationalizations users make to skip the skill's guidance, then counter each one with a rationalization table and red flags list
- **No build system** — do not introduce compilation, bundling, or CI pipelines (except for `remembering-conversations/tool/` which already has them)
- **Attribution is required** — always add `ABOUT.md` when a skill derives from another project
- **Cross-references: no `@` prefix** — use `skills/category/skill-name` format; `@` force-loads and burns context tokens
- **Token efficiency matters** — frequently-loaded skills (like `using-skills/`) must stay under 150-200 words
- **No narrative history** — skills are reusable reference guides, not stories about past sessions
- **`when_to_use` starts with "when"** — this is the convention that makes the find-skills tool output readable ("Use X when [text]")
- **Kebab-case directories** — directory names are kebab-case; the `name` frontmatter field is the human-readable display name
- **Run garden.sh** before committing skill changes to catch broken links, naming drift, and orphaned skills early
