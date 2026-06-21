---
name: Triaging Security Incidents with IR Playbooks
description: Classify a security alert by incident type, score its severity with a structured matrix, and select the matching IR playbook and escalation path.
when_to_use: when a new alert arrives from a SIEM/EDR and needs true-positive triage; when an incident needs severity classification (P1-P4) and a response team assigned; when multiple concurrent incidents need to be prioritized into a single queue; when validating or tuning automated triage rules
version: 1.0.0
languages: all
---

# Triaging Security Incidents with IR Playbooks

## Overview

Triage is the first 15-30 minutes of incident response: decide whether an alert is a true positive, how bad it is, and who needs to be paged. Getting this wrong in either direction is costly — under-triage delays response to a real breach, over-triage burns out on-call responders with false urgency. This skill structures classification, severity scoring, and playbook selection into a repeatable decision flow.

## When to Use

- New alert from SIEM, EDR, or another detection source needs an initial true-positive/false-positive call
- An incident needs a severity level and an owning team before work can start
- Several alerts arrived at once and need to be ordered into a single response queue
- Existing automated triage rules need to be checked against real alert data

## Prerequisites

- SIEM with alert correlation (Splunk, Elastic, QRadar, Sentinel) or equivalent alert source
- An IR playbook library, organized by incident type
- A severity matrix agreed with stakeholders (asset criticality, data sensitivity, scope, threat status)
- Ticketing/case management system (TheHive, ServiceNow, Jira) and an on-call rotation

## Workflow

### Step 1: Acknowledge and enrich

Pull the new alert and acknowledge it in the SIEM to avoid duplicate triage. Enrich any IOCs in the alert (source/dest IP, file hash, domain) — see skills/security/analyzing-indicators-of-compromise — and look up the affected asset's criticality and owner in the CMDB.

### Step 2: Classify the incident type

Match the alert against known categories by keyword/signature or MITRE ATT&CK technique:

| Type | Signal keywords |
|---|---|
| Malware | trojan, ransomware, dropper, C2, beacon |
| Phishing | credential harvest, spear-phishing, BEC |
| Data exfiltration | DLP hit, large upload, DNS tunneling, unusual transfer |
| Unauthorized access | brute force, privilege escalation, lateral movement, pass-the-hash |
| Denial of service | SYN flood, amplification, volumetric, resource exhaustion |
| Insider threat | policy violation, unauthorized copy, after-hours access, terminated user |
| Web attack | SQLi, XSS, RCE, web shell, deserialization |

### Step 3: Score severity

Combine four weighted factors (each 1-4) into a single score:

| Factor | 4 (highest) | 1 (lowest) |
|---|---|---|
| Asset criticality | Critical | Low |
| Data sensitivity | PII/PHI | Public |
| Threat status | Active exploitation | Reconnaissance only |
| Scope | Enterprise-wide | Single user |

| Score | Severity | Priority | Response SLA |
|---|---|---|---|
| 13-16 | Critical | P1 | 15 minutes |
| 10-12 | High | P2 | 30 minutes |
| 6-9 | Medium | P3 | 2 hours |
| 4-5 | Low | P4 | 24 hours |

A crown-jewel asset affected or confirmed active exploitation should force Critical/P1 regardless of the computed score.

### Step 4: Select the playbook and escalation path

Each incident type maps to a specific playbook and escalation target — e.g., data exfiltration goes to the IR team **and** CISO; insider threat goes to IR **and** HR/Legal, not just the SOC. Pull the matching playbook from the library rather than improvising response steps.

### Step 5: Create the ticket and hand off

Open a case with the triage summary, severity justification, assigned playbook, and escalation target. Page the on-call rotation per severity (P1: IR lead + senior analysts + CISO; P2: IR lead + available analysts; P3/P4: queue for next available analyst).

## Key Concepts

| Term | Definition |
|---|---|
| **True/False Positive** | Whether the alert correctly identifies a real incident |
| **Playbook** | The predefined response procedure for a given incident type |
| **Escalation threshold** | The condition that bumps an incident to higher severity or brings in management/legal |
| **Triage SLA** | Target time to complete initial assessment — typically 15-30 minutes for Critical |

## Common Scenarios

1. **Brute force from a single IP** — enrich IP reputation and geolocation, confirm no account was actually compromised, usually P3.
2. **Malware quarantined by EDR** — verify the quarantine succeeded, check for lateral movement or persistence; escalate to P2 if either is found.
3. **Large outbound transfer to an unknown IP** — check if it's a known cloud service first; if not, and exfiltration is confirmed, this is P1.
4. **Reported phishing email** — extract IOCs, check if other recipients got it, escalate to P2 if credentials were actually entered.
5. **Unexpected privilege escalation** — verify whether it was an authorized change before treating it as P1.

## Included Script

`scripts/triage_incident.py` classifies free-text alert text into an incident type by keyword match, scores severity (with `--crown-jewel`/`--active-exploit` overrides), selects the matching playbook/escalation target, and writes a JSON triage report. Dependency-free (stdlib only) — run with `python3 scripts/triage_incident.py "ransomware detected on PROD-DB-01" --crown-jewel`.

## Related Skills

- skills/security/analyzing-indicators-of-compromise — enrich IOCs found in the alert before finalizing severity
- skills/security/prioritizing-vulnerabilities-with-cvss-scoring — when the incident traces back to an unpatched vulnerability
