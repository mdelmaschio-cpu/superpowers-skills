---
name: Product Data Import
description: Convert raw product notes, CSVs, or pasted lists into a structured FF&E schedule compatible with the 33-column master schema.
when_to_use: when importing unstructured product information into a schedule, converting notes or lists into a formatted FF&E table, or building a new schedule from scratch from raw designer input — oppure quando si importano informazioni prodotto non strutturate in un computo, si convertono note o liste in una tabella FF&E formattata, o si costruisce un nuovo computo da zero
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /product-data-import — Product Data Importer

Converts unstructured product information into formatted FF&E specification schedules compatible with the 33-column master schema.

## Usage

```
/product-data-import [notes | CSV | pasted list | conversational description]
```

Accepts any format — no reformatting required from the designer.

## What It Does

**Data enrichment:** Known products are populated with reference specs (dimensions, materials, weight). Unknown items are flagged as "TBD — needs specification" with budget ranges noted.

**Output format:** Markdown tables grouped by category (Seating, Tables, Lighting, etc.) with subtotals and grand total.

**Item numbering:** Category prefixes — S for Seating, T for Tables, L for Lighting, etc.

## Storage Options

- Markdown in conversation
- CSV file saved locally
- Google Sheet using 33-column schema (quantity and extended pricing in Notes columns)

## TBD Items

Items without sufficient specification trigger optional research via `/product-research`.

## Next Steps

→ `/product-spec-bulk-fetch` — bulk-fetch specs from product URLs
→ `/csv-to-sif` — convert to dealer procurement format
→ `/master-schedule` — connect to project product library
