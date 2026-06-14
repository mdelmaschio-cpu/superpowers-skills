---
name: SIA 102 Fee Calculation
description: Calculate architect's fees per SIA 102 — building category, difficulty level, phase percentages, and total honorarium from BKP 2 construction cost.
when_to_use: when calculating architect's fees for a Swiss project per SIA 102, preparing a fee proposal for a client, checking whether a proposed fee is within SIA 102 norms, breaking down fees by phase, or explaining the fee basis to a client — oppure quando si calcolano gli onorari dell'architetto per un progetto svizzero secondo SIA 102, si prepara un'offerta di onorario per un cliente, si verifica se un onorario proposto è conforme alle norme SIA 102, si suddividono gli onorari per fase, o si spiega la base degli onorari a un cliente
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Write
---

# /sia-102-honorar — SIA 102 Architect's Fee Calculation

SIA 102 (2014 edition) defines how architect's fees are calculated in Switzerland. The system is based on **construction cost × fee rate**, where the rate depends on building category and complexity.

## Step 1 — Determine the Fee Basis (Honorargrundlage)

The fee is calculated on **BKP 2** (Gebäude — building works) excluding VAT.

**Exclude from fee basis:**
- BKP 0 (land)
- BKP 1 (site preparation)
- BKP 4 (landscaping)
- BKP 5 (ancillary costs — including design fees themselves)
- BKP 9 (furnishings)

## Step 2 — Assign Building Category (Gebäudekategorie)

SIA 102 defines 5 building categories:

| Category | Building types |
|----------|---------------|
| **I** | Simple utility buildings, agricultural, basic industrial |
| **II** | Standard residential, simple commercial, standard office |
| **III** | Quality residential, schools, standard hotels, offices |
| **IV** | Complex buildings: hospitals, theatres, museums, laboratories |
| **V** | Exceptional architecture, highly complex technical programs |

*Most new residential and office projects: Category II or III.*

## Step 3 — Assign Difficulty Level (Schwierigkeitsgrad n)

Within each category, a difficulty factor n adjusts the fee:

| Difficulty | n value | Typical situation |
|------------|---------|-------------------|
| Basic | 0.90–0.95 | Repetitive, standard, prototype-based |
| Standard | **1.00** | Typical project of its type |
| Complex | 1.05–1.15 | Unusual site, complex brief, high quality |
| Exceptional | 1.20–1.40 | Landmark, very high complexity |

## Step 4 — Read the Fee Table (Appendix C, SIA 102)

The base fee rate (in %) is read from the SIA 102 table based on:
- Building category (I–V)
- Construction cost (BKP 2)

**Illustrative rates** (approximate — always verify against current SIA 102 table):

| BKP 2 (CHF) | Category II | Category III | Category IV |
|-------------|------------|-------------|------------|
| 500'000 | 17.0% | 20.0% | 25.0% |
| 1'000'000 | 14.5% | 17.5% | 22.0% |
| 2'000'000 | 12.5% | 15.0% | 19.5% |
| 5'000'000 | 10.5% | 13.0% | 17.0% |
| 10'000'000 | 9.0% | 11.5% | 15.0% |
| 20'000'000 | 8.0% | 10.0% | 13.5% |
| 50'000'000 | 7.0% | 8.5% | 12.0% |

*Rates decrease as construction cost increases (degressive scale). These are indicative — purchase current SIA 102.*

## Step 5 — Calculate Total Fee

```
Total Honorar = BKP 2 × Table Rate × Difficulty n

Example:
BKP 2:              CHF 3'500'000
Category:           III (quality residential)
Table rate at 3.5M: ~14.0%
Difficulty n:       1.05 (complex site)

Total Honorar = 3'500'000 × 14.0% × 1.05
             = CHF 514'500 (excl. VAT)
```

## Step 6 — Phase Distribution

SIA 102 recommends distributing the total fee across phases:

| Phase | % of total honorar |
|-------|-------------------|
| Strategische Planung (SP) | 1–3% |
| Vorstudien (VS) | 6% |
| Vorprojekt (VP) | 14% |
| Bauprojekt (BP) | 22% |
| Ausschreibung (AS) | 7% |
| Realisierung — Bauleitung (RL) | 38% |
| Abschluss | 4% |
| Reserve | ~8% |

*Distribute per project emphasis — phases with more work get higher allocation.*

**Example with CHF 514'500 total:**
| Phase | % | Fee CHF |
|-------|---|---------|
| VS | 6% | 30'870 |
| VP | 14% | 72'030 |
| BP | 22% | 113'190 |
| AS | 7% | 36'015 |
| RL | 38% | 195'510 |
| Abschluss | 4% | 20'580 |
| Reserve | 9% | 46'305 |
| **Total** | **100%** | **514'500** |

## Invoicing and Payment

- Invoice per phase upon completion or monthly during extended phases
- All fees **excl. MWST** (8.1% added on invoice)
- Expenses (Spesen): separate, at cost or as lump sum (typically 5–8% of fee)
- Reimbursables: printing, models, travel — agree upfront

## Additional Services (Besondere Leistungen)

Work not included in standard SIA 102 scope — invoiced separately:

- Feasibility studies / competition entries
- Interior design (separate SIA 108 mandate)
- Project management (SIA 102 §4.4)
- Expert witness / dispute support
- Specialized energy consulting
- Signage and wayfinding design

## Fee Agreement — What to Include in the Mandatsvertrag

```
HONORARVEREINBARUNG (per SIA 102)

Berechnungsbasis: BKP 2 = CHF [amount] (Kostenschätzung [phase], ±X%)
Gebäudekategorie: [I/II/III/IV/V]
Schwierigkeitsgrad n: [value]
Honorarsatz: [%]
Basis-Honorar: CHF [amount]

Phaseneinteilung: [table of phases and amounts]

Anpassung: Honorar wird angepasst, wenn BKP 2 Kostenstand mehr als ±10%
           von obiger Berechnungsbasis abweicht.

Spesen: [lump sum or at cost, specify]
Besondere Leistungen: [list if any, with separate fees]
MWST: 8.1% zusätzlich auf alle Honorare

Zahlungsbedingungen: 30 Tage netto
```

## Frequent Client Questions

**"Can we cap the fee at a fixed amount?"**
Yes — lump sum (Pauschalhonorar) possible, but ensure scope is precisely defined. Any additional services are extras.

**"Why does the rate decrease for larger projects?"**
Degressive scale: larger projects have economies of scale in documentation and management.

**"We found a cheaper architect — can you match?"**
Architects may discount from SIA 102 rates, but discounts > 10–15% often signal quality compromise or scope reduction.
