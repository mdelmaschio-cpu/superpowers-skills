---
name: Prioritizing Vulnerabilities with CVSS Scoring
description: Calculate CVSS v3.1 base scores from a vector string and combine them with EPSS exploit-probability and CISA KEV data to risk-rank vulnerabilities for remediation.
when_to_use: when a vulnerability scan or CVE list needs prioritization beyond raw CVSS severity; when setting remediation SLAs across a large backlog of findings; when justifying patch urgency to stakeholders with real threat-intelligence context (EPSS, KEV); when interpreting or constructing a CVSS vector string
version: 1.0.0
languages: all
---

# Prioritizing Vulnerabilities with CVSS Scoring

## Overview

CVSS tells you how severe a vulnerability *could* be in the worst case — it says nothing about whether anyone is actually exploiting it. Two CVSS 9.8 findings can have wildly different real-world urgency: one might be a theoretical local-only issue with no public exploit, the other might be actively exploited ransomware infrastructure on an internet-facing crown-jewel server. This skill covers calculating the CVSS score itself, then layering on EPSS (exploit prediction) and CISA's Known Exploited Vulnerabilities catalog to get an actionable priority order.

## When to Use

- A vulnerability scan produced more findings than the team can patch immediately and they need a defensible order
- Remediation SLAs need to be assigned across a backlog
- A CVSS vector string needs to be calculated or interpreted by hand
- Stakeholders are pushing back on patch urgency and need threat-intel-backed justification

## Prerequisites

- Vulnerability scan results with CVE IDs and/or CVSS vector strings
- Network access to FIRST.org's EPSS API and CISA's KEV catalog (both free, no key required)
- Asset criticality ratings from a CMDB or equivalent inventory

## Core Concepts

### CVSS v3.1 base metrics

| Metric | Meaning | Values |
|---|---|---|
| AV | Attack Vector | Network / Adjacent / Local / Physical |
| AC | Attack Complexity | Low / High |
| PR | Privileges Required | None / Low / High |
| UI | User Interaction | None / Required |
| S | Scope | Unchanged / Changed |
| C / I / A | Confidentiality / Integrity / Availability impact | None / Low / High |

A full vector looks like `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H` — network-exploitable, no special access or user interaction needed, full impact on all three pillars.

### Severity bands

| Score | Severity |
|---|---|
| 0.0 | None |
| 0.1-3.9 | Low |
| 4.0-6.9 | Medium |
| 7.0-8.9 | High |
| 9.0-10.0 | Critical |

## Workflow

### Step 1: Get or calculate the base score

If the scanner already provides a CVSS vector, parse it directly. Otherwise assess each metric from the vulnerability description and compute the score using the official FIRST.org formula (see Included Script).

### Step 2: Pull in threat intelligence

- **EPSS** (Exploit Prediction Scoring System) — FIRST.org's probability (0-1) that a CVE will be exploited in the next 30 days: `https://api.first.org/data/v1/epss?cve=CVE-...`
- **CISA KEV** — the authoritative list of vulnerabilities with confirmed active exploitation: `https://www.cisa.gov/sites/default/files/feeds/known_exploited_vulnerabilities.json`. Anything on this list gets remediated first, regardless of CVSS score.

### Step 3: Weight against organizational context

Combine CVSS with the factors that actually drive your risk:

| Factor | Suggested weight |
|---|---|
| CVSS base score | 25% |
| EPSS score | 25% |
| Asset criticality | 20% |
| CISA KEV listed | 15% |
| Network exposure | 15% |

### Step 4: Assign remediation SLAs

| Priority | CVSS | EPSS | SLA |
|---|---|---|---|
| P1 – Emergency | 9.0-10.0 or KEV-listed | >0.5 | 24-48 hours |
| P2 – Critical | 7.0-8.9 | >0.3 | 7 days |
| P3 – High | 7.0-8.9 | <0.3 | 14 days |
| P4 – Medium | 4.0-6.9 | any | 30 days |
| P5 – Low | 0.1-3.9 | any | 90 days |

## Best Practices

1. Never rely on CVSS base score alone — it ignores both real-world exploitation and your specific environment.
2. Always check EPSS and CISA KEV before finalizing priority.
3. Keep asset criticality ratings in the CMDB current; stale ratings silently misprioritize everything downstream.
4. Document scoring rationale — both for audit trail and so the next analyst doesn't redo the work.
5. Re-score when new threat intelligence emerges (a CVE jumping onto KEV should re-trigger triage).

## Common Pitfalls

- **Treating CVSS as the whole answer** — it's one input among several, not the verdict.
- **Confusing CVSS severity with organizational risk** — a Critical-severity bug on an air-gapped test box is lower risk than a Medium on an internet-facing payment system.
- **Using stale CVSS v2 scores** — migrate to v3.1 or v4.0 scoring; the metric set materially changed.
- **Trusting a "v4.0" calculation that isn't FIRST's official one** — true CVSS v4.0 scoring uses FIRST's published lookup tables, not a closed-form formula. A homegrown approximation will disagree with the official calculator and NVD; if you need v4.0 specifically, use FIRST's calculator or a vetted library, not an ad hoc formula.

## Included Script

`scripts/cvss_prioritize.py` implements the official CVSS v3.1 base-score formula (per the FIRST.org specification), fetches EPSS and CISA KEV data for a list of CVEs, and produces a priority-sorted report. Requires the `requests` package. Run with `python3 scripts/cvss_prioritize.py` (includes a small built-in example set); import `CVSSPrioritizationAgent` to score your own CVE list.

## Related Skills

- skills/security/triaging-security-incident-with-ir-playbook — when a vulnerability finding escalates into an active incident
