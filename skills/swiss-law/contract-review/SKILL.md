---
name: Contract Review (Swiss Law)
description: Review contracts under Swiss law — CO/OR framework, risk analysis with Swiss market benchmarks, position-aware assessment for NDA, service agreements, construction contracts, and commercial agreements.
when_to_use: when reviewing a contract governed by Swiss law, analyzing risk in a Swiss commercial agreement, NDA, service contract, or construction contract, identifying unfavorable clauses for a Swiss client, or preparing for contract negotiation under CO/OR — oppure quando si esamina un contratto di diritto svizzero, si analizzano i rischi in un accordo commerciale svizzero, NDA, contratto di prestazione o d'appalto, si identificano clausole sfavorevoli, o ci si prepara per una negoziazione contrattuale ai sensi del CO/OR
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Write
---

# /contract-review — Contract Review (Swiss Law)

Position-aware contract review under Swiss law (Code of Obligations / Obligationenrecht). Based on the claude-legal-skill framework adapted for Swiss legal context.

## Pre-Review Protocol

Before starting: establish **which party** you represent (client/provider, buyer/seller, employer/employee) — every risk assessment is position-specific.

## Output Format

```
DOCUMENT: [Type and title]
GOVERNING LAW: Switzerland — OR/CO [+ specific norm if applicable]
PARTY POSITION: [Your client's position]
OVERALL RISK: 🔴 High / 🟡 Medium / 🟢 Low
STATUS: [Draft / Signed / For negotiation]

PRE-SIGNING ALERTS (action required before signing):
[Critical items]

EXECUTIVE SUMMARY:
[3–5 sentence overview of deal structure and key risk]

KEY TERMS:
[Table: Term | Value | Market standard | Assessment]

RISK ANALYSIS:
🔴 CRITICAL — [clause]: [risk] [Swiss law reference]
🟡 IMPORTANT — [clause]: [concern]
🟢 ACCEPTABLE — [clause]: [why it's fine]

MISSING PROVISIONS:
[Clauses absent but typically expected under Swiss practice]

NEGOTIATION PRIORITIES:
[Ranked list with suggested alternative language]
```

## Swiss Law Key Provisions

### Liability (OR art. 97–101)

- Default: liability for breach if not proven force majeure
- **Limitation of liability**: valid if not for gross negligence (grobe Fahrlässigkeit) or intent — OR art. 100
- **Market standard**: liability cap = 12 months fees for service agreements
- 🔴 Red flag: unlimited liability for either party
- 🔴 Red flag: exclusion of liability for own gross negligence

### Termination

- **Fixed term**: no ordinary termination right unless agreed
- **Indefinite duration**: termination with reasonable notice (OR art. 404 for mandate)
- **Mandate (Auftrag, OR art. 394–406)**: client may terminate anytime; contractor may terminate for good reason — BUT must compensate the other party
- **Market standard**: 30–90 days notice for commercial service agreements
- 🔴 Red flag: termination for convenience with no notice period

### IP and Work Product

- Swiss author's law (URG): author retains moral rights even after transfer of economic rights
- **Assignments must be explicit** — Swiss law does not imply IP transfer
- 🟡 Watch: "all rights assigned" without specifying scope or territory
- For architects: moral right to authorship of design cannot be waived

### Confidentiality / NDA

- No statutory NDA obligation in Switzerland — contract must create it
- **Duration**: 3–5 years for commercial secrets; perpetual for trade secrets
- **Residuals clause**: if present, effectively nullifies NDA for knowledge retained in memory
- Enforcement: cantonal courts; preliminary injunction (superprovisorische Verfügung) available quickly

### Dispute Resolution

- Default: cantonal courts (Kantonsgericht / Tribunal cantonal)
- Arbitration: valid by agreement; Swiss Rules of International Arbitration (Swiss Rules) commonly used
- **Choice of court**: Swiss courts generally enforce exclusive jurisdiction clauses
- Swiss arbitration: Zurich, Geneva, Basel most common seats

## Swiss Market Benchmarks

| Parameter | Red | Yellow | Standard |
|-----------|-----|--------|----------|
| Liability cap | None / <3 months | 3–6 months | 12 months fees |
| Payment terms | >60 days | 30–60 days | 30 days |
| Termination notice | <30 days | 30–60 days | 60–90 days |
| NDA duration | <1 year | 1–2 years | 3–5 years |
| Governing law | Unclear | Non-Swiss unfavorable | Swiss OR/CO |

## Document-Specific Guidance

### NDA (Swiss context)
- Verify: mutual vs. one-way; definition of Confidential Information
- Check: residuals clause (🔴 if included)
- Check: carve-outs (publicly known, independently developed, prior knowledge)
- Swiss courts: strong enforcement of well-drafted NDAs via provisional measures

### Service Agreement / Mandate (OR art. 394)
- Distinguish: Auftrag (mandate, best-efforts) vs. Werkvertrag (result obligation)
- Auftrag: client can terminate anytime (OR art. 404) — cannot be contractually restricted
- Verify: scope of services, deliverables, acceptance criteria
- Check: change order process (Änderungswesen)

### Construction Contract (SIA 118 / OR art. 363)
- See `/swiss-construction-law` for detailed guidance
- Verify SIA 118 explicitly incorporated
- Check: defect liability period (2 vs. 5 years)
- Check: Abnahme procedure defined

### Lease / Tenancy (OR art. 253)
- See `/swiss-tenancy-law` for detailed guidance

## Guardrails

- This is informational analysis only — not legal advice
- For contracts with material value, engage a Swiss lawyer
- Do not state legal conclusions as certain — flag uncertainties
- Only reference actual document text; do not hallucinate clauses
