# INDEX-16 — Presentazioni, editoria e video

**Ambito.** Produzione di deliverable visivi: PowerPoint nativi, slide HTML, tipografia/impaginazione, video programmatici.

**Si attiva quando il task riguarda:** produrre una presentazione, un deck, un documento impaginato, un libro, un video.

**Contenuto:** 5 repository, 4 skill.

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

### ppt-master
- **Origine:** hugohe3/ppt-master
- **Cosa offre:** Strumento open source basato su AI che trasforma documenti in presentazioni PowerPoint native e completamente modificabili.
- **Inventario:** 1 skill
- **Skill:** ppt-master

### PPTAgent
- **Origine:** icip-cas/PPTAgent
- **Cosa offre:** Framework agentico che genera automaticamente presentazioni PowerPoint da documenti/testi/ricerche web, curando contenuto e coerenza visiva.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### frontend-slides
- **Origine:** zarazhangrui/frontend-slides
- **Cosa offre:** Crea presentazioni HTML accattivanti senza competenze di design, con conversione anche da PowerPoint.
- **Inventario:** 2 skill
- **Skill:** (skill unica alla radice), frontend-slides

### quarkdown
- **Origine:** iamgio/quarkdown
- **Cosa offre:** Sistema di composizione tipografica basato su Markdown esteso con funzioni/scripting, per libri, paper accademici e presentazioni.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### remotion-video-skill
- **Origine:** wshuyi/remotion-video-skill
- **Cosa offre:** Skill per Claude che crea video programmatici con React/Remotion, con supporto TTS e animazioni automatiche.
- **Inventario:** 1 skill
- **Skill:** (skill unica alla radice)

