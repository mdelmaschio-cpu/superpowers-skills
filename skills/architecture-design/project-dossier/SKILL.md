---
name: Project Dossier
description: Maintain PROJECT.md — a persistent project facts file documenting identity, site conditions, zoning constraints, program requirements, code standards, and a decision index for architecture projects.
when_to_use: when starting a new architecture project and needing a shared facts file, updating project facts after analysis findings, or ensuring all project skills share consistent project data from a single source of truth — oppure quando si avvia un nuovo progetto architettonico e serve un file di riferimento condiviso, si aggiornano i dati di progetto dopo nuove analisi, o si assicura che tutte le skill di progetto condividano dati coerenti da un'unica fonte
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /project-dossier — Project Facts File

Maintains `PROJECT.md` — the persistent project facts file at the project root. Documents core architecture project facts: identity, site conditions, zoning constraints, program requirements, code standards, and a decision index.

## Usage

```
/project-dossier          → show current state or offer to initialize
/project-dossier init     → create PROJECT.md after gathering project basics
/project-dossier update   → reconcile new findings with existing facts
```

## Core Principle

The dossier is the **facts layer** — what is known and current. Reasoning and justifications belong in separate decision records via `/decision`. This separation prevents duplication and keeps `PROJECT.md` as the single source of truth.

## Mandatory Rules

1. Every fact requires a source and date (e.g., "client, 2026-06-10")
2. Replace stale values in place — never duplicate entries
3. Record only facts, not decisions or rationale
4. Include project facts only — not user preferences or firm conventions

## Standard Sections

- **Identity**: project name, address, client, jurisdiction
- **Site**: climate zone, flood risk, transit access
- **Zoning**: district, FAR, height limits, overlays
- **Program**: headcount, space requirements, adjacencies
- **Code**: building code edition, occupancy classification
- **Decisions**: index of linked decision records from `/decision`

## Integration

All analysis skills (zoning, environmental, occupancy, EPD) check for `PROJECT.md` before running, populate their sections after completing, and ensure consistent project understanding across the team.
