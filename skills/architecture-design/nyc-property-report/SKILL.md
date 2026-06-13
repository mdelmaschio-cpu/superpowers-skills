---
name: NYC Property Report
description: Comprehensive property research report across six NYC data domains — landmarks, DOB permits, violations, ACRIS transactions, HPD housing data, and BSA variances.
when_to_use: when performing complete due diligence on a NYC property for architecture or real estate; needing a single comprehensive report covering all public data about a building; or starting an architecture project and needing a full property data briefing — oppure quando si esegue una due diligence completa su una proprietà a NYC, si ha bisogno di un report comprensivo che copra tutti i dati pubblici di un edificio, o si avvia un progetto architettonico a New York
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /nyc-property-report — Comprehensive NYC Property Report

Conducts comprehensive property research across six NYC data domains using publicly available NYC Open Data (Socrata) APIs. No authentication required.

## Usage

```
/nyc-property-report 120 Broadway, Manhattan
/nyc-property-report 1000770001          (BBL)
```

## Six Data Domains

1. **Landmarks** — LPC designations and historic districts (`/nyc-landmarks`)
2. **DOB Permits & Filings** — Construction permits from legacy and DOB NOW systems (`/nyc-dob-permits`)
3. **DOB Violations** — Building code violations and ECB penalties (`/nyc-dob-violations`)
4. **ACRIS** — Property transaction records, deeds, and mortgages (`/nyc-acris`)
5. **HPD** — Housing violations, complaints, and registrations (residential only) (`/nyc-hpd`)
6. **BSA** — Board of Standards and Appeals variances (`/nyc-bsa`)

## Process

**Input parsing**: converts addresses to BBL via PLUTO, normalizes borough names, handles unit/apt stripping.

**Data retrieval**: queries six Socrata endpoints; continues if individual queries fail.

**Report generation**: creates markdown file `property-{address-slug}.md` with tables organized by domain, flagging open violations with ⚠ symbols.

**Project integration**: if `PROJECT.md` exists, updates its Identity and Zoning sections with current findings before appending.

## Important Constraints

- HPD applies only to residential building classes (A, B, C, D, R, S)
- ACRIS requires BBL; cannot use BIN alone
- DOB legacy datasets use `bin__` (double underscore); DOB NOW uses `bin`
- Rate limits: retry once after 5-second wait if HTTP 429 received
- All findings include source and date; data currency varies by dataset

## Output

Creates a file `property-{address-slug}.md` with sections for each data domain, plus a summary section at the top with key flags (landmark status, open violations, recent transactions).
