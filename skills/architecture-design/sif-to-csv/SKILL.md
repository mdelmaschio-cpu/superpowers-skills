---
name: SIF to CSV
description: Convert a SIF file from a dealer or procurement system into a clean, human-readable CSV or Google Sheet.
when_to_use: when receiving a SIF file from a dealer or procurement system and needing to convert it to a spreadsheet for review, pricing analysis, or schedule integration
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /sif-to-csv — SIF to CSV Converter

Transforms dealer SIF (Standard Interchange Format) files into readable spreadsheets.

## Usage

```
/sif-to-csv [SIF file path | pasted SIF content]
```

## What It Does

- Parses text-based key-value SIF records (CODE=VALUE format)
- Expands manufacturer codes (e.g., HMI → Herman Miller)
- Calculates derived pricing: sell price, extended totals, discounts
- Handles multiple quantity, price, and option field variants
- Concatenates options/attributes into readable columns

## Input

SIF file path or pasted content. Product records marked by `PN=` fields.

## Output Options

1. **CSV file** — ~18 columns, saved to working directory
2. **Google Sheet** — uses 33-column master schema
3. **Markdown preview** — conversation table with summary statistics

## Summary Statistics

- Total record count
- Manufacturers represented
- Total list value
- Total sell value (if discount applied)

## Related Skills

→ `/csv-to-sif` — reverse: export schedule to dealer format
→ `/product-data-import` — integrate converted data into project schedule
