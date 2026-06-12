---
name: Product Spec Bulk Fetch
description: Batch-extract FF&E product data from a list of URLs into a standardized 33-column master schema.
when_to_use: when extracting furniture or product specifications from multiple URLs at once, bulk-fetching product data from manufacturer or dealer pages, or populating a master schedule from a list of product links
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /product-spec-bulk-fetch — Product Spec Bulk Fetch

Automates extraction of FF&E product data from URLs into a standardized format.

## Usage

```
/product-spec-bulk-fetch [URL list | file path | Google Sheets column]
```

## Input Methods

- **Inline list** — paste URLs directly in the message
- **File path** — provide a `.txt` or `.csv` file with URLs
- **Google Sheets column** — provide sheet ID and column reference

## Processing Workflow

1. **Parse input** — identify and count all URLs
2. **Parallel fetching** — process up to 5 URLs simultaneously via WebFetch
3. **Compile results** — categorize outcomes as successful, partial, or failed
4. **Present findings** — display markdown summary with flagged issues
5. **Output format selection** — offer Google Sheets, CSV, or conversation table
6. **Save data** — write to chosen destination using 33-column master schema

## Extracted Fields

Name, brand, category, dimensions (W/D/H), material, finish, color, price, lead time, availability, SKU, image URL, product URL, and 9 additional schema columns.

Failed URLs are logged with reasons rather than halting the batch. Status marked as "saved", source as "bulk-fetch".

## Next Steps

→ `/product-data-cleanup` — normalize messy extracted values
→ `/product-enrich` — auto-tag categories, colors, materials
→ `/master-schedule` — add to project product library
