# Security Skills - Attribution

This skill collection was curated and adapted from [Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills) by mukul975.

**Source Repository:**
- Name: Anthropic-Cybersecurity-Skills
- URL: https://github.com/mukul975/Anthropic-Cybersecurity-Skills
- Commit: 7eebca88aa7e5bf723cabbb7c441f3d83b4779cd
- Date: 2026-06-20
- License: Apache-2.0

## Skills Derived

**5 skills selected from the source repository's larger library (754 skills across 26 domains), favoring defensive/blue-team workflows:**

- `analyzing-indicators-of-compromise` — Classify, defang, and enrich IOCs (IPs, domains, hashes, URLs) with threat intelligence to assign block/monitor/investigate dispositions
- `triaging-security-incident-with-ir-playbook` — Classify alerts by incident type, assign severity, and select the matching IR playbook and escalation path
- `prioritizing-vulnerabilities-with-cvss-scoring` — Calculate CVSS base scores and combine them with EPSS/CISA KEV data to risk-rank vulnerabilities for remediation
- `detecting-business-email-compromise` — Detect BEC indicators in email headers and content (impersonation, auth failures, financial urgency)
- `hardening-linux-endpoint-with-cis-benchmark` — Harden Linux endpoints against CIS Benchmark controls and verify compliance with OpenSCAP

## What Was Adapted

Each skill was rewritten into superpowers-skills' `SKILL.md` format: frontmatter reduced to this repo's convention (`name`, `description`, `when_to_use`, `version`, `languages`), dropping the source's supplementary AI/ML-oriented metadata (`atlas_techniques`, `nist_ai_rmf`, `mitre_f3`, `d3fend_techniques`) since this repo doesn't carry that schema, while folding the most useful `mitre_attack`/`nist_csf` references into the body text instead. Workflow steps, key-concepts tables, and common-pitfalls sections were condensed and reformatted but kept technically faithful to the source.

Each source skill included one or two supporting Python scripts (named generically `agent.py`/`process.py`). Every script was read in full and reviewed before inclusion — all were confirmed to be read-only enrichment, classification, scoring, or local-audit tools with no destructive actions, no credential exfiltration, and no offensive/exploit capability. Where a skill had two overlapping scripts, only one was ported (renamed to a descriptive filename) to avoid shipping redundant files; the other's useful ideas were folded into the SKILL.md workflow text instead. For `prioritizing-vulnerabilities-with-cvss-scoring`, the ported script uses the official CVSS v3.1 base-score formula rather than the source's alternate CVSS v4.0 script, which was itself labeled a "simplified approximation" and would have produced scores disagreeing with FIRST's official v4.0 calculator.

Selection favored defensive/educational domains (threat intelligence, incident response, vulnerability management, phishing defense, endpoint hardening) over offensive domains (red teaming, penetration testing) present in the source repository, consistent with this repository's focus on practical, broadly-safe operational skills.
