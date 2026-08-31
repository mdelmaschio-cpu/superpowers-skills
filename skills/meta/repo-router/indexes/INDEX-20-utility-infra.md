# INDEX-20 — Utility e infrastruttura tecnica

**Ambito.** Risorse generiche non legate a un dominio: API pubbliche, gestione media self-hosted, infrastruttura ML, siti web di esempio.

**Si attiva quando il task riguarda:** API pubbliche da integrare, gestione di foto/video self-hosted, infrastruttura ML, sito web statico.

**Contenuto:** 4 repository, 2 skill.

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

### public-apis
- **Origine:** public-apis/public-apis
- **Cosa offre:** Raccolta curata di API pubbliche gratuite organizzate per categoria, per scoprire e integrare servizi web senza costi iniziali.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### immich
- **Origine:** immich-app/immich
- **Cosa offre:** Soluzione self-hosted di gestione foto/video ad alte prestazioni, con backup automatico, riconoscimento facciale e ricerca intelligente.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### DeepEP
- **Origine:** deepseek-ai/DeepEP
- **Cosa offre:** Libreria di comunicazione ottimizzata per sistemi Mixture-of-Experts (MoE), con kernel GPU all-to-all ad alto throughput.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

### cocoweb
- **Origine:** CMarzin/cocoweb
- **Cosa offre:** Fork del sito/blog personale francese cocoweb.fr, sviluppato in Astro e Tailwind, con articoli e "tips" di sviluppo web. Unico repository dell'account senza attinenza tematica: fork esplorativo.
- **Inventario:** 2 skill
- **Skill:** blog-anchor-pattern, tips-draft-to-mdx

