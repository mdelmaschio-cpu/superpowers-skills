---
name: Product Spec PDF Parser
description: Extract structured FF&E product data from PDF price books, fact sheets, and spec sheets into the 33-column master schema.
when_to_use: when extracting product specifications from PDF catalogs, price books, manufacturer fact sheets, or multi-page spec sheets for furniture or fixtures — oppure quando si estraggono specifiche prodotto da cataloghi PDF, listini prezzi, schede tecniche produttore, o schede specifiche multipagina per arredamenti o fixtures
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Write
  - Bash
---

# /product-spec-pdf-parser — Product Spec PDF Parser

Extracts structured FF&E data from PDF documents — price books, fact sheets, and spec sheets — using PyMuPDF for text extraction and Claude reasoning to standardize varying layouts.

## Usage

```
/product-spec-pdf-parser [PDF path | folder path]
```

Processes all `.pdf` files found. Prompts for files if no path provided.

## Output Options

- **Google Sheets** — master library (default)
- **Local CSV** — saved to working directory
- **Markdown** — conversation table

Variant depth: `expand` (one row per SKU/variant, default) or `summarize` (comma-separated variants per row).

## Variant Handling by PDF Type

| PDF Type | Row Strategy |
|----------|-------------|
| Fact sheets with SKUs | One row per option (shade × color) |
| Upholstery configurators | One row per fabric; frame finishes in dedicated field |
| Price books | One row per product type + base price + adder fields |
| Large documents | 10-page chunks with deduplication |

## Special Cases

- Scanned PDFs, password protection, multi-language: flagged with user notification
- PDF-specific metadata (variant details, price adders, source filename) → Notes column with pipe delimiters

## Next Steps

→ `/product-data-cleanup` — normalize extracted values
→ `/product-enrich` — auto-tag categories and style
