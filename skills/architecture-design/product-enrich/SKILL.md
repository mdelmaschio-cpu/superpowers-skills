---
name: Product Enrich
description: Auto-tag furniture products with category, subcategory, primary color, material, and style descriptors using AI inference.
when_to_use: when a product list lacks category tags, color data, material descriptions, or style classifications needed for filtering, scheduling, or presentation — oppure quando una lista prodotti manca di categorie, dati colore, descrizioni materiali o classificazioni stilistiche necessarie per filtraggio, schedulazione o presentazione
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /product-enrich — Product Enrichment

Automatically tags furniture products with metadata including categories, colors, materials, and style descriptors.

## Usage

```
/product-enrich [Google Sheet ID | CSV file | pasted product list]
```

## Enrichment Fields

For each product, infers:

| Field | Detail |
|-------|--------|
| **Category** | Maps to 22-term standardized vocabulary |
| **Subcategory** | Specific type (e.g., "Task Chair" within Chair) |
| **Primary Color** | Dominant color by standard name (Walnut, Navy, Chrome) |
| **Material** | Primary materials with specifics (wood type, metal finish) |
| **Style Tags** | 2-4 tags: period, characteristics, context |

## Workflow

1. Load products from input source
2. Infer attributes for each product
3. **Preview** enriched data for user approval
4. Flag uncertain products for review
5. On approval, write enriched fields to Google Sheet columns or CSV

## Integration

→ `/product-spec-bulk-fetch` — gather initial data first
→ `/product-match` — enriched tags improve similarity search accuracy
→ `/master-schedule` — ensures enriched data lands in the right sheet
