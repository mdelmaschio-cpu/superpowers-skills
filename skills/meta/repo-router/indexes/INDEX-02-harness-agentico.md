# INDEX-02 — Harness, metodologia e workflow agentici

**Ambito.** I motori di lavoro dell'agente: come struttura brainstorming, piani, TDD, subagenti e verifica. Da caricare quando il task riguarda COME lavorare, non su cosa.

**Si attiva quando il task riguarda:** come impostare il lavoro: brainstorming prima di scrivere codice, piano di implementazione, TDD, subagenti, worktree git, code review, verifica prima di dichiarare finito.

**Già installate localmente:** superpowers-skills: collaboration/ (10), debugging/ (4), testing/ (3), meta/ (5), problem-solving/ (6), research/ (1), architecture/ (1), using-skills/ (1) — sono le skill già attive in sessione

**Contenuto:** 8 repository, 431 skill.

## Come procedere

1. Leggi la tabella qui sotto e scegli **al massimo 2-3 skill** pertinenti al task.
2. Aprile con Read sul percorso completo (`.../SKILL.md`); se la skill è in un repo non ancora clonato, clonalo prima.
3. **Non caricare l'intera categoria**: questo indice esiste proprio per evitarlo.
4. Se nessuna skill copre il task, dillo e passa a `INDEX-01-cataloghi-skill.md` per cercarne una nuova.

## Repository della categoria

### superpowers
- **Origine:** obra/superpowers
- **Cosa offre:** Metodologia/plugin con competenze composabili per coding agent (brainstorming, TDD, planning, code review).
- **Inventario:** 14 skill
- **Skill:** brainstorming, dispatching-parallel-agents, executing-plans, finishing-a-development-branch, receiving-code-review, requesting-code-review, subagent-driven-development, systematic-debugging, test-driven-development, using-git-worktrees, using-superpowers, verification-before-completion, writing-plans, writing-skills

### superpowers-skills
- **Origine:** obra/superpowers-skills
- **Cosa offre:** Libreria di skill modificabile dalla community per il plugin "superpowers" di Claude Code — il repository di riferimento di questo progetto.
- **Inventario:** 103 skill
- **Skill:** architecture-design (39); context-engineering (15); collaboration (10); legal (10); problem-solving (6); meta (5); security (5); debugging (4); testing (3); cad (2); architecture (1); document-processing (1); +2 altri gruppi

### ecc
- **Origine:** affaan-m/ECC
- **Cosa offre:** "Agent harness operating system": harness multi-piattaforma (Claude Code, Codex, Cursor, Gemini, Zed, Kiro, Qwen, Trae...) con skill, agenti, comandi, hook, scaffold, workflow e plugin, distribuito anche come pacchetti npm ecc-universal / ecc-agentshield.
- **Inventario:** 288 skill, 353 agenti, 424 comandi
- **Skill:** (radice) (325); docs/ja-JP (229); docs/zh-CN (183); .kiro (43); docs/es (38); docs/tr (38); docs/zh-TW (16); docs/ko-KR (15); .cursor (11)

### p3-mattpocock-harness
- **Origine:** liang030502-prog/p3-mattpocock-harness
- **Cosa offre:** Plugin che integra metodologie agili (TDD, revisione progettuale, generazione documentazione) in cicli test-implementazione strutturati.
- **Inventario:** 1 skill
- **Skill:** (skill unica alla radice)

### skills
- **Origine:** mattpocock/skills
- **Cosa offre:** Raccolta personale di skill orientate all'ingegneria software reale (es. /tdd, /diagnose) per mantenere qualità e controllo nel dev assistito da IA.
- **Inventario:** 22 skill
- **Skill:** engineering (9); deprecated (4); misc (4); productivity (3); personal (2)

### sol-advisor
- **Origine:** DannyMac180/sol-advisor
- **Cosa offre:** Workflow di orchestrazione solo per Codex (non Claude Code): plugin "capability-routed" con quattro route (solo/delegate/audit/full), tre agenti implementatori/revisori e script di verifica e installazione.
- **Inventario:** 1 skill, 4 agenti
- **Skill:** orchestration

### autoresearch
- **Origine:** uditgoenka/autoresearch
- **Cosa offre:** Trasforma Claude/OpenCode/Codex in un motore di auto-miglioramento iterativo per ottimizzare metriche di codice senza intervento manuale continuo.
- **Inventario:** 1 skill, 2 agenti, 15 comandi
- **Skill:** autoresearch

### llm-council-skill
- **Origine:** gcpdev/llm-council-skill
- **Cosa offre:** Skill che fa consultare a Claude simultaneamente ChatGPT e Gemini per ottenere più prospettive prima di sintetizzare piani implementativi.
- **Inventario:** 1 skill
- **Skill:** llm-council

