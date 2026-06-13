---
name: VKF Fire Protection (Swiss)
description: Swiss fire protection requirements per VKF/AEAI norms — building material classification, compartmentation, escape routes, sprinklers, and fire protection documentation for building permits.
when_to_use: when designing fire protection for a Swiss building, preparing the fire protection documentation (Brandschutznachweis) for a building permit, selecting fire-rated construction elements, designing escape routes per VKF norms, or evaluating whether a building requires sprinklers — oppure quando si progetta la protezione antincendio per un edificio svizzero, si prepara il Brandschutznachweis per il permesso di costruire, si scelgono elementi costruttivi resistenti al fuoco, si progettano le vie di esodo secondo le norme VKF, o si valuta se un edificio richiede lo sprinkler
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - WebFetch
---

# /vkf-brandschutz — Swiss Fire Protection (VKF/AEAI)

Swiss fire protection is governed by **VKF** (Vereinigung Kantonaler Feuerversicherungen) / **AEAI** (Association des établissements cantonaux d'assurance incendie) norms, adopted by all cantons.

## Core Documents

| Document | Content |
|----------|---------|
| **VKF Brandschutznorm** (2015) | Main requirements — binding in all cantons |
| **VKF Brandschutzrichtlinien** (~30 directives) | Detailed requirements by building/system type |
| **BSR 15-15i** | Fire protection documentation |
| **BSR 16-15i** | Escape routes (Fluchtwege) |
| **BSR 18-15i** | Escape route lighting |
| **BSR 21-15i** | Sprinkler systems |
| **BSR 22-15i** | Fire detection systems (BMA) |
| **BSR 26-15i** | Fire compartments |

All norms available free at: **bsronline.ch**

## Building Classification (Gebäudekategorien)

VKF classifies buildings by height and use:

| Category | Height | Examples |
|----------|--------|---------|
| **Low-rise** (niedrig) | ≤ 11 m floor to floor | Single family, small commercial |
| **Medium-rise** (mittel) | 11–30 m | Typical multi-family, office blocks |
| **High-rise** (Hochhaus) | > 30 m | Towers — special requirements |
| **Special** (Sonderbauten) | — | Hospitals, schools, large assembly, industrial |

## Fire Resistance Ratings (Feuerwiderstand)

Swiss ratings use **EI** (integrity + insulation) and **R** (load-bearing):

| Swiss rating | Duration | Typical application |
|-------------|----------|---------------------|
| EI 30 | 30 min | Interior partitions in low-risk areas |
| EI 60 | 60 min | Standard compartment walls |
| **EI 90** | 90 min | Stairwell walls, medium-rise compartments |
| **EI 120** | 120 min | High-rise, special buildings |
| REI 90 | 90 min | Load-bearing compartment structure |
| REI 120 | 120 min | High-rise structural elements |

## Material Classifications (Brennbarkeit)

| Class | Description | Examples |
|-------|-------------|---------|
| **RF1** | Non-combustible | Concrete, masonry, steel, glass |
| **RF2** | Low-flammability | Certain treated wood products |
| **RF3** | Combustible | Standard timber, most plastics |
| **RF4** | Highly flammable | Foam, unprotected EPS insulation |

## Compartmentation (Brandabschnitte)

### Maximum Compartment Areas

| Building use | Standard | With sprinkler |
|-------------|---------|----------------|
| Residential | 600 m² | 3'600 m² |
| Office | 900 m² | 5'400 m² |
| Retail | 600 m² | 3'600 m² |
| Industrial/storage | 1'200 m² | 7'200 m² |
| Underground parking | 600 m² | 3'600 m² |

*Sprinkler installation allows 6× larger compartments.*

### Compartment Boundaries
- Compartment walls: EI 60 (min), EI 90 for stairwells
- Compartment floors: REI 90 (medium-rise)
- Penetrations: seal with approved fire-stopping (classified seals)

## Escape Routes (Fluchtwege — BSR 16-15i)

### Key Rules
- Maximum escape route length: **35 m** to nearest protected stairwell (50 m with sprinkler)
- Stairwell: enclosed, EI 90 walls, self-closing EI 30 doors
- Minimum corridor width: **1.20 m** (residential), **1.80 m** (public/office)
- Minimum stairwell width: **1.20 m** (residential), **1.50 m** (assembly)
- Every floor above 2nd must have **2 independent escape routes** (medium-rise+)
- Exit doors: open in direction of escape, never sliding, never revolving (as only exit)

### Emergency Lighting
- Required where natural light insufficient for safe escape
- Duration: minimum 1 hour
- Level: minimum 1 lux at floor level along escape route

## Sprinklers (BSR 21-15i)

**Mandatory** for:
- Buildings > 30 m height (Hochhaus)
- Underground car parks > 600 m²
- Assembly halls > 600 m² with fixed seating
- High-rack storage > 7.5 m
- Certain special buildings (hospitals, care homes)

**Optional but recommended** for: large compartments, hazardous uses, isolated buildings.

## Fire Protection Documentation (Brandschutznachweis)

Required for building permit. Contents:

```
BRANDSCHUTZNACHWEIS
Projekt:    [Name, address]
Verfasser:  [Architect / fire protection specialist]
Datum:      [Date]
Norm:       VKF Brandschutznorm 2015

1. GEBÄUDEBESCHREIBUNG
   - Nutzung, Gebäudekategorie, Anzahl Geschosse
   - Bruttogeschossfläche, Brandabschnittsflächen

2. BRANDABSCHNITTE
   - Grundrissschema mit Brandabschnittsgrenzen
   - Nachweis der maximalen Flächen

3. FLUCHT- UND RETTUNGSWEGE
   - Fluchtwegplan je Geschoss
   - Nachweis der Fluchtwegslängen und -breiten
   - Treppenhausausbildung

4. BAUSTOFFE UND BAUTEILE
   - Tabelle: Bauteil / Feuerwiderstand / Brennbarkeit

5. TECHNISCHE BRANDSCHUTZMASSNAHMEN
   - Brandmeldeanlage (BMA): ja/nein, Typ
   - Sprinkleranlage: ja/nein, Norm
   - Rauch-Wärme-Abzug: ja/nein

6. ABWEICHUNGEN UND KOMPENSATIONEN
   - Falls Abweichungen von Norm: Kompensationsnachweis
```

## When to Involve a Fire Protection Specialist (Brandschutzfachmann)

- High-rise buildings (> 30 m)
- Special buildings (hospitals, schools, large assembly)
- Complex atria or open-plan layouts
- Sprinkler design (always requires specialist)
- Deviations from standard requiring approval
- Underground structures

For standard medium-rise residential/office: architect can prepare Brandschutznachweis independently.

## Cantonal Fire Insurance (Gebäudeversicherung)

- Cantonal monopoly in most cantons (GVZ in ZH, EGV in BE, etc.)
- Submit Brandschutznachweis to cantonal authority as part of permit
- Inspection during and after construction
- Non-compliance: refusal to insure = building cannot be occupied
