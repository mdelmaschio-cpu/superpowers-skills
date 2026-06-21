---
name: Detecting Business Email Compromise
description: Detect BEC indicators in email headers and content — executive impersonation, SPF/DKIM/DMARC failures, reply-to mismatches, and financial urgency language.
when_to_use: when a reported email shows executive or vendor impersonation, or an unexpected payment/bank-detail change request; when building detection rules for CEO fraud, invoice fraud, or account-compromise-driven BEC; when triaging a suspicious email that has no malicious link or attachment but reads as socially engineered; when reviewing SPF/DKIM/DMARC alignment on a reported phishing email
version: 1.0.0
languages: all
---

# Detecting Business Email Compromise

## Overview

Business Email Compromise is fraud by impersonation, not malware: an attacker poses as an executive, vendor, or trusted partner to get an employee to wire money, change payment details, or hand over sensitive data. Most BEC emails contain no link and no attachment, so signature- and sandbox-based defenses miss them entirely — detection has to rely on header analysis, behavioral baselines, and financial-process controls instead.

## When to Use

- An email impersonates an executive or vendor, or requests a payment/bank-detail change
- You're building detection rules or hunting queries for CEO fraud, invoice fraud, or account-compromise BEC
- A reported email has urgency/secrecy language but no malicious link or attachment
- You need to check SPF/DKIM/DMARC alignment and reply-to consistency on a suspicious message

## Prerequisites

- Email security gateway with header/content inspection (or raw `.eml` access)
- Understanding of the organization's financial approval chain
- A list of VIP names/titles to check for impersonation
- Access to email logs / SIEM for behavioral baselining

## Key Concepts

### BEC attack types (FBI IC3 classification)

| Type | Pattern |
|---|---|
| CEO Fraud | Attacker impersonates an executive, requests an urgent wire transfer |
| Account Compromise | A real employee mailbox is compromised and used to request payments from vendors |
| False Invoice Scheme | Fake vendor invoice with changed bank details |
| Attorney Impersonation | Poses as legal counsel demanding an urgent, confidential transfer |
| Data Theft | Requests W-2s, tax forms, or other PII from HR |

### Detection signals

- Urgency/secrecy language ("confidential," "don't discuss this with anyone," "handle today")
- New or changed payment instructions
- Display name matches an executive but the email domain doesn't
- Reply-To address differs from the From address
- First-time communication pattern between this sender and recipient
- Requests for gift cards or cryptocurrency

## Workflow

### Step 1: Check authentication alignment

Pull `Authentication-Results` and confirm SPF, DKIM, and DMARC all pass. A DMARC fail on a message claiming to be from an internal executive is a strong signal on its own.

### Step 2: Check for display-name spoofing

Compare the From display name against your VIP list. If it matches a VIP name but the email address resolves to an external domain, that's impersonation, not a typo.

### Step 3: Check Reply-To consistency

If a Reply-To header is present and its domain differs from the From domain, replies go somewhere the visible sender never intended — a common account-compromise and impersonation tell.

### Step 4: Scan for financial + urgency language

Neither signal alone is conclusive (legitimate finance emails are often urgent), but financial keywords (wire transfer, invoice, routing number, gift card) **combined with** urgency/secrecy language is a strong combined signal, especially paired with authority language ("I need you to," "I'm in a meeting, just handle it").

### Step 5: Apply financial controls independent of detection

Detection will never be 100% — backstop it with process controls:
- Dual authorization above a set wire-transfer threshold
- Out-of-band verification (phone callback to a known-good number) for any payment-detail change
- A documented vendor payment-change verification process
- Finance team training on BEC red flags

### Step 6: Watch for account-compromise follow-on signals

If account compromise (not just impersonation) is suspected, check for impossible-travel logins, newly created mail-forwarding rules, mailbox delegation changes, and inbox rules that hide messages from the real account owner — these are how a compromised account hides the fraud from its owner.

## Tools & Resources

- Microsoft Defender for Office 365 (built-in anti-BEC), Proofpoint Email Fraud Defense, Abnormal Security — commercial BEC-specific detection
- FBI IC3 BEC advisory (ic3.gov) and FinCEN BEC advisory — classification and reporting guidance

## Common Pitfalls

- **Relying on link/attachment scanning alone** — most BEC has neither.
- **Treating urgency language as sufficient on its own** — real urgent finance requests exist; look for the *combination* of urgency + financial + authority/impersonation signals.
- **Skipping the out-of-band callback** — a "confirmation" email reply to a compromised or spoofed thread proves nothing; verify through a separately-known channel.
- **No DMARC enforcement** — `p=none` DMARC policies don't actually block anything; without `p=quarantine`/`p=reject`, spoofed-domain BEC sails through.

## Included Script

`scripts/bec_email_analyzer.py` parses a raw `.eml` file (or a directory of them), checks SPF/DKIM/DMARC results, flags VIP display-name spoofing and Reply-To mismatches, scans the body for urgency/financial language, and produces a 0-100 BEC risk score. Run with `python3 scripts/bec_email_analyzer.py --email-file suspicious.eml --vip-names "Jane CEO" "John CFO"`.

## Related Skills

- skills/security/analyzing-indicators-of-compromise — enrich any URLs/domains that do appear alongside a BEC attempt
