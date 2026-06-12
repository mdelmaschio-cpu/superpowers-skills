---
name: Studio Dispatcher
description: Smart router for architecture and AEC skills — describe your task and get routed to the right agent or skill without knowing which one to use.
when_to_use: when unsure which architecture skill to use, wanting to be automatically routed to the right agent based on a task description, or needing a starting point for any architecture or AEC workflow
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Glob
  - Grep
---

# /studio — Architecture Studio Dispatcher

Smart router for architecture and AEC skills. Describe your task and get routed to the right agent or skill.

## Usage

```
/studio task chair, mesh back, under $800
/studio 123 Main St, Brooklyn NY
/studio I need a space program for 200 people, 3 days hybrid
/studio parse this EPD
/studio make a presentation from this report
```

## Routing Table

| If the request involves... | Route to |
|---|---|
| Site context, climate, transit, demographics, neighborhood history | Site Planner agent |
| NYC address + zoning, FAR, permits, violations, landmarks, ownership | NYC Zoning Expert agent |
| Headcount, space program, office sizing, occupancy loads | Workplace Strategist agent |
| Product search, furniture brief, materials palette | Product & Materials Researcher agent |
| FF&E schedule, room packages, export to SIF | FF&E Designer agent |
| EPD, embodied carbon, GWP, LEED materials credits | Sustainability Specialist agent |
| Presentation, slide deck, color palette | Brand Manager agent |
| CSI specification writing | `/spec-writer` |
| Project setup, facts file | `/project-dossier` |
| Record a decision | `/decision` |
| User names a specific skill | That skill directly |

## Routing Rules

1. **One agent** — dispatch immediately; say which agent handles it, then hand off.
2. **One skill** — invoke that skill directly.
3. **Ambiguous** — ask exactly one clarifying question, then route.
4. **Multi-agent** — state the sequence, route to the first agent.
5. **Unknown** — show the condensed menu of available capabilities.
6. **No arguments** — show the condensed menu.

Does not perform the work itself — only routes. The agent files contain the orchestration logic.
