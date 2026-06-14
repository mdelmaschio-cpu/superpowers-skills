---
name: 3D Zoning Envelope Viewer
description: Generate an interactive 3D axonometric zoning envelope viewer as a self-contained HTML file using Three.js, from a zoning analysis report produced by /zoning-analysis-nyc.
when_to_use: when visualizing the maximum buildable envelope for a NYC property in 3D; presenting zoning analysis findings to clients or stakeholders; or generating an interactive HTML model from zoning data — oppure quando si vuole visualizzare in 3D l'inviluppo massimo edificabile per una proprietà a NYC, si presentano i risultati dell'analisi urbanistica a clienti o stakeholder, o si genera un modello HTML interattivo dai dati di zoning
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /zoning-envelope — 3D Zoning Envelope Viewer

Generates interactive 3D axonometric zoning envelope viewers as self-contained HTML files using Three.js. Compatible with any browser, no external dependencies.

**Prerequisite**: requires a zoning analysis report from `/zoning-analysis-nyc`. This skill is a renderer — it does not perform zoning calculations.

## Usage

```
/zoning-envelope                    (auto-detects most recent zoning-analysis-*.md)
/zoning-envelope zoning-analysis-120-broadway.md
/zoning-envelope 120 Broadway       (searches by address)
```

## Workflow

**Step 1: Locate Report** — accept direct file path, search term, or auto-detect most recent `zoning-analysis-*.md`. If the report lacks an `Envelope Data` JSON block, notify user to re-run the analysis.

**Step 2: Parse Envelope Data** — extract JSON block containing lot polygon coordinates, setbacks, volume definitions (base/tower), height caps, and metadata.

**Step 3: Build Internal Model** — normalize lot boundaries, compute inset polygons for setback zones and tower footprints, prepare volume extrusion data. Tower is always smaller than the base (cumulative insets).

**Step 4: Generate HTML** — render scene with:
- Background: beige `#f5f3ef`
- Building volumes: blue `#6ba0c5` at varying opacity
- Height cap: amber `#e8a849`
- Overlay panels for title, parameters, legend, and controls

**Step 5: Save & Open** — write the file adjacent to the source report using `zoning-envelope-` prefix and open in browser.

## Technical Details

- Polygon inset function auto-corrects winding direction
- Multi-scenario support with toggle buttons when applicable
- Camera scaling adapts to lot dimensions (25 ft to 170+ ft)
- All materials use transparency, depth-write disabled, double-sided rendering
