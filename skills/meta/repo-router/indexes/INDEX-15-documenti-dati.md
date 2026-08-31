# INDEX-15 — Documenti: conversione, parsing, OCR e fogli di calcolo

**Ambito.** Trasformare formati in testo lavorabile dall'LLM e manipolare dati tabellari: Word/PDF/Excel/EPUB -> Markdown, OCR avanzato, generazione XLSX.

**Si attiva quando il task riguarda:** convertire o leggere documenti (Word, PDF, Excel, EPUB, immagini scansionate), OCR, estrarre tabelle, generare o modificare fogli di calcolo.

**Già installate localmente:** superpowers-skills: document-processing/ (1 skill: convert-documents-to-markdown)

**Contenuto:** 5 repository, 2 skill.

## Come procedere

1. Leggi la tabella qui sotto e scegli **al massimo 2-3 skill** pertinenti al task.
2. Se la skill sta in un repository non ancora sul disco, recuperalo con
   `~/.claude/skills/skill-select/scripts/skill-select fetch <repo>` (percorso intero:
   lo script non è nel PATH). **Non clonare a mano**: perderesti la cache condivisa,
   e su una home con spazi o apostrofi il clone diretto può riuscire in apparenza
   senza scrivere nulla — `skill-select` sceglie un percorso sicuro e se ne accorge.
3. Apri con Read, sul percorso completo (`.../SKILL.md`), le skill scelte e nessun'altra.
4. **Non caricare l'intera categoria**: questo indice esiste proprio per evitarlo.
5. Se nessuna skill copre il task, dillo e passa a `INDEX-01-cataloghi-skill.md` per cercarne una nuova.

## Repository della categoria

### anydoc
- **Origine:** firecrawl/anydoc
- **Cosa offre:** Libreria Rust ad alte prestazioni che converte documenti (Word, PowerPoint, Excel, PDF, EPUB, CSV) in Markdown pulito per LLM; distribuita anche come Agent Skill, con binding Node.js/Python/WASM.
- **Inventario:** 1 skill
- **Skill:** convert-documents-to-markdown

### markitdown
- **Origine:** microsoft/markitdown
- **Cosa offre:** Utilità Python che converte vari formati (PDF, PPT, Word, Excel, immagini, audio) in Markdown per l'uso con LLM.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### chandra
- **Origine:** datalab-to/chandra
- **Cosa offre:** Modello OCR avanzato che converte immagini e PDF (tabelle, formule, testo manoscritto, 90+ lingue) in HTML/Markdown/JSON.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### xlsx-populate
- **Origine:** dtjohnson/xlsx-populate
- **Cosa offre:** Libreria JavaScript per leggere, modificare e generare file Excel (XLSX) in Node.js e browser, preservando stili esistenti.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### notebooklm-py
- **Origine:** teng-lin/notebooklm-py
- **Cosa offre:** API Python non ufficiale per l'accesso programmatico a NotebookLM di Google, utile per automatizzare flussi di ricerca/contenuti.
- **Inventario:** 1 skill
- **Skill:** (skill unica alla radice)

