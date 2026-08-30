# INDEX-04 — Context engineering, memoria e ottimizzazione token

**Ambito.** Memoria persistente tra sessioni, grafi di conoscenza, compressione del contesto e teoria del context engineering. Da caricare su sessioni lunghe o quando serve continuità tra conversazioni.

**Si attiva quando il task riguarda:** la sessione è lunga e perde contesto; recuperare cosa è stato deciso in sessioni precedenti; ridurre i token; memoria persistente; grafo di conoscenza.

**Già installate localmente:** superpowers-skills: context-engineering/ (15 skill)

**Contenuto:** 6 repository, 40 skill.

## Come procedere

1. Leggi la tabella qui sotto e scegli **al massimo 2-3 skill** pertinenti al task.
2. Se la skill sta in un repository non ancora sul disco, recuperalo con
   `skill-select fetch <repo>`. **Non clonare a mano**: perderesti la cache condivisa,
   e su una home con spazi o apostrofi il clone diretto può riuscire in apparenza
   senza scrivere nulla — `skill-select` sceglie un percorso sicuro e se ne accorge.
3. Apri con Read, sul percorso completo (`.../SKILL.md`), le skill scelte e nessun'altra.
4. **Non caricare l'intera categoria**: questo indice esiste proprio per evitarlo.
5. Se nessuna skill copre il task, dillo e passa a `INDEX-01-cataloghi-skill.md` per cercarne una nuova.

## Repository della categoria

### claude-mem
- **Origine:** thedotmack/claude-mem
- **Cosa offre:** Sistema di memoria persistente che mantiene il contesto tra sessioni Claude, catturando osservazioni e generando riassunti semantici automatici.
- **Inventario:** 16 skill, 1 comandi
- **Skill:** babysit, design-is, do, how-it-works, knowledge-agent, learn-codebase, make-plan, mem-search, oh-my-issues, openclaw, pathfinder, smart-explore, timeline-report, version-bump, weekly-digests, wowerpoint

### cognee
- **Origine:** topoteretes/cognee
- **Cosa offre:** Piattaforma open source di "memoria AI" che costruisce grafi di conoscenza self-hosted per dare agli agenti memoria persistente tra sessioni.
- **Inventario:** 4 skill
- **Skill:** cognee, diff-risk-explainer, pr-comment-evaluator, skill-feedback-writer

### ai-memory-reader
- **Origine:** nvwalj/ai-memory-reader
- **Cosa offre:** App nativa macOS/iOS con interfaccia grafica per leggere, cercare e organizzare i file di memoria degli agenti IA (es. CLAUDE.md, trascrizioni).
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### headroom
- **Origine:** headroomlabs-ai/headroom
- **Cosa offre:** Comprime i dati inviati ad agenti AI/LLM riducendo i token del 60-95% mantenendo la qualità, per risparmiare sui costi.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### headroom-zed
- **Origine:** chopratejas/headroom-zed
- **Cosa offre:** Estensione che integra Headroom nell'editor Zed per comprimere il contesto e ridurre i token usati dall'agente AI di Zed.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### Agent-Skills-for-Context-Engineering
- **Origine:** muratcankoylan/Agent-Skills-for-Context-Engineering
- **Cosa offre:** Raccolta di skill sull'ingegneria del contesto per gestire la context window e costruire agenti IA di livello produttivo.
- **Inventario:** 20 skill, 2 agenti
- **Skill:** (skill unica alla radice), advanced-evaluation, bdi-mental-states, book-sft-pipeline, comprehensive-research-agent, context-compression, context-degradation, context-fundamentals, context-optimization, digital-brain-skill, evaluation, filesystem-context, hosted-agents, interleaved-thinking, latent-briefing, memory-systems, multi-agent-patterns, project-development, template, tool-design

