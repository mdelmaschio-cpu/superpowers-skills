---
name: EPD Research Agent
description: Search for Environmental Product Declarations across registries and manufacturer websites, presenting candidates sorted by Global Warming Potential and saving to a standardized spreadsheet.
when_to_use: when searching for EPDs for specific building materials, comparing environmental impact of alternative products by GWP, or finding EPDs for LEED MRc2 documentation — oppure quando si cercano EPD per materiali da costruzione specifici, si confronta l'impatto ambientale di prodotti alternativi per GWP, o si trovano EPD per la documentazione LEED MRc2
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /epd-research — EPD Research Agent

Searches for Environmental Product Declarations by querying registries and manufacturer websites, then presents candidates sorted by Global Warming Potential (GWP).

## Usage

```
/epd-research concrete mix, Portland cement, minimum 30% SCM
/epd-research low-GWP structural steel
```

## Sources Searched

- **Program operators**: UL, NSF International, SCS Global Services, ASTM
- **International registries**: Environdec, IBU (Institut Bauen und Umwelt)
- **Manufacturer sustainability pages**: direct corporate EPD publications

Note: Building Transparency/EC3 requires authenticated API access and cannot be reached via standard web search.

## Results Format

6-12 candidates sorted by GWP (lowest first), each showing:
- Product name and manufacturer
- GWP (A1-A3) per declared unit
- Declared unit and system boundary
- Program operator and registration number
- Validity dates and location
- LEED eligibility status
- "Why" explanation for relevance
- PDF link where available

## Refinement Options

After initial results, request: lower-GWP variants, related product categories, comparative analysis, specification language, or full PDF parsing via `/epd-parser`.

## Next Steps

→ `/epd-parser` — extract detailed data from selected EPD PDFs
→ `/epd-compare` — compare multiple products side-by-side
→ `/epd-to-spec` — convert EPD data into specification language
