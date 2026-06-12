---
name: NYC HPD Violations Lookup
description: Look up HPD violations, complaints, and building registration for NYC residential buildings.
when_to_use: when researching housing violations, tenant complaints, or building registration for NYC residential properties; performing due diligence on residential buildings; or checking if a building has outstanding housing violations before purchase or renovation
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /nyc-hpd — HPD Violations, Complaints & Registration

Look up Housing Preservation & Development data for NYC residential buildings. No API key required.

## Usage

```
/nyc-hpd 742 Evergreen Terrace, Manhattan
/nyc-hpd 1000770001          (BBL)
/nyc-hpd 1001389             (BIN)
```

## Process

**Step 1:** Parse input — address with borough/zip, BBL, or BIN. Borough codes: Manhattan=1, Bronx=2, Brooklyn=3, Queens=4, Staten Island=5.

**Step 2:** Query PLUTO dataset to obtain BBL, BIN, and building metadata.

**Step 3:** Verify building class starts with A, B, C, D, R, or S. Non-residential classes halt the lookup with notification.

**Step 4:** Query four HPD datasets:
- Violations (50 most recent)
- Open violations (currently active)
- Complaints (30 most recent)
- Registrations (current owner and status)

## Critical API Details

HPD datasets use `boroid` (numeric codes), with `block` and `lot` as separate fields. Complaints dataset uses "BOROUGH_NAME" text format instead of `boroid`.

## Output Format

```markdown
## HPD Data — {Address}

⚠ **OPEN VIOLATIONS** (Class C = hazardous)
| Date | Class | Description |
|------|-------|-------------|
| ... | C ⚠ | ... |

### Violation History (50 most recent)
| Date | Class | Status | Description |
|------|-------|--------|-------------|

### Complaint History (30 most recent)
| Date | Type | Status |
|------|------|--------|

### Registration
| Owner | Status | Last Registered |
|-------|--------|----------------|
```

Violation classes: C = hazardous (flagged ⚠), B = hazardous, A = non-hazardous.

Only applies to residential building classes (A, B, C, D, R, S).
