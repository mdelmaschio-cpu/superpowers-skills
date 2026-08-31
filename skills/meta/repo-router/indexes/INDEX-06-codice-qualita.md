# INDEX-06 — Revisione codice, qualità e architettura software

**Ambito.** Code review multi-agente, analisi a grafo della codebase, riferimenti di architettura e pattern di design.

**Si attiva quando il task riguarda:** revisione di codice, qualità, debito tecnico, capire una codebase estranea, scelte di architettura software, pattern e principi di design.

**Contenuto:** 5 repository, 9 skill.

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

### code-review-graph
- **Origine:** tirth8205/code-review-graph
- **Cosa offre:** Usa Tree-sitter e analisi a grafo per ridurre drasticamente i token nelle revisioni di codice AI, leggendo solo i file rilevanti su monorepo grandi.
- **Inventario:** 7 skill
- **Skill:** build-graph, debug-issue, explore-codebase, refactor-safely, review-changes, review-delta, review-pr

### claude-code-review-agent
- **Origine:** robinixbox/claude-code-review-agent
- **Cosa offre:** Agent autonomo basato su CrewAI e Claude API per automatizzare la revisione del codice nel flusso di lavoro GitHub.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### ultrareview
- **Origine:** th9rain/ultrareview
- **Cosa offre:** Workflow multi-agente di revisione codice: reviewer specializzati lavorano in parallelo e producono report strutturati per merge critici.
- **Inventario:** 1 skill
- **Skill:** (skill unica alla radice)

### graphify
- **Origine:** Graphify-Labs/graphify
- **Cosa offre:** Trasforma progetti software (codice, doc, PDF, immagini, video) in grafi di conoscenza interrogabili per comprendere meglio la codebase.
- **Inventario:** 1 skill
- **Skill:** graphify

### awesome-software-architecture
- **Origine:** mehdihadeli/awesome-software-architecture
- **Cosa offre:** Raccolta curata di articoli e risorse su architettura software, pattern e principi di design (microservizi, DDD, cloud native).
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

