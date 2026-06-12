---
name: Product Pair
description: Suggest 5-8 complementary products that work well with a source item based on design principles, materials, scale, and price alignment.
when_to_use: when completing a room package around an anchor piece, finding complementary furniture for a sofa or desk, or building a cohesive FF&E palette around a hero product
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /product-pair — Product Pair

Identifies complementary products that work well with a source item, grounded in design principles.

## Usage

```
/product-pair [product name | name + context | detailed specification]
/product-pair Knoll Saarinen tulip table, residential dining room
```

## Process

1. **Accept input** — product name alone, name with context, or full specifications
2. **Analyze design DNA** — style language, materials, color family, scale, price tier, market segment
3. **Determine pairing categories** based on source type:
   - Sofa → coffee tables, side tables, floor lamps, throw pillows, rugs, ottomans
   - Task chair → desk, monitor arm, task light, floor mat
4. **Search per category** — find products matching style, materials, color, scale, price
5. **Present 5-8 pairings** with design reasoning (material harmony, color logic, scale, style coherence)

## Design Principles Applied

- Mix brands; avoid matching sets
- Include intentional contrast pieces
- Maintain price proportionality
- Note contract-grade availability when relevant

Selected pairings saved to master Google Sheet with tags tracking source/paired relationships.

## Related Skills

→ `/product-match` — find alternatives to a specific product
→ `/master-schedule` — build complete room packages
