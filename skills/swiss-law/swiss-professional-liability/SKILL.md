---
name: Swiss Professional Liability for Architects
description: Professional liability of architects and engineers in Switzerland — contractual and tort liability under OR, professional indemnity insurance (RC professionale), decennial liability for structural defects, and liability allocation between project participants.
when_to_use: when an architect faces a claim for defects or damage in Switzerland, understanding professional liability exposure under Swiss law, reviewing RC professionale insurance coverage, dealing with structural defects that appeared after completion, allocating liability between architect and contractor after a construction failure, or drafting liability-limiting clauses in a mandate contract — oppure quando un architetto affronta un reclamo per difetti o danni in Svizzera, si comprende l'esposizione alla responsabilità professionale secondo il diritto svizzero, si esamina la copertura assicurativa RC professionale, si gestiscono difetti strutturali emersi dopo la consegna, si ripartisce la responsabilità tra architetto e impresa dopo un guasto costruttivo, o si redigono clausole di limitazione della responsabilità in un contratto di mandato
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Write
---

# /swiss-professional-liability — Swiss Professional Liability for Architects

## Legal Basis

- **OR art. 97–109**: Contractual liability (Vertragshaftung / responsabilité contractuelle)
- **OR art. 41–61**: Tort liability (Haftpflicht aus unerlaubter Handlung)
- **OR art. 364–366, 368**: Defects under the works contract (Werkvertrag)
- **OR art. 398**: Duty of care in mandate (Auftrag / mandat)
- **SIA 102**: Professional standard of care for architects

---

## 1. Contractual Liability — Mandate (Auftrag, OR art. 394–406)

The architect–client relationship is a **mandate** (Auftrag), not a works contract (Werkvertrag). This distinction matters:

| | Auftrag (Mandate) | Werkvertrag (Works Contract) |
|--|-------------------|------------------------------|
| **Obligation** | Best efforts (Sorgfaltspflicht) | Result (Erfolg) |
| **Defect regime** | OR art. 97 — breach of duty of care | OR art. 367–371 — specific defect rules |
| **Limitation period** | 10 years (OR art. 127) | 5 years (hidden defects, OR art. 371 para. 1) |
| **Applies to** | Planning, design, DL mandate | Construction contracts (Unternehmer) |

### Standard of Care (OR art. 398 para. 2)
The architect must apply the skill and care of a **reasonably competent professional** in the same specialty. Measured against:
- SIA 102 scope-of-service obligations
- Applicable building norms (SIA, EN, cantonal)
- State of the art at time of design/execution

### Common Breach Scenarios
- Design error causing structural failure or code non-compliance
- Failure to detect non-conforming contractor work during site supervision (Bauleitung)
- Delay in issuing drawings causing project delay
- Cost overrun exceeding SIA 102 §3 tolerance (±10% of approved budget) without client notice
- Selecting an unqualified contractor

---

## 2. Defect Liability Periods

### Architect's Planning Defects (Planungsmängel)
| Claim type | Limitation period | Start |
|------------|-------------------|-------|
| Contractual (OR 97) | **10 years** (OR art. 127) | From date defect discoverable |
| Tort (OR 41) | **3 years** from knowledge (relative) / **10 years** from act (absolute) | OR art. 60 |

### Contractor's Construction Defects (Ausführungsmängel — OR art. 371)
| Defect type | Period |
|-------------|--------|
| Movable works | 2 years from delivery |
| Immovable works (buildings) | **5 years** from acceptance |
| Fraudulently concealed defects | 10 years |
| SIA 118 (if contracted) | 2 years for visible, 5 years for hidden defects |

### Decennial Liability — Important Distinction
Switzerland does **not** have a statutory 10-year decennial liability regime like France/Italy. The 10-year period for architects is the general contractual limitation (OR art. 127), not a special statutory regime. However:
- For **structural defects** (Tragwerkmängel) discovered late: argument that the 10-year OR 127 period runs from when the defect became detectable (not from completion) → effectively long exposure
- Swiss courts have extended the discovery-based start of the limitation period in egregious cases

---

## 3. Liability Allocation Between Project Participants

### Who Is Liable for What

| Defect origin | Primary liable party | Architect's potential co-liability |
|---------------|---------------------|-----------------------------------|
| Design error | Architect | Always |
| Construction error (contractor) | Contractor | If architect failed to detect during Bauleitung |
| Specification ambiguity | Architect | Yes — SIA 102 §3.3 |
| Subcontractor selection by architect | Architect | Yes — duty to propose qualified firms |
| Change order causing defect | Depends on who ordered | Architect if approved without objection |
| Value engineering reducing structural margin | Both | If architect accepted without reserve |

