---
name: Analyzing Indicators of Compromise
description: Classify, defang, and enrich IOCs (IPs, domains, hashes, URLs) with multi-source threat intelligence to assign confidence scores and block/monitor/investigate dispositions.
when_to_use: when triaging IOCs pulled from a phishing email, SIEM/EDR alert, or external threat feed; when enriching raw indicators with VirusTotal, AbuseIPDB, or MalwareBazaar before a block/monitor/whitelist decision; when an incident investigation needs confidence scoring on observed network or host artifacts
version: 1.0.0
languages: all
---

# Analyzing Indicators of Compromise

## Overview

An Indicator of Compromise (IOC) — an IP, domain, file hash, URL, or email artifact — is only useful once it's been classified, enriched with context, and assigned a confidence level. Raw IOCs from phishing reports or SIEM alerts are unreliable on their own: a hash with zero AV detections might be a brand-new APT tool, and an IP with thousands of abuse reports might be a shared CDN edge node. This skill structures that enrichment-to-disposition pipeline.

## When to Use

- A phishing email or alert generates IOCs (URLs, IPs, file hashes) that need rapid triage
- Automated feeds deliver bulk IOCs that need confidence scoring before they're pushed into blocking controls
- An incident investigation needs contextual enrichment of observed network artifacts

**Do not use in isolation for high-stakes blocking decisions.** Always combine automated enrichment with analyst judgment, especially for shared infrastructure (CDNs, cloud load balancers) where blocking the IP can disrupt thousands of unrelated sites.

## Prerequisites

- VirusTotal API key (free tier is sufficient for low-volume lookups)
- AbuseIPDB API key for IP reputation checks
- Optional: MISP instance or other TIP for cross-referencing known campaigns

## Workflow

### Step 1: Normalize and classify

Before enriching anything, identify the IOC type and handle it accordingly:
- **IPv4/IPv6** — check if it's RFC 1918 private (skip external enrichment if so)
- **Domain/FQDN** — extract the registered domain; defang for safe handling (`evil[.]com`)
- **URL** — split into domain + path; watch for redirectors
- **File hash** — identify MD5/SHA-1/SHA-256; prefer SHA-256 for uniqueness
- **Email address** — split into domain (check MX/DMARC) and local part

Always defang IOCs in tickets and docs (`.` → `[.]`, `://` → `[://]`) so they can't be accidentally clicked or auto-scanned.

### Step 2: Multi-source enrichment

Query at least two independent sources — single-source scores lag behind new infrastructure and can all share the same blind spot:

- **VirusTotal** — multi-AV detection ratio, sandbox behavior, community comments (files, URLs, domains, IPs)
- **AbuseIPDB** — community abuse reports and confidence score (IPs)
- **MalwareBazaar** (abuse.ch) — malware family tagging and YARA associations (file hashes)

### Step 3: Campaign attribution

Cross-reference the IOC against a MISP instance or TIP for matching events, and check Shodan for IP context (hosting provider, open ports, banners) to rule out bulletproof-hosting vs. legitimate cloud provider.

### Step 4: Assign confidence and disposition

| Disposition | Criteria |
|---|---|
| **Block** (high confidence) | ≥15 AV detections on VT, AbuseIPDB score ≥70, or matches a known malware family/campaign |
| **Monitor/Alert** (medium) | 5–14 AV detections, moderate abuse score, no campaign attribution |
| **Investigate** (low) | ≤4 AV detections, no abuse reports, but not yet confirmed benign |
| **False Positive** | Legitimate service incorrectly flagged — document and exclude from future alerts |

### Step 5: Document and distribute

Record the enrichment data, disposition, rationale, and any blocking action taken (firewall, proxy, DNS sinkhole) against the related incident ticket. Set a TTL on any new block — IPs should expire after ~30 days and domains after ~90, since infrastructure gets repurposed by legitimate owners.

## Key Concepts

| Term | Definition |
|---|---|
| **Defanging** | Rewriting an IOC (`.` → `[.]`) so it can't be accidentally activated in docs or chat |
| **Enrichment** | Adding contextual data to a raw IOC from one or more intelligence sources |
| **Sinkhole** | A DNS server that redirects malicious domain lookups to a benign IP, enabling detection without an outright block |
| **TTL** | How long an IOC stays active in a blocking control before automatic expiry |

## Common Pitfalls

- **Blocking shared infrastructure** — Cloudflare/CloudFront IPs can host malicious content alongside thousands of legitimate sites; block the specific URL/domain, not the shared IP, when possible.
- **VT-score obsession** — zero-day malware and custom tooling often score 0 on first submission. Check sandbox behavior and passive DNS, not just the detection ratio.
- **Skipping defanging** — pasting live IOCs into tickets or chat can trigger automated link scanners or accidentally notify the attacker's infrastructure.
- **No expiration policy** — IOCs without a TTL accumulate indefinitely and start generating false positives once the infrastructure changes hands.

## Included Script

`scripts/ioc_enrichment.py` classifies an IOC (IPv4, domain, URL, hash, email), defangs/refangs it, and — if `VT_API_KEY` and/or `ABUSEIPDB_API_KEY` are set — queries VirusTotal, AbuseIPDB, and MalwareBazaar to produce a confidence score and disposition. Runs standalone with `python3 scripts/ioc_enrichment.py` (uses a small built-in demo set); import `enrich_ioc()` to use it on your own IOCs. Requires the `requests` package for live lookups.

## Related Skills

- skills/security/triaging-security-incident-with-ir-playbook — once an IOC is scored, use this to triage the alert it came from
