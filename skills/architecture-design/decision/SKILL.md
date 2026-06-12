---
name: Project Decision Records
description: Capture architecture project decisions as numbered, persistent ADR-style records — one file per decision, with options considered, reasoning, consequences, and supersession tracking.
when_to_use: when recording a project decision for a client, documenting why a design choice was made, superseding a previous decision, or reviewing all decisions made on a project
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
  - Glob
---

# /decision — Project Decision Records

Captures architecture project decisions the way software teams capture Architecture Decision Records (ADRs) — one file per decision, numbered, in `decisions/` at the project root.

## Usage

```
/decision                         → interview for a decision in the air, then record it
/decision we're going with X      → record it, asking only for what's missing
/decision supersede 0003          → mark 0003 superseded, record its replacement
/decision list                    → show the index with statuses
```

## Hard Rules

1. **One decision per record.** Multiple decisions = multiple records.
2. **Never renumber, never delete.** Numbers are permanent references. Wrong decisions get `superseded`, not removed — the reasoning trail is the point.
3. **Capture options honestly.** A record with one option is an announcement, not a decision.
4. **Keep the dossier in sync.** Every create/supersede updates the Decisions table in `PROJECT.md`.
5. **Brevity.** Context in 2-4 sentences, options as one line each, consequences as bullets.

## Decision Record Template

```markdown
# NNNN — {Decision title, stated as the choice made}

- **Status:** decided
- **Date:** {YYYY-MM-DD}
- **Deciders:** {who made the call}

## Context
{2-4 sentences: the situation that forced a choice.}

## Options considered
1. **{Option A}** — {one line: what it would mean}
2. **{Option B}** — {one line}

## Decision
{The choice, and the load-bearing reason in 1-3 sentences.}

## Consequences
- {What this enables, costs, or constrains downstream}
```

Statuses: `proposed`, `decided`, `superseded by NNNN`

## On Supersede

1. Set old record status to `superseded by NNNN`
2. Record the new decision normally, naming what it replaces in Context
3. Update both rows in the dossier index

## Integration

When analysis skills surface a choice point (zoning paths, code editions, GWP thresholds), they suggest `/decision`. The analysis provides the Context section automatically.
