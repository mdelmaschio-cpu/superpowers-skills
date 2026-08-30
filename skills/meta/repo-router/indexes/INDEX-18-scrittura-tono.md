# INDEX-18 — Scrittura, editing e tono di voce

**Ambito.** Rendere il testo naturale e non riconoscibile come generato da AI; valutazione e riscrittura stilistica.

**Si attiva quando il task riguarda:** il testo suona artificiale, va reso naturale, riscritto o valutato stilisticamente.

**Contenuto:** 2 repository, 2 skill.

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

### humanizer
- **Origine:** blader/humanizer
- **Cosa offre:** Rimuove i "segni" tipici della scrittura generata da AI per rendere il testo più naturale.
- **Inventario:** 1 skill
- **Skill:** (skill unica alla radice)

### stop-slop
- **Origine:** drm-collab/stop-slop
- **Cosa offre:** Valuta un testo su 5 dimensioni e lo riscrive per rimuovere i pattern tipici della scrittura AI, per suonare più umano.
- **Inventario:** 1 skill
- **Skill:** (skill unica alla radice)

