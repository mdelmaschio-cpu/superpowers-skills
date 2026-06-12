---
name: NYC ACRIS Property Records
description: Look up ACRIS property transaction records for any NYC property — deeds, mortgages, satisfactions, liens, and ownership history.
when_to_use: when researching who owns a NYC building, when it last sold or for how much, whether there are mortgages or liens against it, or reviewing the full transaction history of a NYC property; for permits or violations use the DOB skills instead
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Write
  - Read
  - Bash
---

# /nyc-acris — ACRIS Property Transaction Records

Look up ACRIS (Automated City Register Information System) property records — deeds, mortgages, liens, and other recorded documents. Uses a 3-table join across Legals, Master, and Parties datasets. No API key required.

## Usage

```
/nyc-acris 120 Broadway, Manhattan
/nyc-acris 1000770001          (BBL)
/nyc-acris 1001389             (BIN)
```

## Step 1: Parse Input

Accept Address + Borough/Zip, BBL (10-digit), or BIN (7-digit).

Borough codes: Manhattan=1/MN, Bronx=2/BX, Brooklyn=3/BK, Queens=4/QN, Staten Island=5/SI

## Step 2: Resolve via PLUTO

Query PLUTO to get BBL, BIN, and building metadata. Parse BBL into separate components (required for ACRIS): boro = digit 1, block = digits 2-6 (zero-padded), lot = digits 7-10 (zero-padded).

## Step 3: Query ACRIS (3-Table Join)

**IMPORTANT:** ACRIS requires BBL (not BIN). The Legals table uses separate `borough`, `block`, `lot` fields.

### 3a: Get Document IDs from Legals Table
```
https://data.cityofnewyork.us/resource/8h5j-fqxa.json?borough={boro}&block={block}&lot={lot}&$order=good_through_date DESC&$limit=20
```

### 3b: Get Document Details from Master Table
```
https://data.cityofnewyork.us/resource/bnx9-e6tj.json?$where=document_id IN ('{id1}','{id2}',...)&$order=doc_date DESC
```

Key fields: `document_id`, `doc_type`, `doc_date`, `doc_amount`, `recorded_filed`

### 3c: Get Parties from Parties Table
```
https://data.cityofnewyork.us/resource/636b-3b5g.json?$where=document_id IN ('{id1}','{id2}',...)
```

Party types: `1` = Grantor (seller/borrower/assignor), `2` = Grantee (buyer/lender/assignee)

### 3d: Look Up Document Type Codes
```
https://data.cityofnewyork.us/resource/7isb-wh4c.json?$limit=200
```

Common codes: DEED, MTGE (Mortgage), SAT (Satisfaction), ASST (Assignment), UCC1 (UCC Filing)

## Step 4: Print Results

```markdown
## Property Records (ACRIS) — {Address}

**Current owner (per most recent deed):** {grantee name}

### Deeds (Ownership)
| Date | Amount | From (Grantor) | To (Grantee) |
|------|--------|----------------|--------------|
| ... | $X,XXX,XXX | ... | ... |

### Mortgages
| Date | Amount | Lender | Borrower |
|------|--------|--------|----------|
| ... | $X,XXX,XXX | ... | ... |
```

**Note:** Condo units may have records on both the unit lot and the parent condo lot. If results seem incomplete, try querying the main condo lot.
