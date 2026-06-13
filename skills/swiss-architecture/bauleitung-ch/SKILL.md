---
name: Bauleitung (Swiss Construction Management)
description: Swiss construction site management documentation — Bauleiterprotokoll, SAL, Abnahme, Mängelrüge, change orders, and cost control per SIA 102/118.
when_to_use: when managing a construction site in Switzerland, writing site meeting minutes (Bauleiterprotokoll), preparing or conducting the formal handover (Abnahme), managing defect lists (Mängelrüge), processing change orders (Nachträge), or tracking construction costs against the BKP budget — oppure quando si gestisce un cantiere in Svizzera, si redigono i verbali di cantiere, si prepara o si conduce il collaudo formale (Abnahme), si gestiscono le liste difetti, si elaborano varianti d'opera (Nachträge), o si controlla il costo di costruzione rispetto al BKP
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Write
---

# /bauleitung-ch — Swiss Construction Management

Construction site management documentation and procedures per SIA 102 (Realisierungsphase) and SIA 118.

## Bauleiterprotokoll (Site Meeting Minutes)

Standard weekly or biweekly site meeting record. Required sections:

```
BAULEITERPROTOKOLL Nr. [XX]
Projekt: [Project name]
Datum: [DD.MM.YYYY]  Ort: [Site address]
Nächste Sitzung: [date]

ANWESENDE (Attendees):
- Bauherr: [client representative]
- Architekt: [name, firm]
- Unternehmer: [contractor, trade]
- [other parties]

PENDENZEN AUS LETZTER SITZUNG (Open items from last meeting):
[Pend. Nr.] — [Description] — [Responsible] — [Deadline] — [Status]

BAUFORTSCHRITT (Construction progress):
[Description of work completed since last meeting]

NEUE PENDENZEN (New items):
[Pend. Nr.] — [Description] — [Responsible] — [Deadline]

NACHTRÄGE (Change orders):
[Nachtrag Nr.] — [Description] — [Amount CHF] — [Status: pending/approved/rejected]

KOSTEN (Cost status):
Budget BKP 2: CHF [amount]
Beauftragt: CHF [committed]
Prognose: CHF [forecast]
Reserve: CHF [remaining contingency]

NÄCHSTE SCHRITTE:
[Key activities planned before next meeting]

Verteiler: [distribution list]
```

## SAL — Stato di Avanzamento Lavori (Progress Report)

Monthly cost and progress report to the client. Contents:

1. **Physical progress**: % completion by trade, Gantt comparison
2. **Cost report**: budget vs. committed vs. forecast per BKP subcategory
3. **Change order register**: all Nachträge with status and cumulative impact
4. **Outstanding decisions**: client decisions needed with deadlines
5. **Risk register**: active risks and mitigation

## Nachtrag (Change Order) Management

Per SIA 118:
- **Architect initiates**: written instruction with scope description
- **Contractor prices**: detailed breakdown within agreed period (default 30 days)
- **Architect reviews**: verifies against LV unit rates where applicable
- **Client approves**: written approval before work proceeds (for extras >agreed threshold)
- **Document**: log in Pendenzenprotokoll and Nachtragsliste

```
NACHTRAG Nr. [XX]
Datum: [DD.MM.YYYY]
Auftragnehmer: [Contractor name]
Betreff: [Description of change]
Grund: [Reason: client request / unforeseen condition / design change]
Basis: [SIA 118 §58 / contractual basis]

Leistungsbeschrieb: [Detailed scope]
Betrag: CHF [amount] (inkl. MWST / exkl. MWST)
Terminauswirkung: [none / X days extension]

Genehmigt durch Bauherrn: ☐ ja ☐ nein
Datum: ___________  Unterschrift: ___________
```

## Abnahme (Formal Handover)

Per SIA 118 §157–163:

### Procedure
1. Contractor notifies readiness for inspection (Abnahmebereitschaft)
2. Architect schedules joint inspection (Abnahme)
3. Inspection conducted with client, contractor, architect
4. **Abnahmeprotokoll** records:
   - Date and attendees
   - Defects (Mängel) with deadline for remediation
   - Reservation of rights for hidden defects
   - Acceptance decision: accepted / conditionally accepted / rejected

### Legal Effect of Abnahme
- Triggers start of **2-year defect liability period** (SIA 118 §180) or **5-year per CO art. 371**
- Risk transfers to client
- Right to retain 10% retention until defects remedied
- Contractor's right to final payment minus retention

## Mängelrüge (Defect Notice)

Formal written notice to contractor:
```
MÄNGELRÜGE
Datum: [date]
An: [Contractor]
Projekt: [name], Werkvertrag Nr. [XX]

Folgende Mängel wurden festgestellt:
[Mängel-Nr.] — [Location] — [Description] — [Remediation deadline]

Wir fordern Sie auf, die genannten Mängel bis [date] zu beheben.
Bei Nichtbehebung behalten wir uns vor, die Arbeiten auf Ihre Kosten durch Dritte ausführen zu lassen (SIA 118 §169).
```

## Construction Phase Timeline Checklist

- [ ] Werkvertrag signed before work starts
- [ ] Baubeginnmeldung to municipality
- [ ] Weekly Bauleiterprotokoll
- [ ] Monthly SAL to client
- [ ] All Nachträge approved before execution
- [ ] Rohbauabnahme (structural inspection, if required)
- [ ] Airtightness test (Blower Door) if MINERGIE-P
- [ ] Abnahme inspection with protocol
- [ ] Final defect list issued within 30 days
- [ ] Schlussabrechnung verified
- [ ] Retention released per contract
