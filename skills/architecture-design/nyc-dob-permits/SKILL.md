---
name: NYC DOB Permits Lookup
description: Search Department of Buildings permit and job filing records for any NYC property using address, BBL, or BIN.
when_to_use: when researching construction permits, job filings, and building alteration history for a NYC property; understanding what work has been done on a building; or performing due diligence on a NYC real estate or architecture project
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /nyc-dob-permits — DOB Permit & Filing History

Search Department of Buildings permit and job filing records for any NYC property. No API key required.

## Usage

```
/nyc-dob-permits 120 Broadway, Manhattan
/nyc-dob-permits 1000770001          (BBL)
/nyc-dob-permits 1001389             (BIN)
```

## Step 1: Input Parsing

Accept addresses with borough/zip, BBL, or BIN identifiers. Borough codes: Manhattan=1/MN, Bronx=2/BX, Brooklyn=3/BK, Queens=4/QN, Staten Island=5/SI.

## Step 2: PLUTO Resolution

Query NYC's PLUTO dataset to retrieve BBL, BIN, and building metadata including class, zoning, construction year, owner, floors, and lot dimensions.

## Step 3: Multi-Source DOB Queries

Search four datasets:
- Legacy Permit Issuance
- Legacy Job Filings
- DOB NOW Approved Permits
- DOB NOW Job Filings

Results are filtered by BIN with 30-record limits.

Note: `bin__` (double underscore) in legacy datasets; `bin` in DOB NOW datasets.

## Step 4: Organized Output

Results merge and sort by date (descending), grouped by job type:
- New Building (NB)
- Alterations (A1/A2/A3)
- Demolition (DM)
- Other

```markdown
## DOB Permits — {Address}

### New Buildings
| Date | Job # | Permit # | Status | Applicant |
|------|-------|----------|--------|-----------|
| ... | ... | ... | ... | ... |

### Alterations
| Date | Job # | Type | Status | Description |
|------|-------|------|--------|-------------|
| ... | ... | A2 | Filed | ... |
```

If building predates 1989: note that pre-BIS records are not digitized.
