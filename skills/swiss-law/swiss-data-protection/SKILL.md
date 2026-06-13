---
name: Swiss Data Protection (nLPD)
description: Swiss data protection law reference — nLPD (revised Federal Act on Data Protection), GDPR equivalence, obligations for data controllers, privacy notices, and cross-border data transfers.
when_to_use: when assessing Swiss data protection obligations, drafting a privacy policy for a Swiss entity, evaluating GDPR vs nLPD requirements, handling a data breach in Switzerland, advising on data processing contracts, or understanding cross-border data transfer rules under Swiss law — oppure quando si valutano gli obblighi svizzeri di protezione dei dati, si redige un'informativa sulla privacy per un'entità svizzera, si confrontano i requisiti GDPR e nLPD, si gestisce una violazione dei dati in Svizzera, si consigliano clienti sui contratti di trattamento dati, o si comprendono le regole per i trasferimenti di dati transfrontalieri
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Write
---

# /swiss-data-protection — Swiss Data Protection (nLPD)

## Key Law

**nLPD** (neues Datenschutzgesetz / nouvelle loi sur la protection des données) — in force **1 September 2023**. Replaces the 1992 DSG.

Supervisory authority: **FDPIC** (Federal Data Protection and Information Commissioner / EDÖB)

## nLPD vs GDPR — Key Differences

| Aspect | nLPD (Switzerland) | GDPR (EU) |
|--------|-------------------|-----------|
| Territorial scope | Swiss-based controllers + foreign processors targeting CH persons | Similar |
| Legal basis for processing | Not explicitly required for legitimate purposes | Required (6 legal bases) |
| **Consent** | Not required if legitimate interest exists | One of 6 required bases |
| Data breach notification | **72 hours** to FDPIC if high risk | 72 hours to supervisory authority |
| DPO appointment | Not mandatory (but recommended) | Mandatory for certain controllers |
| Fines | Up to **CHF 250'000** (personal criminal liability of responsible person) | Up to 4% global turnover |
| **Adequacy for EU transfer** | Switzerland currently adequate — FDPIC decision pending | EU-CH adequacy decision valid |

## Core Obligations for Swiss Data Controllers

### 1. Data Inventory (Bearbeitungsverzeichnis)

Mandatory for organizations with ≥250 employees or high-risk processing. Documents:
- Categories of personal data processed
- Purpose of processing
- Recipients (including international transfers)
- Retention periods
- Technical security measures

### 2. Privacy Notice (Datenschutzerklärung)

Required when collecting personal data. Must state:
- Identity and contact of controller
- Data collected and processing purposes
- Legal basis (good practice, though not strictly required)
- Recipients and international transfers
- Retention period
- Data subject rights

### 3. Data Processing Agreement (Auftragsbearbeitungsvertrag)

Required when engaging a third-party processor (e.g., cloud provider, IT service):
- Processor must process only on controller's documented instructions
- Minimum contract terms specified in nLPD

### 4. Data Protection Impact Assessment (DSGFA / DSFA)

Required for high-risk processing:
- Large-scale profiling
- Systematic monitoring of public areas
- Sensitive data at scale
- New technologies with significant individual impact

### 5. Data Breach Notification

- **Internal**: identify, contain, assess risk
- **FDPIC notification**: if high risk to data subjects — within **72 hours**
- **Individual notification**: if risk to affected persons is high
- Document all breaches (even non-notifiable)

## Sensitive Data Categories (nLPD art. 5)

Higher protection requirements for:
- Health data (Gesundheitsdaten)
- Biometric / genetic data
- Political opinions
- Religious / philosophical beliefs
- Trade union membership
- Administrative or criminal sanctions

## Cross-Border Data Transfers

- **Adequate countries**: EU/EEA, UK, and ~15 others listed by FDPIC
- **Safeguards for non-adequate countries**: Standard Data Protection Clauses (approved by FDPIC), BCR, or consent
- **New**: FDPIC has adopted updated standard clauses aligned with EU SCCs (2021)

## Rights of Data Subjects

| Right | nLPD provision |
|-------|---------------|
| Access | art. 25 — within 30 days |
| Rectification | art. 32 |
| Erasure | art. 32 (limited — no general right) |
| Objection to profiling | art. 21 |
| Portability | Not explicitly in nLPD |
| Automated decision-making | art. 21 — right to human review for significant decisions |

## Enforcement and Penalties

- **Administrative**: FDPIC may investigate, recommend, refer to Department of Justice
- **Criminal**: Fines up to **CHF 250'000** against **responsible natural persons** (not entities — unlike GDPR)
- **Criminal prosecution**: willful violations of transparency, data security, or processing obligations

## Practical Compliance Checklist

- [ ] Update privacy notices to nLPD standards
- [ ] Create/update data processing inventory if >250 employees or high-risk
- [ ] Review and update data processing agreements with vendors
- [ ] Establish data breach detection and notification procedure (72h clock)
- [ ] Review international data transfers — update SCCs to FDPIC 2021 version
- [ ] Train staff on nLPD obligations
- [ ] Assess whether DSFA required for any processing activities
- [ ] Appoint internal data protection contact (recommended even if not mandatory)
