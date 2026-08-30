# INDEX-19 — Sicurezza informatica, OSINT e privacy

**Ambito.** Cybersecurity strutturata (MITRE ATT&CK, NIST), pentesting autonomo, ricognizione OSINT e igiene/privacy dei contenuti AI.

**Si attiva quando il task riguarda:** sicurezza informatica, hardening, pentest, analisi di una minaccia, OSINT su un soggetto, privacy e metadati dei file.

**Già installate localmente:** superpowers-skills: security/ (5 skill)

**Contenuto:** 4 repository, 823 skill.

## Come procedere

1. Leggi la tabella qui sotto e scegli **al massimo 2-3 skill** pertinenti al task.
2. Aprile con Read sul percorso completo (`.../SKILL.md`); se la skill è in un repo non ancora clonato, clonalo prima.
3. **Non caricare l'intera categoria**: questo indice esiste proprio per evitarlo.
4. Se nessuna skill copre il task, dillo e passa a `INDEX-01-cataloghi-skill.md` per cercarne una nuova.

## Repository della categoria

### Anthropic-Cybersecurity-Skills
- **Origine:** mukul975/Anthropic-Cybersecurity-Skills
- **Cosa offre:** 817 competenze strutturate di cybersecurity per agenti AI, mappate su MITRE ATT&CK, NIST CSF 2.0, D3FEND.
- **Inventario:** 817 skill
- **Skill:** gruppo unico piatto; esempi: abusing-dpapi-for-credential-access, abusing-shadow-credentials-for-privesc, achieving-cmmc-level-2-compliance, acquiring-disk-image-with-dd-and-dcfldd, analyzing-active-directory-acl-abuse, analyzing-android-malware-with-apktool, analyzing-api-gateway-access-logs, analyzing-apt-group-with-mitre-navigator, analyzing-azure-activity-logs-for-threats, analyzing-bootkit-and-rootkit-samples, analyzing-browser-forensics-with-hindsight, analyzing-campaign-attribution-evidence, …

### strix
- **Origine:** usestrix/strix
- **Cosa offre:** Tool AI open source per pentesting autonomo: agenti che analizzano applicazioni, trovano vulnerabilità e propongono correzioni; si integra in CI/CD e GitHub Actions.
- **Inventario:** 4 skill
- **Skill:** ci-security-scanning-with-strix, fix-security-vulnerabilities-with-strix, managed-pentesting-with-strix, penetration-testing-with-strix

### maigret
- **Origine:** soxoj/maigret
- **Cosa offre:** Strumento OSINT che raccoglie un dossier su una persona a partire dal solo username, verificando account su moltissimi siti.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### watermarks-remover
- **Origine:** guillaumemeyer/watermarks-remover
- **Cosa offre:** Skill per agenti + servizio Python che rimuove marcature di provenienza AI (watermark invisibili, C2PA/EXIF/XMP) da testo e file, per privacy e igiene dei contenuti; copre Claude, Gemini/SynthID, OpenAI.
- **Inventario:** 2 skill
- **Skill:** clean-user-facing-text, remove-ai-marks