### Concurrent Liability (Solidarische Haftung)
Swiss courts regularly apply **joint and several liability** (OR art. 51) where both architect and contractor contributed to a defect. The client may sue either or both for the full amount; they settle allocation between themselves (OR art. 51 para. 2 recourse action).

### Internal Recourse (Regressanspruch)
If architect pays client for a contractor's defect: right of recourse against contractor (OR art. 51 para. 2). Document:
- Bauleiter reports showing contractor was warned
- Written objections and reservation notes (Vorbehalte) in Bauleiterprotokoll
- Evidence that defect was concealed during inspection

---

## 4. RC Professionale (Professional Indemnity Insurance)

### Cantonal Mandatory Insurance
Most cantons require proof of PI insurance for architect registration. The SIA and FSU recommend minimum coverage:

| Firm annual revenue | Recommended minimum coverage |
|---------------------|------------------------------|
| < CHF 500'000 | CHF 1'000'000 per claim |
| CHF 500'000–2M | CHF 2'000'000 per claim |
| > CHF 2M | CHF 5'000'000+ or project-specific |

**Important**: coverage is typically on a **claims-made** basis (Anspruchserhebungsprinzip) — the claim must be made while the policy is in force, not when the error was committed. Maintain coverage even after project completion or tail coverage for at least 5 years.

### What RC Professionale Covers
- Planning errors (design, specification, coordination)
- Site supervision failures (Bauleitung negligence)
- Cost overrun claims beyond SIA tolerance
- Legal defense costs
- Settlement payments

### What Is Typically Excluded
- Intentional acts (Vorsatz)
- Contractual penalties (Konventionalstrafe) — unless linked to a covered error
- Pollution and environmental claims (special policy required)
- Works executed by the architect personally as contractor (Unternehmerrisiko)
- Bodily injury during construction (separate SUVA / liability policy)

### Subrogation
Insurer paying a claim acquires the right to sue the contractor (or any co-liable party) in the architect's name (OR art. 72). Coordinate carefully — do not settle third-party claims without insurer consent.

---

## 5. Liability Limitation Clauses

### What Is Enforceable in Switzerland
OR art. 100 para. 1: liability for **gross negligence (grobe Fahrlässigkeit) and wilful misconduct cannot be excluded** in advance. Limitation clauses are void to that extent.

For **ordinary negligence** (leichte Fahrlässigkeit): limitation is generally enforceable between professionals (B2B).

### Recommended Clauses for SIA 102 Mandates

```
Haftungsbeschränkung:
Die Haftung des Architekten beschränkt sich auf den Betrag der RC-Berufshaftpflichtversicherung 
(CHF [Betrag] pro Schadenfall). Bei leichter Fahrlässigkeit ist die Haftung 
auf den vereinbarten Honorarbetrag begrenzt. Diese Beschränkung gilt nicht für 
Schäden aus grober Fahrlässigkeit oder Vorsatz.

(The architect's liability is limited to the RC professional indemnity insurance amount 
[CHF amount per claim]. For ordinary negligence, liability is capped at the agreed fee. 
This limitation does not apply to damages from gross negligence or willful misconduct.)
```

### Additional Protections
- **Abnahmeprotokoll with reservations**: client accepts work → shifts burden for visible defects
- **Bauleiterprotokoll**: contemporaneous records of contractor non-conformance
- **Written approvals**: always get client sign-off on design changes, budget increases
- **Scope limitation**: clearly define what is NOT included in the mandate

---

## 6. Practical Response to a Claim

### Immediate Steps
1. **Notify insurer immediately** (claims-made policy — delay = risk of coverage denial)
2. Do **not** admit liability without insurer authorization
3. Preserve all project documents: correspondence, drawings, protocols, approvals
4. Commission independent expert report if claim involves structural safety
5. Engage attorney specialized in construction law

### Evidence to Gather
- Signed mandate contract with defined scope
- All client-approved drawings and specifications
- Bauleiterprotokolle showing regular site inspections
- Written warnings to contractor re: non-conforming work
- Client approvals for any changes that may be related to the defect

---

## Quick Reference — Liability Exposure Matrix

| Scenario | Liable under | Limitation period | Insurance triggered? |
|----------|-------------|------------------|----------------------|
| Design error discovered at completion | OR 97 / 398 | 10 years | Yes |
| DL fails to detect contractor defect | OR 97 / 398 | 10 years | Yes |
| Cost overrun > 10% without notice | OR 97 / 398 | 10 years | Possibly |
| Injury on site (third party) | OR 41 | 3/10 years | Separate liability |
| Contractor copies architect's plans | URG | URG art. 62 | IP, not PI |
