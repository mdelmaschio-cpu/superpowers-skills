---
name: NPK Leistungsverzeichnis
description: Write Swiss bills of quantities using the NPK/CAN standard — position structure, work descriptions per NPK chapter, unit quantities, and output for tendering in Swiss format.
when_to_use: when writing a Leistungsverzeichnis (LV) for a Swiss construction tender, structuring work descriptions according to NPK chapters, preparing tender documents for a Swiss building project, or converting a scope of work into measurable NPK positions — oppure quando si redige un Leistungsverzeichnis (LV) per una gara d'appalto svizzera, si strutturano le descrizioni delle lavorazioni secondo i capitoli NPK, si preparano documenti di gara per un progetto edilizio svizzero, o si converte un capitolato in posizioni NPK misurabili
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Write
---

# /npk-leistungsverzeichnis — Swiss NPK Bill of Quantities

The **NPK** (Normpositionenkatalog) / **CAN** (Catalogue suisse des positions-types) / **CPN** (Catalogo svizzero delle posizioni-tipo) is the Swiss standard reference for construction work descriptions, published by the Swiss construction industry (KBOB/Baukostendaten).

## Structure of an NPK Leistungsverzeichnis

### Position Anatomy

```
[Pos. Nr.]  [NPK Chapter]-[Section]-[Position]
            [Work description — German standard text]
            Einheit: [Unit]   Menge: [Quantity]   EP: [Unit price CHF]   GP: [Total CHF]

Example:
Pos. 01     NPK 661.11.01
            Beton C25/30, Konsistenz F3, Expositionsklasse XC2
            Liefern und einbauen inkl. Verdichten
            m³     45.00     [EP]     [GP]
```

### LV Document Structure

```
LEISTUNGSVERZEICHNIS
Projekt:    [Project name and address]
Unternehmer: [Contractor — blank for tender]
Datum:       [Date]
Bearbeiter:  [Architect/engineer name]

TEIL 1 — ALLGEMEINE BESTIMMUNGEN
  1.1 Geltende Normen und Vorschriften
  1.2 Qualitätsanforderungen
  1.3 Termine
  1.4 Zahlungsbedingungen

TEIL 2 — BAUBESCHREIBUNG
  [Summary of construction work]

TEIL 3 — POSITIONEN (per NPK chapter)
  Kapitel [XX]: [NPK Chapter name]
    Pos. [Nr.] — [Description] — [Unit] — [Qty] — [EP] — [GP]
  TOTAL Kapitel [XX]:

ZUSAMMENFASSUNG
  Kapitel [XX]: CHF [total]
  ...
  TOTAL exkl. MWST: CHF
  MWST 8.1%:        CHF
  TOTAL inkl. MWST: CHF
```

## NPK Chapters — Key Reference

| NPK | Chapter (DE) | Chapter (IT) | Typical work |
|-----|-------------|-------------|-------------|
| **101** | Abbruch, Rückbau | Demolizioni | Demolition, deconstruction |
| **111** | Baugrubensicherung | Sostegno scavo | Shoring, retaining |
| **121** | Erdarbeiten | Scavi | Earthworks, excavation |
| **211** | Beton | Calcestruzzo | In-situ concrete |
| **212** | Betonfertigteile | Prefabbricati | Precast concrete |
| **221** | Mauerwerk | Muratura | Masonry |
| **241** | Zimmerarbeiten | Carpenteria | Timber framing |
| **251** | Dachdeckungen | Coperture | Roofing |
| **261** | Abdichtungen | Impermeabilizzazioni | Waterproofing |
| **271** | Wärmedämmungen | Isolazioni termiche | Thermal insulation |
| **281** | Putzarbeiten | Intonaci | Plastering |
| **291** | Flachdach | Tetto piano | Flat roof |
| **311** | Fenster, Türen | Finestre, porte | Windows and doors |
| **321** | Metallbau | Costruzioni metalliche | Metalwork |
| **331** | Schreinerarbeiten | Falegnami | Joinery, interior doors |
| **341** | Bodenbeläge | Pavimenti | Floor finishes |
| **351** | Wandbeläge | Rivestimenti | Wall finishes |
| **361** | Malerarbeiten | Pitture | Painting |
| **371** | Glaserarbeiten | Vetri | Glazing |
| **411** | Sanitäranlagen | Impianti sanitari | Plumbing |
| **421** | Heizungsanlagen | Impianti riscaldamento | Heating |
| **431** | Lüftungsanlagen | Impianti ventilazione | Ventilation/HVAC |
| **441** | Elektroanlagen | Impianti elettrici | Electrical |
| **451** | Aufzüge | Ascensori | Lifts |
| **661** | Betonarbeiten (Tiefbau) | — | Civil/structural concrete |

## Position Writing Rules

### Mandatory Elements per Position
1. **NPK reference number** (where applicable)
2. **Material specification**: standard (e.g., SIA, EN, DIN) + grade/class
3. **Execution method** if relevant (hand-placed, pumped, etc.)
4. **Surface treatment** (exposed, painted, tiled)
5. **Unit** (m, m², m³, kg, Stk/pce, psch/fft)
6. **Quantity** (measured from plans per agreed measurement rules)

### Measurement Rules (Abrechnungsregeln)
- Follow NPK chapter rules for what is included/excluded
- Openings in masonry: deduct if >0.5 m² (NPK 221)
- Concrete: measure theoretical volume (no deduction for reinforcement)
- Paint: measure surface net of openings >0.5 m²

### Position Types
- **Normalposition**: standard measured work
- **Pauschalposition (psch)**: lump sum — specify scope exactly
- **Regieposition**: day-work rate — use sparingly, specify rate basis
- **Eventualposition**: contingency — client authorizes execution separately

## Typical LV Workflow

1. **Extract quantities** from plans (AutoCAD/Revit measurement or manual)
2. **Match to NPK chapter** per work type
3. **Write position text** using NPK standard descriptions (adapt as needed)
4. **Assign units and quantities**
5. **Leave EP/GP blank** for contractor to fill (tendering)
6. **Issue with Submission documents** (Submissionsunterlagen)
7. **After tender**: compare EP unit prices across bidders for anomalies

## Common Errors to Avoid

- Vague descriptions ("Mauerwerk nach Angaben des Architekten") — always specify material and standard
- Missing execution tolerances — reference SIA 118 Anhang for tolerances by work type
- Pauschalposition without scope description — leads to disputes
- Mixing metric and imperial — Switzerland is strictly metric
- Missing exclusions — state what is NOT included if ambiguous

## Software

- **SORBA** (most common Swiss LV software)
- **ORCA AVA** (used in CH and DE)
- **Messerli Informatik** (BauPlus)
- Export formats: GAEB DA-XML (standard exchange format)
