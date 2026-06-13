---
name: EPD Comparator
description: Compare 2+ building products side-by-side on environmental impact metrics — normalizes declared units, checks system boundary alignment, and flags LEED MRc2 compliance.
when_to_use: when comparing environmental impact of alternative building products using EPD data, evaluating products for LEED MRc2 compliance, or selecting between competing materials based on GWP and other impact indicators — oppure quando si confronta l'impatto ambientale di prodotti edilizi alternativi con dati EPD, si valutano prodotti per LEED MRc2, o si sceglie tra materiali in base al GWP e carbon embodied
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Write
---

# /epd-compare — EPD Comparator

Evaluates multiple products' environmental declarations by validating comparability, normalizing units, aligning system boundaries, and generating structured comparison reports with percentage deltas and LEED eligibility assessments.

## Usage

```
/epd-compare [product A] vs [product B]
/epd-compare sheet rows 3, 7, 12
```

## Validation Protocol (5 checks before comparing)

1. **Declared unit alignment** — confirms identical units; flags incompatibility and suggests normalization (kg ↔ ton, m² conversions)
2. **System boundary alignment** — notes cradle-to-gate vs cradle-to-grave differences
3. **PCR alignment** — identifies methodology divergence
4. **EN 15804 version** — flags +A1 vs +A2 variants
5. **Validity and EPD type** — checks expiration dates; distinguishes product-specific from industry-average

## Output

**Side-by-side impact table** with best-performing values bolded, percentage comparison relative to highest-impact product, and LEED v4.1 MRc2 assessment.

**GWP (A1-A3) is the primary comparison metric.** Missing data receives `—` placeholders rather than estimates. No hardcoded industry baselines — user must provide or run `/epd-research`.

**Recommendation summary**: direct guidance on which product performs better and under what conditions.

## LEED MRc2 Assessment

Covers Option 1 (EPD disclosure) and Option 2 (embodied carbon optimization), including product logging requirements for documentation.
