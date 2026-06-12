---
name: CSV to SIF
description: Convert a product list from CSV, Excel, or Google Sheets into a SIF (Standard Interchange Format) file for dealer and procurement systems.
when_to_use: when exporting an FF&E schedule to a dealer system like Hedberg, CAP, Cyncly Worksheet, CET/Configura, or Design Manager
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /csv-to-sif — CSV to SIF Converter

Converts product lists from CSV, Excel, or Google Sheets into SIF files for dealer and procurement systems.

## Usage

```
/csv-to-sif [CSV file | Google Sheet ID | pasted data]
```

## Workflow

1. **Accept input** — CSV file, spreadsheet ID, or pasted data
2. **Choose target system** — Standard, CET/Configura, Cyncly, or Design Manager
3. **Map columns** — auto-detect or manually confirm field mappings
4. **Preview** — show first 3 records before generation
5. **Generate** — write `.sif` file with CRLF line endings
6. **Summary** — display record count, manufacturers, and total value

## Core SIF Fields

| Field | Description |
|-------|-------------|
| **PN** | Product Number / SKU — starts each record |
| **PD** | Product Description |
| **MC** | Manufacturer Code (3-5 chars, e.g., HMI for Herman Miller) |
| **QT** | Quantity (integer) |

Optional: pricing (PL, P1-P5), attributes (AN/AD pairs), options (ON/OD), location tags (TG), URLs.

## System Differences

- **Standard**: MC, PL, QT
- **Cyncly Worksheet**: MG/MN, I1/I2, PRC
- **CET/Configura**: EC code variant
- **Design Manager**: adds DXSC, DXBD, DXLN extensions

Brand-to-code lookup included (e.g., "Knoll" → KNL, "Herman Miller" → HMI).

## Related Skills

→ `/sif-to-csv` — reverse conversion from dealer format
