---
name: Repo Router
description: Router leggero sull'inventario dei 76 repository GitHub personali - instrada un task alla categoria giusta e carica un solo file-indice invece dell'intera libreria.
when_to_use: when the user names an INDEX-NN file, asks which of their own repositories or skills apply to a task, or starts a task in one of their domains (diritto svizzero, norme SIA, architettura, cantiere, BIM, contabilita' ticinese, marketing, documenti, sicurezza) and you need to find the right skill without loading everything
version: 1.0.0
languages: all
---

# Repo Router

Instrada un task verso **una sola** categoria dell'inventario GitHub personale (76 repository, 4.210 skill) e carica il relativo file-indice.

## Regola operativa

1. **Se il partner umano nomina un file `INDEX-NN-...md`** → leggilo subito con Read da `indexes/` e salta la tabella.
2. **Altrimenti** → confronta il task con la tabella qui sotto, scegli **una** categoria (al massimo due se il task è davvero ibrido) e leggi quel solo indice.
3. Dall'indice apri **2-3 skill al massimo**. Mai l'intera categoria.
4. Se il repository che le contiene non è sul disco, recuperalo con
   `~/.claude/skills/skill-select/scripts/skill-select fetch <repo>` — percorso intero, lo script non è nel PATH —
   mai con un `git clone` scritto a mano: la cache condivisa e la scelta di un percorso sicuro stanno lì.
5. Annuncia sempre quale indice hai letto e quali skill hai aperto.

**Perché:** caricare in blocco una categoria come `INDEX-01` (1.854 skill) o `INDEX-19` (823) satura il contesto prima ancora di iniziare. L'indice pesa poche centinaia di righe; le skill vere si aprono solo quando servono.

## Tabella di instradamento

| Se il task riguarda... | Leggi |
|---|---|
| non so se esiste già una skill per X; cercare/valutare/installare una skill o un plugin nuovo; "c’è qualcosa che fa Y?"; confronto fra raccolte | `indexes/INDEX-01-cataloghi-skill.md` |
| come impostare il lavoro: brainstorming prima di scrivere codice, piano di implementazione, TDD, subagenti, worktree git, code review, verifica prima di dichiarare finito | `indexes/INDEX-02-harness-agentico.md` |
| far lavorare più agenti in parallelo su un deliverable complesso; swarm; pipeline di agenti; report/presentazione/video generati da un solo comando | `indexes/INDEX-03-multi-agente.md` |
| la sessione è lunga e perde contesto; recuperare cosa è stato deciso in sessioni precedenti; ridurre i token; memoria persistente; grafo di conoscenza | `indexes/INDEX-04-contesto-memoria.md` |
| scrivere o migliorare un prompt per un tool AI specifico (Cursor, Midjourney, Sora, ChatGPT, v0...); libreria di prompt pronti | `indexes/INDEX-05-prompt-engineering.md` |
| revisione di codice, qualità, debito tecnico, capire una codebase estranea, scelte di architettura software, pattern e principi di design | `indexes/INDEX-06-codice-qualita.md` |
| diritto svizzero: CC, CO, CPC, LEF, LDIP, diritto contabile; analisi o redazione di clausole contrattuali; parere legale; due diligence; giurisprudenza BGE/ATF | `indexes/INDEX-07-diritto-svizzero.md` |
| contratti in generale (non svizzeri), NDA, clausole di rischio, compliance, privacy, contenzioso, governance AI | `indexes/INDEX-08-legal-tech.md` |
| contabilità societaria, chiusura, bilancio, fiscalità e amministrazione aziendale in Ticino | `indexes/INDEX-09-contabilita-fiscale.md` |
| norme SIA (102/103/118), AEAI antincendio, codici costo BKP/CCC, posizioni CPN/NPK, LAINF/AVS/LPP di cantiere, capitolati e preventivi svizzeri | `indexes/INDEX-10-norme-sia.md` |
| progetto di architettura, analisi del sito, zoning e urbanistica, due diligence immobiliare, programma degli spazi, ricerca materiali, EPD e carbonio incorporato | `indexes/INDEX-11-architettura-urbanistica.md` |
| impresa generale o subappalto: computi e BOQ, preventivi di costruzione, gare e procurement, programma lavori 4D/5D, direzione cantiere, controllo difetti | `indexes/INDEX-12-cantiere-costi.md` |
| modellare in BIM o CAD: IFC, Bonsai/Blender, FreeCAD, pianta, muri, solai, facciate, tavole 2D, modello 3D di edificio | `indexes/INDEX-13-bim-cad-3d.md` |
| contenuti di marketing, posizionamento SEO o GEO, campagne, creatività pubblicitarie, copy commerciale | `indexes/INDEX-14-marketing-seo.md` |
| convertire o leggere documenti (Word, PDF, Excel, EPUB, immagini scansionate), OCR, estrarre tabelle, generare o modificare fogli di calcolo | `indexes/INDEX-15-documenti-dati.md` |
| produrre una presentazione, un deck, un documento impaginato, un libro, un video | `indexes/INDEX-16-presentazioni-video.md` |
| progettare o migliorare un'interfaccia, design system, audit di usabilità, trasformare uno screenshot o un mockup in codice | `indexes/INDEX-17-design-frontend.md` |
| il testo suona artificiale, va reso naturale, riscritto o valutato stilisticamente | `indexes/INDEX-18-scrittura-tono.md` |
| sicurezza informatica, hardening, pentest, analisi di una minaccia, OSINT su un soggetto, privacy e metadati dei file | `indexes/INDEX-19-sicurezza-osint.md` |
| API pubbliche da integrare, gestione di foto/video self-hosted, infrastruttura ML, sito web statico | `indexes/INDEX-20-utility-infra.md` |

## Categorie in sintesi

| # | Categoria | Repo | Skill | File-indice |
|---|---|---:|---:|---|
| 01 | Cataloghi e marketplace di skill | 11 | 1854 | `INDEX-01-cataloghi-skill.md` |
| 02 | Harness, metodologia e workflow agentici | 8 | 431 | `INDEX-02-harness-agentico.md` |
| 03 | Orchestrazione multi-agente | 5 | 254 | `INDEX-03-multi-agente.md` |
| 04 | Context engineering, memoria e ottimizzazione token | 6 | 40 | `INDEX-04-contesto-memoria.md` |
| 05 | Prompt engineering | 2 | 5 | `INDEX-05-prompt-engineering.md` |
| 06 | Revisione codice, qualità e architettura software | 5 | 9 | `INDEX-06-codice-qualita.md` |
| 07 | Diritto svizzero — fonti normative e pratica | 1 | 11 | `INDEX-07-diritto-svizzero.md` |
| 08 | Contrattualistica e legal-tech generale | 3 | 133 | `INDEX-08-legal-tech.md` |
| 09 | Contabilità, fiscalità e amministrazione (Ticino/CH) | 1 | 2 | `INDEX-09-contabilita-fiscale.md` |
| 10 | Norme edilizie svizzere, contratti SIA e costi BKP/CPN | 1 | 1 | `INDEX-10-norme-sia.md` |
| 11 | Architettura, urbanistica e due diligence immobiliare | 2 | 333 | `INDEX-11-architettura-urbanistica.md` |
| 12 | Costruzione, cantiere e cost management (GC/subappalto) | 1 | 231 | `INDEX-12-cantiere-costi.md` |
| 13 | BIM, CAD e modellazione 3D | 2 | 7 | `INDEX-13-bim-cad-3d.md` |
| 14 | Marketing, SEO e advertising | 4 | 57 | `INDEX-14-marketing-seo.md` |
| 15 | Documenti: conversione, parsing, OCR e fogli di calcolo | 5 | 2 | `INDEX-15-documenti-dati.md` |
| 16 | Presentazioni, editoria e video | 5 | 4 | `INDEX-16-presentazioni-video.md` |
| 17 | Design UI/UX e frontend | 4 | 9 | `INDEX-17-design-frontend.md` |
| 18 | Scrittura, editing e tono di voce | 2 | 2 | `INDEX-18-scrittura-tono.md` |
| 19 | Sicurezza informatica, OSINT e privacy | 4 | 823 | `INDEX-19-sicurezza-osint.md` |
| 20 | Utility e infrastruttura tecnica | 4 | 2 | `INDEX-20-utility-infra.md` |

## Se nessuna categoria calza

Dillo esplicitamente invece di forzare un instradamento sbagliato, poi leggi `indexes/INDEX-01-cataloghi-skill.md`: è la categoria dei cataloghi, e serve proprio a cercare una competenza che non si possiede ancora.

