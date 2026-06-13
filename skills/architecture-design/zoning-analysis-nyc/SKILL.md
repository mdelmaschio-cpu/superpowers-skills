---
name: NYC Zoning Analysis
description: Analyze building envelope regulations for NYC properties using PLUTO database records and Zoning Resolution rules — FAR, height, setbacks, permitted uses, overlays, and special districts.
when_to_use: when analyzing zoning regulations for a NYC property; calculating maximum buildable area, FAR, height limits, and setbacks; researching permitted uses; understanding overlays and special districts; or preparing a zoning analysis for an architecture or development project — oppure quando si analizzano le normative urbanistiche per una proprietà a NYC, si calcola la superficie massima edificabile, FAR, limiti di altezza e distacchi, o si prepara un'analisi urbanistica per un progetto architettonico o di sviluppo
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /zoning-analysis-nyc — NYC Zoning Analysis

Analyzes building envelope regulations for New York City properties using PLUTO database records and Zoning Resolution rules. Covers all five boroughs.

## Usage

```
/zoning-analysis-nyc 120 Broadway, Manhattan
/zoning-analysis-nyc 1000770001          (BBL)
```

## Eight-Step Analysis

1. **Parse input** into normalized Borough-Block-Lot (BBL) format
2. **Query PLUTO APIs** for tabular lot data and polygon geometry
3. **Identify zoning district** (Residential/Commercial/Manufacturing)
4. **Load applicable regulation files** from `zoning-rules/` directory
5. **Calculate bulk envelope** including FAR, height, setbacks, yards
6. **Layer overlays and special districts** (commercial overlays, special purpose zones, landmarks, City of Yes reforms)
7. **Present structured analysis** with tables and machine-readable JSON
8. **Save markdown report** with address-based filename

## Data Sources

- **Socrata PLUTO**: `https://data.cityofnewyork.us/resource/64uk-42ks.json` — tabular lot attributes
- **MapPLUTO ArcGIS**: `https://a841-dotweb01.nyc.gov/arcgis/rest/services/GAZETTEER/MapPLUTO/MapServer/0` — exact lot polygon

Both require no authentication.

## Output Includes

- Lot summary table (area, frontage, depth, bldg class)
- Zoning district and permitted uses
- Bulk parameters (FAR by use, height limit, required yards/setbacks)
- Parking requirements
- Development scenarios (as-of-right, with bonus, with special permit)
- Machine-readable JSON envelope data for use with `/zoning-envelope`
- Notes on City of Yes housing reforms (adopted December 2024)

**Next step**: use `/zoning-envelope` to generate an interactive 3D visualization of the calculated envelope.
