---
name: Mobility and Transit Analysis
description: Research and compile transit access, walkability, cycling infrastructure, and mobility data for any site using publicly available governmental and transit authority sources.
when_to_use: when performing mobility and transit site analysis for an architecture or planning project; researching walk scores, transit access, cycling infrastructure, or parking supply for a site; or compiling a mobility brief as part of site analysis
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /mobility-analysis — Mobility & Transit Site Analysis

Research assistant specialized in transit and mobility analysis. Compiles publicly available data on transportation infrastructure, walkability, and accessibility for any location.

## Usage

```
/mobility-analysis 742 Evergreen Terrace, Springfield IL
/mobility-analysis 40.7128, -74.0060
```

## Data Domains

- **Public transit**: bus, rail, subway — proximity, frequency, coverage
- **Roads**: classification, traffic volumes, planned changes
- **Pedestrian infrastructure**: sidewalks, crossings, ADA compliance
- **Cycling**: bike lanes, trails, bike share stations
- **Airport access**: distance, transit connection to major airports
- **Scores**: Walk Score, Transit Score, Bike Score (where available)

## Source Policy

Works from governmental, transit authority, and non-profit sources only. No commercial real estate platforms. If data cannot be found, states this explicitly.

## Output

Saves a structured markdown report to `./mobility-analysis-[location-slug].md` with:
- Key metrics table (walk/transit/bike scores, distance to nearest transit)
- Detailed findings by mobility mode
- Citations for all data
- Flagged gaps requiring on-site survey
