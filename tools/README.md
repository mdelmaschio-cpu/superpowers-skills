# tools/

Roba che **non** è una skill di questa libreria e non va caricata dal plugin superpowers.
Vive qui solo per essere versionata; si installa altrove.

Perciò `tools/` sta fuori da `skills/`: quello che finisce sotto `skills/` viene caricato
dal plugin, e queste non devono esserlo.

## skill-select

Skill a livello utente per Claude Code. Fa da esecutore a `skills/meta/repo-router/`:
il router decide *quale* skill serve, `skill-select` mette su disco il repository che la
contiene. Non possiede una propria tassonomia — la legge dagli indici del router, così la
mappa delle categorie esiste in un posto solo.

### Installazione

```bash
cd ~/.config/superpowers/superpowers-skills-git && git pull origin main
mkdir -p ~/.claude/skills
cp -r tools/skill-select ~/.claude/skills/
chmod +x ~/.claude/skills/skill-select/scripts/skill-select
```

Poi riavvia Claude Code: le skill in `~/.claude/skills/` si leggono all'avvio della sessione.

Verifica che trovi il router:

```bash
~/.claude/skills/skill-select/scripts/skill-select index
```

Deve elencare i 20 indici. Lo script sonda da solo i layout possibili — radice del
repository (`…/skills/meta/repo-router/`) oppure cartella `skills/` già scompattata
(`…/meta/repo-router/`) — e onora `SUPERPOWERS_SKILLS_ROOT` se il router è altrove.

### Cache dei repository

Di default `~/.claude/skill-select-cache`. Se `$HOME` contiene spazi o apostrofi — su
Windows è la norma — la cache passa a `/c/Users/Public/skill-select-cache`: con quei
caratteri nel percorso `git.exe` e bash divergono, `git clone` esce con successo e i file
non compaiono dove bash li cerca. Lo script se ne accorge e lo dice; per scegliere il
percorso a mano, esporta `SKILL_SELECT_CACHE`.

### Aggiornamento

Stesso comando dell'installazione: `git pull` e ricopia. Non aggiornarlo modificando
la copia in `~/.claude/skills/`, altrimenti le due divergono e si torna al problema che
questa versione è nata per risolvere.
