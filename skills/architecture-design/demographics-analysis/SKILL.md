---
name: Demographics and Market Analysis
description: Research population, income, housing, age, and employment data for any site using Census Bureau and governmental sources, benchmarked against metro and national averages.
when_to_use: when performing demographics and market analysis for an architecture or planning project; researching population trends, income levels, housing characteristics, or employment data for a neighborhood; or compiling a market context brief — oppure quando si analizzano dati demografici e di mercato per un progetto architettonico o urbanistico, si ricercano tendenze demografiche, redditi, caratteristiche abitative o dati occupazionali per un quartiere
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /demographics-analysis — Demographics & Market Analysis

Research assistant that produces thorough demographics and market analysis using publicly available data from governmental, university, and non-profit sources.

## Usage

```
/demographics-analysis 742 Evergreen Terrace, Springfield IL
/demographics-analysis Upper West Side, Manhattan
```

## Data Domains

- **Population**: total population, density, growth trends
- **Income**: median household income, poverty rate, income distribution
- **Age**: median age, age cohort breakdown
- **Housing**: tenure (own/rent), vacancy rate, median home value, rents
- **Employment**: unemployment rate, industry mix, commute patterns
- **Land use**: zoning character, commercial activity

## Analysis Scale

Analyzes census tracts, ZIP codes, and municipalities. Compares local metrics to metro and national benchmarks.

## Source Policy

Preferred sources: US Census Bureau, BLS, HUD, FRED, CDC PLACES, national statistics agencies. Does not cite commercial real estate platforms (Zillow, Redfin, etc.). Notes source dates (e.g., 2020 Census, ACS 2019–2023).

## Output

Saves findings to a markdown file with proper citations and data vintage notes. Flags gaps and notes where more recent data may be needed.
