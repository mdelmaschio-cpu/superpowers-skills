---
name: BKP Building Cost Plan
description: Swiss building cost planning per BKP/CFC structure — cost estimation by phase, BKP categorization, cost benchmarks, and final account reconciliation.
when_to_use: when preparing a Swiss building cost estimate, structuring costs according to BKP categories, tracking construction costs against budget, preparing the final cost account (Schlussabrechnung), or advising a client on expected construction costs in Switzerland — oppure quando si prepara un preventivo dei costi edilizi svizzero, si strutturano i costi secondo le categorie BKP, si controllano i costi di costruzione rispetto al budget, si prepara il conto finale, o si consigliano i clienti sui costi attesi in Svizzera
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Write
---

# /bkp-cost-plan — BKP Building Cost Plan

Swiss building cost planning using the BKP (Baukostenplan / Code des frais de construction / Codice dei costi di costruzione) structure, standardized by the Swiss Building Cost Documentation (Baudokumentation).

## BKP Structure

### Level 1 — Main Categories

| BKP | Description (DE) | Description (IT) | Typical % of total |
|-----|-----------------|------------------|--------------------|
| **0** | Grundstück | Terreno | 15–30% |
| **1** | Vorbereitungsarbeiten | Lavori preparatori | 3–8% |
| **2** | Gebäude | Edificio | **45–65%** ← SIA 102 fee basis |
| **3** | Betriebseinrichtungen | Impianti di esercizio | 0–5% |
| **4** | Umgebung | Sistemazione esterna | 3–8% |
| **5** | Baunebenkosten | Oneri accessori | 8–15% |
| **6** | Reserve | Riserva | 5–10% |
| **9** | Ausstattung | Arredamento | 2–8% |

### BKP 2 — Building Breakdown (Level 2)

| BKP | Subcategory | Typical % of BKP 2 |
|-----|-------------|-------------------|
| 21 | Rohbau 1 (foundation, structure) | 20–35% |
| 22 | Rohbau 2 (façade, roof) | 15–25% |
| 23 | Elektroanlagen (electrical) | 8–12% |
| 24 | Heizung / Lüftung / Klima (HVAC) | 12–20% |
| 25 | Sanitäranlagen (plumbing) | 5–8% |
| 26 | Transportanlagen (lifts) | 2–5% |
| 27 | Ausbau 1 (interior shell) | 10–15% |
| 28 | Ausbau 2 (finishes) | 8–15% |
| 29 | Honorare (design fees) | 10–18% |

## Cost Accuracy by Phase

| Phase | Accuracy | Basis |
|-------|----------|-------|
| Vorstudien (VS) | ±30% | Volume comparison (CHF/m³ GV) |
| Vorprojekt (VP) | ±15% | Surface comparison (CHF/m² GF) |
| Bauprojekt (BP) | ±10% | Detailed element estimate |
| Ausschreibung (AS) | ±5% | Tendered prices |
| Realisierung (RL) | actual | Certified work payments |

## Swiss Cost Benchmarks (indicative, 2024–2025)

*Gross construction cost BKP 2, excluding land, VAT, and fees. Prices vary significantly by region (ZH highest, rural cantons lower), quality level, and site conditions.*

| Building Type | CHF/m² GF (low–high) |
|--------------|----------------------|
| Single family house, standard | 2'800–4'200 |
| Single family house, high-end | 4'200–7'000+ |
| Multi-family residential | 2'400–3'800 |
| Office building | 2'800–4'500 |
| Commercial/retail | 2'200–3'500 |
| Industrial/warehouse | 1'400–2'500 |
| School/public | 3'500–6'000 |
| Renovation (per case) | 800–3'500 |

## Cost Control During Construction

### Monthly Cost Report Structure
1. **Budget**: approved BKP cost plan
2. **Committed**: awarded contracts + approved change orders
3. **Forecast**: committed + estimated remaining work
4. **Variance**: forecast vs. budget (flag if >5%)

### Change Order (Nachtrag) Management
- All changes documented before execution
- Written approval by client required for extras >2% of contract value
- Running total tracked against contingency reserve
- Monthly reconciliation in Bauleiterprotokoll

## Final Account (Schlussabrechnung)

Per SIA 118:
1. Contractor submits final account within agreed period after Abnahme
2. Architect reviews within 60 days
3. Final amount certified and paid
4. Retention released after defect period (typically 2 years)

## VAT (MWST) Notes

- Swiss VAT on construction: standard rate 8.1% (2024)
- Residential rental: exempt
- Commercial: fully taxable (input tax deductible)
- Mixed-use: proportional
