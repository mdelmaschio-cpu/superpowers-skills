---
name: NYC DOB Violations Lookup
description: Search Department of Buildings and Environmental Control Board violations for any NYC property using address, BBL, or BIN.
when_to_use: when checking building code violations and ECB penalties for a NYC property; performing due diligence on a property acquisition; or researching compliance history before starting a renovation project
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /nyc-dob-violations — DOB & ECB Violations

Search Department of Buildings and Environmental Control Board violations for any NYC property. No API key required.

## Usage

```
/nyc-dob-violations 120 Broadway, Manhattan
/nyc-dob-violations 1000770001          (BBL)
/nyc-dob-violations 1001389             (BIN)
```

## Process

**Input parsing**: accepts addresses, BBLs, or BINs with borough codes (Manhattan=1, Bronx=2, Brooklyn=3, Queens=4, Staten Island=5).

**PLUTO resolution**: queries PLUTO to get BBL, BIN, and building metadata.

**Violation queries** from three sources:
- DOB violations (sorted by issue date)
- ECB violations with penalty details
- Currently open violations (filtered subset)

## Output

Results prioritize open violations with a ⚠ warning flag, followed by comprehensive violation tables:

```markdown
## Violations — {Address}

⚠ **OPEN VIOLATIONS** (action required)

| Date | Type | Category | Description |
|------|------|----------|-------------|
| ... | ECB | Construction | ... |

### All DOB Violations
| Date | Type | Status | Description |
|------|------|--------|-------------|

### ECB Violations
| Date | Penalty Assessed | Balance Due | Status |
|------|-----------------|-------------|--------|

**Total penalties assessed:** $X,XXX
**Total balance due:** $X,XXX
```

If no violations: "No DOB or ECB violations found for this property."
