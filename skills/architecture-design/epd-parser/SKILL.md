---
name: EPD Parser
description: Extract environmental product declaration data from PDF files into a standardized 42-column schema covering GWP, ODP, AP, EP, POCP, and resource use metrics.
when_to_use: when parsing Environmental Product Declaration PDFs to extract life cycle impact data, processing EPDs for LEED documentation, or building a materials database with environmental impact metrics from multiple EPDs — oppure quando si analizzano PDF di Dichiarazioni Ambientali di Prodotto (EPD) per estrarre dati LCA, si elaborano EPD per la documentazione LEED, o si costruisce un database materiali con metriche di impatto ambientale
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /epd-parser — EPD Data Extractor

Extracts environmental product declaration data from PDF files into a standardized 42-column schema. Processes ISO 14025/21930/EN 15804-compliant building product environmental impact documentation.

## Usage

```
/epd-parser path/to/epd.pdf
/epd-parser path/to/epd-folder/
```

## 42-Column Output Schema

- **Product identity**: manufacturer, name, declared/functional units, CSI division
- **EPD metadata**: registration number, program operator, validity dates, standards
- **Impact indicators**: GWP (fossil/biogenic split for EN 15804+A2), ODP, AP, EP, POCP
- **Resource use**: primary energy, water consumption, waste, recycled content
- **Tracking**: LEED eligibility, manufacturing location, parsing timestamp

## Core Workflow

1. **Acquire input** — PDF file paths or folder location
2. **Extract text** — isolate page content using PyMuPDF
3. **Parse tables** — identify impact indicator tables; extract numeric values by life cycle stage (A1–D)
4. **Present summary** — show extracted data with verification request
5. **Write output** — save to Google Sheet, local CSV, or markdown

## Parsing Intelligence

- Distinguishes EN 15804+A1 (single GWP) from +A2 (fossil/biogenic split)
- Maps non-standard units to schema standards
- Handles chunked processing for PDFs >30 pages
- Leaves fields blank rather than inferring missing data

## Edge Cases

Flags with explanatory notes: scanned PDFs, password-protected files, image-embedded tables, non-English documents, expired certifications. Multi-product EPDs create separate rows per variant.
