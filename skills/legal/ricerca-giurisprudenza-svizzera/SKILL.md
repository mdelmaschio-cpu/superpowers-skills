---
name: Ricerca Giurisprudenza Svizzera
description: Metodologia strutturata per la ricerca di decisioni del Tribunale federale svizzero (BGE/ATF) e dottrina rilevante
when_to_use: when cercare giurisprudenza svizzera, trovare sentenze del Tribunale federale, citare BGE o ATF, ricercare precedenti per una questione di diritto svizzero, trovare dottrina CO o CC, verificare l'orientamento giurisprudenziale del TF, trovare sentenze cantonali svizzere, analizzare evoluzione giurisprudenziale su un istituto del CO
version: 1.0.0
languages: all
---

# Ricerca Giurisprudenza Svizzera

## Principio fondamentale

La giurisprudenza svizzera non ha valore di precedente vincolante (no stare decisis), ma il Tribunale federale (TF) si discosta raramente dalla propria giurisprudenza consolidata. I BGE sono le decisioni di principio; le decisioni non pubblicate (ATF non pubblicate) hanno valore inferiore.

## Struttura della citazione BGE/ATF

```
BGE [volume] [sezione] [pagina]
ATF [volume] [sezione] [pagina]  ← francese (identici ai BGE)
```

Esempio: `BGE 144 III 93` = Volume 144, Sezione III (diritto privato), pagina 93.

**Sezioni del TF rilevanti per CO/CC:**
- **I diritto civile** — diritti reali, diritto di famiglia, successioni (CC)
- **II diritto civile** — diritto delle obbligazioni, diritto commerciale (CO)
- **III diritto civile** — esecuzione e fallimenti (LEF), previdenza professionale

## Fase 1 — Definire la questione giuridica

Prima di cercare, formulare la questione in modo preciso:
1. Qual è l'istituto giuridico in questione? (es. clausola penale, recesso, responsabilità del mandatario)
2. Quali articoli CO/CC sono probabilmente coinvolti?
3. In quale contesto fattuale? (B2B, B2C, contratto di lavoro, ecc.)
4. Quale aspetto è controverso? (validità, interpretazione, conseguenze)

## Fase 2 — Fonti e strumenti di ricerca

**Fonti primarie gratuite:**
- `bger.ch` — tutte le decisioni TF dal 2000; motore di ricerca full-text
- `swisslex.ch` — BGE dal 1875, accesso istituzionale
- `entscheidsuche.ch` — aggregatore di decisioni cantonali e federali

**Ricerca su bger.ch:**
```
Procedura:
1. Selezionare "Giurisprudenza" → "Ricerca per testo"
2. Inserire articolo CO (es. "Art. 100 OR" o "art. 100 CO")
3. Filtrare per data e sezione
4. Verificare se la decisione è pubblicata in BGE (= decisione di principio)
```

**Parole chiave efficaci:**
- Usare termini tecnici tedeschi (lingua predominante nella dottrina CO): es. "Vertragsstrafe" (clausola penale), "Haftungsausschluss" (esclusione responsabilità), "Wandelung" (risoluzione per vizi)
- Usare sia la versione italiana che quella tedesca/francese dell'istituto

## Fase 3 — Valutazione della decisione trovata

Per ogni BGE/ATF identificato, verificare:

| Criterio | Da controllare |
|----------|---------------|
| **Pubblicazione** | BGE pubblicato > decisione non pubblicata |
| **Data** | Decisioni più recenti prevalgono, salvo mutamento esplicito |
| **Vincolatività interna** | Il TF si discosta raramente dalla giurisprudenza delle Sezioni unite (art. 23 LTF) |
| **Ratio decidendi** | Isolare il principio giuridico dal caso specifico |
| **Obiter dicta** | Annotare ma non equiparare alla ratio |
| **Dottrina citata** | Spesso il TF cita i commentari — identificare l'autore di riferimento |

## Fase 4 — Dottrina

**Commentari CO di riferimento:**
- **Commentario basilese (BSK OR)** — Honsell/Vogt/Wiegand, de Gruyter — il più autorevole
- **Commentario bernese (BK OR)** — Berner Kommentar — analitico, storico
- **Commentario zurighese (ZK OR)** — Zürcher Kommentar
- **CHK Handkommentar** — compatto, pratico per ricerca rapida

**Per versione italiana:**
- **Commentario al Codice delle obbligazioni** — Gauch/Schluep/Schmid trad. it.
- Articoli su `sic!` (rivista), `AJP/PJA`, `RNDS` per giurisprudenza recente

## Fase 5 — Struttura del risultato della ricerca

Presentare la ricerca in questo formato:

```
QUESTIONE: [formulazione precisa]
ARTICOLI: [lista art. CO/CC coinvolti]

GIURISPRUDENZA PRINCIPALE:
- BGE [citazione]: [principio giuridico estratto, 1-2 frasi]
- BGE [citazione]: [principio — eventuale sviluppo rispetto alla precedente]

TENDENZA ATTUALE: [orientamento prevalente del TF]

DOTTRINA: [autore, opera, marginalino — posizione]

PUNTI APERTI / CONTROVERSIE DOTTRINALI: [se esistono]
```

## Esempio

**Questione**: Riduzione giudiziale della clausola penale manifestamente eccessiva.

**Articolo**: art. 163 cpv. 3 CO.

**Ricerca**: BGE 133 III 201 — il giudice deve ridurre d'ufficio la pena manifestamente eccessiva; criterio: confronto tra pena e danno effettivo o prevedibile. BGE 114 II 264 — la pena non deve essere sproporzionata rispetto all'interesse del creditore alla prestazione.

**Dottrina**: BSK OR I-Ehrat, art. 163 N 14 ss.: il TF applica il criterio del "manifesto eccesso" con discrezionalità ampia.

## Segnali d'allarme

- Citare una decisione non pubblicata come equivalente a un BGE
- Non distinguere ratio decidendi da obiter dictum
- Utilizzare solo la versione italiana degli istituti ignorando la terminologia tedesca dominante
- Non verificare se una decisione è stata successivamente superata (usare bger.ch per cercare citazioni della stessa sentenza)
- Ignorare il numero della sezione TF (la sezione I e II civile hanno giurisprudenze distinte)

## Riferimenti incrociati

- `skills/legal/parere-legale` — per inserire correttamente la giurisprudenza trovata in un parere
- `skills/legal/analisi-contratto-co` — quando la ricerca serve a valutare la validità di una clausola
