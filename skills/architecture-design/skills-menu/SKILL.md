---
name: Architecture Skills Menu
description: Display the full menu of 39 architecture and AEC skills and 7 agents available in the studio.
when_to_use: when wanting to see all available architecture skills, getting an overview of what the studio can do, or finding a specific skill by category — oppure quando si vuole vedere tutte le skill di architettura disponibili, avere una panoramica delle capacità dello studio, o trovare una skill specifica per categoria
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Glob
---

# /skills-menu — Architecture Studio Skills Menu

**39 skills, 7 agents** — type `/studio [your task]` to get routed, or call any skill directly.

## Agents

| Agent | What it does |
|-------|-------------|
| **Site Planner** | Full site brief — climate, transit, demographics, neighborhood context |
| **NYC Zoning Expert** | NYC property + zoning — due diligence, FAR, buildable envelope, 3D viewer |
| **Workplace Strategist** | Space programs — headcount to occupancy compliance to room schedules |
| **Product & Materials Researcher** | Find products from a brief, extract specs from URLs/PDFs, find alternatives |
| **FF&E Designer** | Build schedules from messy inputs, compose room packages, QA, export |
| **Sustainability Specialist** | EPD research, GWP comparison, LEED eligibility, spec thresholds |
| **Brand Manager** | Presentations, color palettes, visual consistency, deliverable QA |

## Skills by Category

### Site & Due Diligence
`/environmental-analysis` `/mobility-analysis` `/demographics-analysis` `/history` `/nyc-landmarks` `/nyc-dob-permits` `/nyc-dob-violations` `/nyc-acris` `/nyc-hpd` `/nyc-bsa` `/nyc-property-report`

### Zoning
`/zoning-analysis-nyc` `/zoning-envelope`

### Programming
`/occupancy-calculator` `/workplace-programmer`

### Specifications
`/spec-writer`

### Sustainability
`/epd-research` `/epd-parser` `/epd-compare` `/epd-to-spec`

### Product & Materials Research
`/product-research` `/product-spec-bulk-fetch` `/product-spec-pdf-parser` `/product-data-cleanup` `/product-enrich` `/product-match` `/product-pair` `/product-image-processor` `/product-data-import` `/master-schedule` `/csv-to-sif` `/sif-to-csv`

### Presentations
`/slide-deck-generator` `/color-palette-generator` `/resize-images`

### Project Dossier
`/project-dossier` `/decision`

---

Use `/studio [task description]` for automatic routing.
