---
name: NYC BSA Variances Lookup
description: Look up Board of Standards and Appeals variances and special permits for any NYC property — covers records from 1998 to present.
when_to_use: when checking whether a NYC property has approved zoning variances, special permits, or BSA relief that may affect future development proposals; performing due diligence on properties with unusual development histories — oppure quando si verifica se una proprietà a NYC ha varianze urbanistiche approvate, permessi speciali o esenzioni BSA che potrebbero influenzare futuri sviluppi
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /nyc-bsa — BSA Variances & Special Permits

Look up Board of Standards and Appeals applications, variances, and special permits for any NYC property. Records from 1998 to present. No API key required.

## Usage

```
/nyc-bsa 120 Broadway, Manhattan
/nyc-bsa 1000770001          (BBL)
```

## Workflow

**Step 1: Parse input** — address, BBL, or BIN. Borough codes: Manhattan=1/MN, Bronx=2/BX, Brooklyn=3/BK, Queens=4/QN, Staten Island=5/SI.

**Step 2: Resolve via PLUTO** — query NYC's public property database to retrieve BBL, BIN, zoning district, building class, and ownership details.

**Step 3: Query BSA Applications** — fetch all associated variances and special permits using the resolved BBL, ordered by date descending.

**Step 4: Present results** in a markdown table:

```markdown
## BSA Records — {Address}

| Application # | Section | Status | Date | Description |
|--------------|---------|--------|------|-------------|
| ... | ZR 72-21 | Approved | ... | Variance for FAR | 
```

**Important**: approved variances remain with the land and may affect future development proposals. Note variance conditions explicitly.

If no records: "No BSA applications found for this property."
