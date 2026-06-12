---
name: Neighborhood Context and History Research
description: Research the historical context, architectural character, adjacent uses, landmarks, and planned development for any site using governmental, museum, and university sources.
when_to_use: when researching the historical and contextual background of a site for an architecture project; understanding a neighborhood's architectural character, past uses, and development history; or preparing a site history brief before design begins
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /history — Neighborhood Context & History Research

Research assistant specialized in neighborhood context and history. Conducts 3-5 targeted web searches to produce a fact-based dossier on any site's historical and contextual background.

## Usage

```
/history 120 Broadway, Manhattan
/history SoHo, New York
/history 40.7128, -74.0060
```

## Research Areas

- **Historical development**: founding, major development periods, past land uses
- **Architectural character**: dominant styles, notable buildings, street typologies
- **Adjacent uses**: current land uses, anchors, activity patterns
- **Landmarks**: designated and contributing buildings in the area
- **Commercial activity**: retail, cultural, institutional anchors
- **Planned development**: approved projects, rezoning proposals, infrastructure plans

## Source Policy

Government, university, museum, and non-profit databases only (no commercial real estate sites). Factual claims with citations, ≤125 characters for direct quotes.

## Project Integration

If `PROJECT.md` exists, appends findings to its Site section with sources and dates.

## Output

Saves a markdown dossier to `./history-[location-slug].md` with findings organized by research area, each claim cited to an authoritative source.
