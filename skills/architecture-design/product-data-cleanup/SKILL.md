---
name: Product Data Cleanup
description: Normalize messy FF&E schedules — standardize casing, dimensions, units, languages, materials, and formatting.
when_to_use: when an FF&E schedule has inconsistent casing, mixed units, merged dimension columns, non-English category names, abbreviated material terms, or duplicate entries that need normalization before use — oppure quando un computo FF&E ha nomenclatura inconsistente, unità miste, colonne dimensioni combinate, abbreviazioni materiali, o duplicati da normalizzare
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /product-data-cleanup — Product Data Cleanup

Normalizes messy FF&E schedules into clean, consistent data compatible with the 33-column master schema.

## Usage

```
/product-data-cleanup [Google Sheet ID | CSV/TSV/XLSX file | pasted table]
```

## Normalization Scope

- **Casing**: product names/brands/categories → Title Case; materials → Sentence case
- **Category mapping**: maps free-text entries to canonical 22-term vocabulary
- **Dimension splitting**: combined formats (e.g. "24W × 30D × 36H") → separate W/D/H columns with units
- **Language translation**: Spanish → English for categories, materials, colors
- **Material standardization**: "SS" → "Stainless steel", "Ply" → "Molded plywood"
- **Currency cleanup**: removes symbols, detects locale formatting, flags non-prices
- **Duplicate detection**: flags identical Product Name + Brand or URL combinations (no auto-delete)

## Workflow

1. **Load** schedule and map columns to standard schema
2. **Analyze** and preview cleanup needs
3. **Confirm scope** — apply all fixes or select specific ones
4. **Apply fixes** while tracking changes made
5. **Present before/after samples** plus full cleaned table
6. **Save** to original file, new file, Google Sheet, or conversation

Preserves original units (no conversion). Flags ambiguous values with `[?]` for user review.
