---
name: Product Match
description: Find similar products to a given item by name, image, description, or URL — scored for visual, material, price, and dimension similarity.
when_to_use: when looking for alternatives to a specific product, finding budget versions of a high-end item, or sourcing contract-grade equivalents of residential furniture
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /product-match — Product Match

Finds similar products by name, image, description, or URL using multi-angle search and a scoring system.

## Usage

```
/product-match [product name | image | description | URL]
/product-match Eames Lounge Chair, under $3000
/product-match [image] find contract-grade alternatives
```

## Process

1. **Accept input** — name, image, description, URL, budget constraints
2. **Extract source attributes** — dimensions, materials, price, style period, visual character
3. **Multi-angle search** — 3-5 searches covering: direct alternatives, category + style, price range, material specs, trade/contract sources
4. **Score candidates** on 15-point scale:
   - Visual similarity (0-5)
   - Material match (0-3)
   - Price proximity (0-3)
   - Dimension match (0-2)
   - Availability (0-2)
5. **Present results** — comparison table first, then ranked matches with trade-off reasoning

## Output

6-10 genuine matches with reasoning. Saves selections to Google Sheets (33-column schema) with source tag and match reasoning.

## Related Skills

→ `/product-research` — brief-based discovery
→ `/product-enrich` — categorization for better matching
→ `/product-pair` — find complementary items
