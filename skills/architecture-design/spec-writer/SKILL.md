---
name: CSI Specification Writer
description: Generate structured three-part CSI MasterFormat 2020 construction specification sections from materials lists, product schedules, or project descriptions.
when_to_use: when generating outline specifications for a construction project, organizing materials by CSI division, writing three-part spec sections with submittals and quality assurance language, or preparing specification documents from a product schedule
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /spec-writer — CSI Outline Specification Writer

Generates structured construction specification sections organized by CSI MasterFormat 2020 divisions from materials or product lists.

## Usage

```
/spec-writer [materials list, file path, or project description]
```

## MasterFormat Coverage

Divisions 03–10, 12, 22, 26 — concrete, masonry, metals, wood, thermal/moisture protection, openings, finishes, specialties, furnishings, plumbing fixtures, electrical fixtures.

## Three-Part SectionFormat Output

Each section follows CSI SectionFormat conventions:
- **Part 1: General** — scope, standards, submittals, quality assurance, warranty
- **Part 2: Products** — manufacturers, materials, performance criteria, finishes, accessories
- **Part 3: Execution** — examination, preparation, installation, quality control, cleaning

## Workflow

1. Parse materials into CSI divisions/sections; confirm mapping with user
2. Generate outline specs following SectionFormat conventions
3. Flag sections requiring senior review
4. Write markdown output to `outline-specs-[project-slug].md`
5. Report section counts and review flags

## Writing Conventions

- Uses "shall" language, imperative mood, no contractions
- Includes "approved equal" manufacturer substitution clauses
- Applies `[REVIEW REQUIRED]` flags for generic, life-safety, or incomplete sections
- Handles ambiguous materials via clarifying questions
- Consolidates duplicate materials under single sections

## Project Integration

Integrates with `PROJECT.md` dossier if present; updates decision records. Suggests `/decision` for specification choices with downstream consequences.
