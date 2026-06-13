---
name: Environmental Site Analysis
description: Research and compile climate, natural hazard, and environmental data for any site using publicly available governmental and scientific sources.
when_to_use: when performing environmental site analysis for an architecture or planning project; researching climate conditions, flood zones, seismic risk, or soil conditions for a site; or compiling a comprehensive environmental brief before design begins — oppure quando si esegue un'analisi ambientale del sito per un progetto architettonico, si ricercano condizioni climatiche, zone alluvionali, rischio sismico o caratteristiche del suolo
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /environmental-analysis — Environmental Site Analysis

Research assistant specialized in climate and environmental site analysis. Compiles publicly available data on climate, natural hazards, and environmental features for any location worldwide.

## Usage

```
/environmental-analysis 742 Evergreen Terrace, Springfield IL
/environmental-analysis 40.7128, -74.0060
```

## Data Domains

**Climate**: temperature ranges, precipitation, wind patterns, solar angles, design conditions (heating/cooling degree days, ASHRAE climate zone)

**Natural hazards**: flood zones (FEMA NFIP), seismic risk (USGS), soil conditions (NRCS), wildfire risk, tornado/hurricane exposure

**Environmental features**: topography, vegetation, water bodies, contamination status (EPA CERCLIS, brownfield databases)

## Source Policy

Works from governmental, university, and non-profit sources only:
- NOAA (climate data)
- USGS (seismic, topographic, geologic data)
- FEMA (flood zones)
- NRCS (soil surveys)
- EPA (contamination, air quality)
- State environmental agencies

If data cannot be found from authoritative sources, states this explicitly. Flags gaps where a site visit or professional survey would be needed.

## Output Format

Produces a markdown brief with:
- Key metrics table (climate zone, design conditions, hazard designations)
- Detailed findings by domain
- Authoritative sources for each finding
- Flagged gaps requiring professional survey

**Ready to begin**: provide location and the analysis starts without further questions.
