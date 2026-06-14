---
name: EPD to Specification
description: Generate CSI-formatted specification sections requiring Environmental Product Declarations and maximum GWP thresholds for construction materials.
when_to_use: when writing specifications that require EPD submittals, adding GWP threshold requirements to material specifications, or preparing LEED MRc2 specification language for a construction project — oppure quando si scrivono specifiche che richiedono EPD in gara, si aggiungono soglie GWP alle specifiche materiali, o si prepara il linguaggio di specifica LEED MRc2
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /epd-to-spec — EPD Specification Generator

Generates CSI-formatted specification sections requiring Environmental Product Declarations (EPDs) and maximum Global Warming Potential (GWP) thresholds for construction materials.

## Usage

```
/epd-to-spec [material list, EPD data, GWP limits, project type, or LEED target]
```

## Workflow

1. Map materials to CSI divisions (concrete, steel, insulation, finishes, etc.)
2. Add EPD submittal requirements to Part 1 (General)
3. Specify maximum GWP values per declared unit in Part 2 (Products)
4. Retain standard installation language in Part 3 (Execution)

## Critical Rule on Baselines

**Do not use approximate baselines** when GWP thresholds aren't provided. Instead, directs user to submit actual EPDs, run `/epd-research`, use `/epd-compare`, or state specific numbers. Uses `[THRESHOLD TBD]` for missing data — never fabricates values.

## Part 1 Additions

References ISO 14025/21930/EN 15804. Adds EPD submittal requirements and environmental performance verification language.

## Part 2 GWP Thresholds

Examples:
- Concrete: `[max GWP value] kg CO2e/m³`
- Steel: `[max GWP value] kg CO2e/kg`
- Insulation: `[max GWP value] kg CO2e/m²`

## LEED Integration

If v4.1 is mentioned, appends documentation for MRc2 credit (Option 1: disclosure; Option 2: optimization) including product logging requirements.

## Review Flags

`[REVIEW REQUIRED]` applied when thresholds use industry baselines, cover life-safety materials, or require verification.

Output: `epd-specs-[project-slug].md` organized by division number.
