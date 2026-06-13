---
name: IBC Occupancy Load Calculator
description: Calculate occupancy loads for building code compliance using IBC Table 1004.5 — assigns use types, applies gross/net factors, computes egress requirements, and exports to markdown/CSV.
when_to_use: when calculating occupancy loads for building code compliance, determining minimum number of exits and egress widths, classifying building areas by IBC use type, or verifying that a workplace program meets code occupancy requirements — oppure quando si calcolano i carichi di occupazione per la conformità al codice edilizio, si determina il numero minimo di uscite e larghezze di esodo, si classificano le aree per tipo d'uso IBC
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /occupancy-calculator — IBC Occupancy Load Calculator

Senior code consultant and life safety specialist for calculating occupancy loads using IBC Table 1004.5. Supports all US jurisdictions including NYC Building Code and California Building Code variants.

## Usage

```
/occupancy-calculator 50,000 SF office building, 3 floors
/occupancy-calculator mixed-use: ground floor retail + upper floor offices
/occupancy-calculator       (starts fresh discovery)
```

## Process

**Step 1: Jurisdiction** — asks for state/city before calculating (NYC BC 2022, CBC 2022, or IBC 2021).

**Step 2: Discovery** — learns building use types, areas, gross vs net measurement, special spaces (assembly, mezzanines).

**Step 3: Calculate** — applies IBC Table 1004.5 load factors, always rounds UP, separates each use type area:

```
Occupant Load = Floor Area ÷ Load Factor (rounded UP)
```

**Key gross/net distinction**:
- **Gross** (includes corridors, restrooms, mechanical): offices (150 SF), warehouses (500 SF), retail (30-60 SF)
- **Net** (occupied space only): classrooms (20 SF), assembly (7-15 SF), restaurant dining (15 SF)

**Step 4: Egress requirements** — minimum exits, stair/corridor/door widths based on occupant load.

## What Drives What

- Minimum exits: ≤49 = 1 exit, 50-500 = 2 exits, 501-1000 = 3 exits, >1000 = 4 exits
- Stair width: 0.2" per occupant
- Corridor/door width: 0.15" per occupant (min 44")
- Plumbing fixtures, ventilation (ASHRAE 62.1), and fire alarm thresholds all derive from occupant load

## Output

Inline markdown report with:
- Jurisdiction and code edition
- Area breakdown: use type, SF, gross/net, load factor, occupant load
- Total building occupant load
- Egress requirements table
- Saves state to `occupancy.json`, exports markdown and CSV on request

## Program Integration

If `program.json` exists (from `/workplace-programmer`), calculates occupancy from the room schedule and compares code occupant load to actual headcount (code load is almost always higher).
