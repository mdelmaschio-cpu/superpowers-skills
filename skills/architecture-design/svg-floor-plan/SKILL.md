---
name: SVG Floor Plan Generator
description: Generate schematic SVG floor plans, elevations, and sections from room descriptions, dimensions, and adjacency requirements — output is a self-contained SVG file editable in Illustrator, Inkscape, or any browser.
when_to_use: when generating a schematic floor plan from a verbal description or room program, producing a quick layout diagram to test adjacencies, creating a diagrammatic section or elevation for a presentation, or visualizing a spatial concept before opening CAD software — oppure quando si genera una pianta schematica da una descrizione verbale o un programma spaziale, si produce un diagramma di layout rapido per testare le adiacenze, si crea una sezione o prospetto diagrammatico per una presentazione, o si visualizza un concetto spaziale prima di aprire il software CAD
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
---

# /svg-floor-plan — SVG Floor Plan Generator

Generates schematic architectural drawings as self-contained SVG files from verbal descriptions, room programs, or dimension lists. Output opens in any browser and is fully editable in Adobe Illustrator or Inkscape.

## Usage

```
/svg-floor-plan pianta 3 locali, soggiorno 25m², cucina 12m², camera 18m², bagno 8m²
/svg-floor-plan office layout: open space 200m², 4 meeting rooms, reception, kitchen
/svg-floor-plan section through a 4-storey residential building, floor height 3.0m
/svg-floor-plan elevation: 3-bay facade, 4 floors, ground floor commercial
```

## What It Produces

- **Floor plan**: rooms as labeled rectangles with approximate proportions, walls (thick lines), openings for doors/windows, north arrow, scale bar
- **Section**: floor slabs, storey heights, key spaces labeled
- **Elevation**: façade grid, openings, material zones

Output is **schematic, not production** — suitable for concept design, client communication, space planning, and competition diagrams. Not a replacement for CAD drawings.

## SVG Generation Rules

### Coordinate System
- Origin (0,0) = top-left of drawing
- 1 SVG unit = 1 cm at 1:100 scale (default)
- Scale bar always included

### Layer Structure (SVG groups)
```xml
<g id="walls">       <!-- Exterior walls: stroke-width 8, black -->
<g id="partitions">  <!-- Interior walls: stroke-width 4, black -->
<g id="openings">    <!-- Doors/windows: white fill + arc or gap -->
<g id="spaces">      <!-- Room fills: light grey (#f5f5f5) or color-coded -->
<g id="labels">      <!-- Room names + areas: font-family monospace -->
<g id="dimensions">  <!-- Dimension lines: stroke-width 0.5, grey -->
<g id="annotation">  <!-- North arrow, scale bar, title block -->
```

### Room Placement Algorithm
1. Calculate area-proportional rectangles for each space
2. Arrange by adjacency priority (living → dining → kitchen / entry → corridor → rooms)
3. Align on grid (60cm module default)
4. Add wall thickness (exterior 30cm, interior 15cm)
5. Place door openings (90cm default) and window groups

### Standard Dimensions Applied
| Element | SVG stroke-width | Color |
|---------|-----------------|-------|
| Exterior wall | 8px | #000000 |
| Interior wall | 4px | #000000 |
| Door arc | 1px dashed | #000000 |
| Window | 2px | #000000 (3 lines) |
| Dimension line | 0.5px | #888888 |
| Room fill | — | #f5f5f5 (or program color) |
| Circulation | — | #e8e8e8 |
| Technical/WC | — | #ddeeff |

## Output Format

```xml
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     width="[W]mm" height="[H]mm"
     viewBox="0 0 [W] [H]">

  <title>[Project name] — Floor Plan Level [N]</title>

  <defs>
    <style>
      text { font-family: 'Helvetica Neue', Arial, sans-serif; }
      .room-label { font-size: 12px; fill: #333; }
      .area-label { font-size: 9px; fill: #666; }
      .dim-text { font-size: 8px; fill: #888; }
    </style>
  </defs>

  <!-- Scale: 1:100. 1 SVG unit = 1cm -->

  <g id="walls"> ... </g>
  <g id="partitions"> ... </g>
  <g id="openings"> ... </g>
  <g id="spaces"> ... </g>
  <g id="labels"> ... </g>
  <g id="dimensions"> ... </g>

  <!-- Title block -->
  <g id="titleblock">
    <text x="10" y="[bottom-30]">Project: [name]</text>
    <text x="10" y="[bottom-20]">Scale 1:100 — [date]</text>
  </g>

  <!-- North arrow -->
  <g id="northarrow" transform="translate([x],[y])"> ... </g>

  <!-- Scale bar: 0—1—2—5m -->
  <g id="scalebar"> ... </g>

</svg>
```

## Saving and Using the Output

- Saved as `[project-name]-floorplan-L[N].svg`
- **Open in browser**: drag SVG onto any browser tab
- **Edit in Illustrator**: File → Open (all groups preserved as layers)
- **Edit in Inkscape**: File → Open (free, cross-platform)
- **Import to Keynote/PowerPoint**: insert as image
- **Convert to PDF**: print from browser → Save as PDF

## Limitations

- Schematic accuracy only — not survey-accurate
- No automatic structural grid (add manually in CAD)
- Curved walls require manual editing in Illustrator
- No automatic stair geometry (simplified rectangle with diagonal lines)
- For production drawings: export geometry to CAD/BIM as starting point

## Tips for Best Results

- Provide room names + areas (m²) — the more specific, the better the layout
- Mention key adjacencies ("kitchen adjacent to dining", "all bedrooms off corridor")
- Specify building orientation if known (north = top default)
- For multi-storey: request each floor separately, specify structural grid
