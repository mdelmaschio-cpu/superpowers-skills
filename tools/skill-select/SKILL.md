---
name: skill-select
description: Recupera su disco i repository GitHub personali (mdelmaschio-cpu) che contengono una skill scelta, e risolve una categoria in un file-indice del repo-router. Use when the user names a category or an INDEX-NN file, asks to "carica la categoria X", "attiva il gruppo Y", "usa le skill di Z", or when a skill named by an index lives in a repository not yet cloned locally. Non carica mai una categoria in blocco.
version: 2.1.0
when_to_use: when a task needs one of the personal GitHub skills and the repository holding it is not on disk yet, or when the user names a category ("carica la categoria sicurezza") or an index file ("usa INDEX-07-diritto-svizzero.md")
---

# skill-select

Esecutore del `repo-router`. Il router decide **quale** skill serve; questa skill la **mette su disco**.

Non possiede una propria mappa delle categorie. La tassonomia sta in un unico posto:
`repo-router/indexes/`. Se qui dentro trovi un elenco di categorie o di repository, è un bug:
va letto l'indice, non memorizzato.

## Regola non negoziabile

**Mai caricare una categoria in blocco.** Nessun `cat` su una cartella di skill, nessun
"leggi tutte le skill di X". Il tetto è **3 file SKILL.md per task**. Le categorie vanno da
1 a 1.854 skill: caricarne una intera esaurisce il contesto prima che il task cominci.

Se ti accorgi di stare per leggere il quarto SKILL.md, fermati e chiedi al partner umano
quale dei candidati vuole.

## Procedura

### 1. Trova l'indice giusto

```bash
scripts/skill-select index                 # elenca i 20 indici disponibili
scripts/skill-select index diritto         # cerca l'indice per parola chiave
```

Se il partner umano ha già nominato un file (`INDEX-07-diritto-svizzero.md`), salta la
ricerca e leggilo direttamente. Se non ha nominato nulla, leggi prima
`repo-router/SKILL.md` e usa la sua tabella di instradamento.

### 2. Leggi **quel solo** indice

Con Read, sul percorso completo che `skill-select index` ha stampato. L'indice elenca i
repository della categoria e i nomi delle skill che contengono: basta a scegliere, senza
aprire nulla.

### 3. Scegli al massimo 2-3 skill, poi recupera i repo che le contengono

```bash
scripts/skill-select fetch superpowers-swisslegal-skills
scripts/skill-select fetch bonsai-bim-skills editor        # più repo insieme
```

Stampa il percorso locale di ciascuno. Se il repository è già in cache lo riusa senza
scaricare niente; con `--update` forza un aggiornamento da GitHub.

I repository privati richiedono credenziali git già configurate sulla macchina: se il
clone fallisce con 403/404, **dillo** invece di ripiegare su una skill diversa.

### 4. Localizza il file e leggilo

```bash
scripts/skill-select find analisi-contratto        # cerca fra i repo già in cache
```

Poi Read sul percorso, e annuncia: «Ho letto la skill *X* da *repo*, la uso per *scopo*».

## Se qualcosa manca

- **Router assente** (`repo-router/indexes/` non trovato) → dillo. Il router arriva con
  `superpowers-skills`; senza, questa skill non ha una tassonomia da cui partire e non deve
  inventarne una.
- **Nessuna skill pertinente nell'indice** → dillo e passa a `INDEX-01-cataloghi-skill.md`,
  che è la categoria dei cataloghi da cui si cercano competenze non ancora possedute.
- **Repository nuovo non catalogato** → gli indici non si aggiornano da soli. Segnalalo:
  va rigenerato l'indice della categoria in `superpowers-skills` e ricommittato.

## Dove sono le cose

| | |
|---|---|
| Tassonomia (fonte unica) | `repo-router/` sotto `$SUPERPOWERS_SKILLS_ROOT` (default `~/.config/superpowers/skills`). Lo script sonda da solo i due layout possibili: radice del repository (`…/skills/meta/repo-router/`) e cartella skills già scompattata (`…/meta/repo-router/`). |
| Cache dei repository | `~/.claude/skill-select-cache/` |
| Origine dei repository | `https://github.com/mdelmaschio-cpu/<nome>` |

## Cosa è cambiato dalla v1

La v1 aveva un `categories.json` con 10 categorie e 72 repository, e clonava **tutti** i
repository di una categoria caricandone le skill. Entrambe le cose erano sbagliate: la mappa
si è disallineata (oggi le categorie sono 20 e i repository 76) e il caricamento in blocco
non entra nel contesto. La v2 non duplica la mappa e recupera solo i repository delle skill
effettivamente scelte.
