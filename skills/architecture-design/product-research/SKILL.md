---
name: FF&E Product Research
description: Research FF&E products for designers — captures design briefs, searches for matching products across contract and residential markets, presents curated candidates, and saves selections to a master schedule.
when_to_use: when searching for furniture, fixtures, and equipment matching a design brief; researching product alternatives; or building a product shortlist with specifications and pricing for an architecture or interior design project
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /product-research — FF&E Product Research

Automates FF&E product research for designers. Captures design briefs, searches the web for matching products, presents curated candidates with specifications, and saves selections to a master schedule.

## Usage

```
/product-research task chair, mesh back, under $800
/product-research lounge seating, healthcare, infection control
/product-research acoustic panels, Class A, 2x4 grid compatible
```

## Process

**Brief Capture**: works with what the designer provides — category, materials, dimensions, budget, lead time. Does not interview extensively; shows real options first.

**Research Strategy**: runs 3-5 targeted searches covering different angles:
- Category + material combinations
- Design-focused sources
- Contract/trade options
- Brand-specific searches
- Sustainability/certification criteria

**Presentation Format**: 6-10 genuine matches with:
- Summary table for quick comparison
- Reasoning for each match
- Honest trade-off flags (budget vs spec, lead time vs availability)

**Sheet Integration**: selected products saved to a shared Google Sheet using 33-column schema.

## Refinement Options

After initial results, request: alternatives, outdoor versions, different price point, spec sheets, or side-by-side comparisons.

## Next Steps

→ `/product-enrich` — fill gaps in product data
→ `/master-schedule` — build FF&E schedule from shortlisted products
