---
name: Consiglio di Amministrazione
description: Convoca un consiglio di 5 agenti con ruoli opposti più un Presidente che dibattono in contraddittorio e producono un verdetto motivato con punteggio sulla validità di un progetto
when_to_use: when serve valutare la validità di un nuovo progetto, un'idea di business, una proposta o un investimento prima di impegnarci risorse; quando l'utente chiede "convoca il consiglio di amministrazione", "CDA", "board review", "valuta questo progetto", una decisione go/no-go, un'analisi pro e contro strutturata; quando un'analisi a voce singola rischia bias di conferma o entusiasmo non verificato
version: 1.0.0
languages: all
---

# Consiglio di Amministrazione

## Panoramica

Un solo agente che valuta un progetto tende a confermare il framing che riceve. Questo consiglio produce una decisione migliore forzando il conflitto: 5 membri agentici con mandati opposti formulano pareri indipendenti, si attaccano a vicenda in contraddittorio, e un Presidente valuta la qualità degli argomenti — non la loro quantità — emettendo verdetto motivato e punteggio.

**Principio fondamentale:** la qualità della decisione nasce dal conflitto strutturato tra ruoli distinti, non dal consenso. Se i pareri convergono senza scontro, il consiglio è fallito.

**Chi fa cosa:** tu (l'agente che orchestra) sei il **Segretario del consiglio**: prepari il dossier, lanci i subagenti, verifichi il rispetto delle regole, consegni la relazione. Il Segretario **non è un membro**: non esprime pareri, non corregge i pareri, non vota.

Per la meccanica di lancio dei subagenti vedi skills/collaboration/dispatching-parallel-agents.

## I sei ruoli

| Ruolo | Mandato | Divieto assoluto |
|-------|---------|------------------|
| **Pessimista** | Trovare e documentare ogni aspetto negativo: rischi, costi nascosti, punti di fallimento, concorrenza, assunzioni fragili | Bocciare senza prove: ogni obiezione richiede un'evidenza citabile |
| **Ottimista** | Trovare il potenziale positivo: opportunità, vantaggi competitivi, scenari di crescita | Promuovere su possibilità vaghe: ogni opportunità richiede un meccanismo concreto e una condizione verificabile |
| **Indipendente** | Verificare se è il progetto *giusto*: alternative, costo opportunità, coerenza con gli obiettivi dichiarati, timing | Giudicare solo se il progetto è "buono": il suo asse è "giusto rispetto a cosa" |
| **Neutro** | Valutare il progetto a freddo, senza alcun contesto: solo la descrizione sanificata, ragionando per principi primi e tassi di base | Ricevere o usare contesto (chi propone, entusiasmo, storia pregressa) |
| **Esecutore** | Definire cosa fare dopo in entrambi gli scenari: piano operativo in caso di successo E piano in caso di insuccesso (kill criteria, exit, cosa si salva) | Dare giudizi di merito sul progetto: valuta solo l'eseguibilità |
| **Presidente** | Valutare oggettivamente ogni parere, separare FATTI / IPOTESI / DATI MANCANTI, emettere verdetto motivato con punteggio da rubrica | Fare la media dei giudizi, contare i voti, o riassumere i pareri senza valutarli |

I membri **non esprimono punteggi numerici** — solo argomenti. Il punteggio esiste solo nella relazione del Presidente, derivato dalla rubrica. Così la media come scorciatoia non può esistere: non c'è niente da mediare.

## Regole del consiglio

1. **Onere della prova (Pessimista).** Ogni obiezione nel formato: `obiezione → evidenza (fatto del dossier, dato verificabile, precedente citabile) → gravità (1–5)`. Un'obiezione senza evidenza va etichettata `[SOSPETTO]`: resta a verbale ma non può motivare una bocciatura.
2. **Meccanismo concreto (Ottimista).** Ogni opportunità nel formato: `opportunità → meccanismo (come si realizza, passo per passo) → condizione verificabile (cosa deve risultare vero, misurabile)`. "Potenziale enorme", "mercato in crescita", "potrebbe scalare" senza meccanismo va etichettata `[AUSPICIO]`: non può motivare un'approvazione.
3. **Etichettatura obbligatoria.** Ogni membro marca ogni affermazione portante come `[FATTO]` (verificabile, con fonte), `[IPOTESI]` (plausibile ma non provata) o `[MANCANTE]` (dato necessario che non abbiamo).
4. **Isolamento del Neutro.** Il Neutro riceve solo il dossier sanificato. Se il suo parere cita informazioni non presenti in quella versione, il parere è contaminato e va rifatto.
5. **Il contraddittorio è obbligatorio.** Nessun parere arriva al Presidente senza essere passato dalla Fase 2. Un argomento mai attaccato è un argomento mai testato.
6. **Il Presidente pesa, non conta.** Un'obiezione fatale provata vale più di tre entusiasmi vaghi. La relazione deve dire quali argomenti sono stati decisivi, quali scartati, e perché.
7. **Subagenti reali, o niente consiglio.** Ogni membro è un subagente separato con il proprio contesto. Se non puoi lanciare subagenti, dichiaralo al tuo partner umano: sei ruoli recitati in un unico contesto contaminano il Neutro e rendono finto il contraddittorio.

## Processo

### Fase 0 — Dossier (Segretario)

Crea una directory di lavoro (es. `cda/<nome-progetto>/`) e scrivi due file:

- `dossier.md` — descrizione del progetto, obiettivi dichiarati del proponente, vincoli (budget, tempi, competenze), dati noti, domanda a cui il consiglio deve rispondere.
- `dossier-neutro.md` — la sola descrizione fattuale del progetto, spogliata di: chi lo propone e perché, aggettivi e toni promozionali, aspettative, storia pregressa. Rileggi e togli ogni parola che orienta il giudizio.

### Fase 1 — Pareri indipendenti (parallelo)

Lancia i 5 membri **in parallelo, in un unico messaggio**, ciascuno con il proprio prompt di ruolo (template sotto). Pessimista, Ottimista, Indipendente ed Esecutore ricevono `dossier.md`; il Neutro riceve **solo** `dossier-neutro.md`. Nessun membro vede i pareri altrui. Salva ogni parere in un file (`01-pessimista.md`, `02-ottimista.md`, …).

### Fase 2 — Contraddittorio

Rilancia i membri (in parallelo va bene) dando a ciascuno i pareri degli altri quattro, con obblighi incrociati:

- Il **Pessimista** deve attaccare o concedere le 3 principali opportunità dell'Ottimista.
- L'**Ottimista** deve attaccare o concedere le 3 principali obiezioni del Pessimista.
- L'**Indipendente** deve contestare la premessa a entrambi: anche se il progetto è buono, è quello giusto ora?
- Il **Neutro** non modifica il proprio parere di Fase 1 (resta congelato): segnala dove i giudizi degli altri divergono dalla sua lettura a freddo — quelle divergenze sono i punti in cui il contesto può aver distorto il giudizio.
- L'**Esecutore** deve dire quali obiezioni e quali opportunità sono operativamente rilevanti per i suoi due piani.

Ogni membro, per ogni punto assegnato, ha tre sole mosse: **confutare con evidenza**, **difendere con evidenza**, o **concedere esplicitamente** ("concedo il punto: …"). Le concessioni vanno a verbale. Salva tutto in `contraddittorio.md`.

### Fase 3 — Relazione del Presidente

Lancia il Presidente come subagente con: dossier completo, i 5 pareri, il contraddittorio. La relazione deve contenere, in quest'ordine:

1. **Tabella FATTI / IPOTESI / DATI MANCANTI** — consolidata da tutti i pareri, con fonte per ogni fatto.
2. **Valutazione di ogni membro** — per ciascuno: argomenti ammessi, argomenti scartati (con motivo: senza evidenza, senza meccanismo, confutati in contraddittorio), rispetto delle regole del proprio ruolo.
3. **Punteggio 0–100 dalla rubrica** (sotto), dimensione per dimensione, con motivazione per ogni voto.
4. **Verdetto**: `APPROVATO` / `APPROVATO CON CONDIZIONI` (elencarle) / `RINVIATO` (elencare i dati mancanti da raccogliere) / `RESPINTO`.
5. **Motivazione** — quali argomenti hanno deciso l'esito, quali sono stati scartati e perché. Se il verdetto sorprende rispetto al "clima" dei pareri, la motivazione deve spiegare la divergenza.
6. **Mandato all'Esecutore** — i prossimi passi coerenti con il verdetto, presi dal piano dell'Esecutore, inclusi i kill criteria.

**Rubrica del punteggio** (somma di 5 dimensioni, 0–20 ciascuna):

| Dimensione | Cosa misura |
|------------|-------------|
| Solidità delle prove | Quanto il quadro poggia su FATTI invece che su IPOTESI |
| Rischio residuo | Gravità delle obiezioni provate sopravvissute al contraddittorio (20 = nessuna) |
| Potenziale verificabile | Valore delle opportunità con meccanismo sopravvissute al contraddittorio |
| Coerenza strategica | Giudizio dell'Indipendente: progetto giusto, ora, rispetto alle alternative |
| Eseguibilità | Qualità dei due piani dell'Esecutore e dei kill criteria |

Vincolo meccanico: se un `[MANCANTE]` è critico per una dimensione, quella dimensione non può superare 10/20. Bande di coerenza verdetto/punteggio: 0–39 RESPINTO · 40–59 RINVIATO o condizioni forti · 60–79 APPROVATO CON CONDIZIONI · 80–100 APPROVATO.

### Fase 4 — Verifica del Segretario

Prima di consegnare la relazione al tuo partner umano, verifica:

- [ ] I 5 pareri sono distinguibili tra loro anche senza leggere l'intestazione? (Se due sono sovrapponibili, i ruoli sono collassati: rilancia con prompt di ruolo più netti.)
- [ ] Nel contraddittorio ogni membro ha confutato, difeso o conceduto punti *specifici* (citati), non generici?
- [ ] C'è almeno una concessione o una confutazione riuscita a verbale? (Zero movimenti = dibattito finto.)
- [ ] Ogni obiezione conteggiata dal Pessimista ha un'evidenza? Ogni opportunità conteggiata dall'Ottimista ha meccanismo e condizione?
- [ ] Il parere del Neutro cita solo informazioni presenti in `dossier-neutro.md`?
- [ ] La tabella FATTI/IPOTESI/MANCANTI esiste e il verdetto la usa (i MANCANTI critici compaiono nelle condizioni o motivano il rinvio)?
- [ ] Il punteggio è motivato dimensione per dimensione dalla rubrica? (Se la motivazione è "considerando tutti i pareri nel complesso", è una media travestita: rilancia il Presidente.)

Se una verifica fallisce, **rilancia la fase interessata** — il Segretario non corregge i contenuti di propria mano.

## Prompt di ruolo (template per i subagenti)

Ogni prompt di Fase 1 contiene: identità e mandato, il dossier, le regole di formato, l'etichettatura obbligatoria, e il divieto specifico del ruolo. Esempio completo (Pessimista):

```markdown
Sei il PESSIMISTA del consiglio di amministrazione. Il tuo mandato: trovare
tutto ciò che può far fallire questo progetto. Non sei ostile per posa: sei
l'assicurazione del consiglio contro l'entusiasmo.

<dossier>...contenuto di dossier.md...</dossier>

Produci un parere così strutturato:
- Per ogni obiezione: obiezione → evidenza → gravità (1–5).
  L'evidenza è un fatto del dossier, un dato verificabile o un precedente
  citabile. Se non hai un'evidenza, etichetta l'obiezione [SOSPETTO].
- Marca ogni affermazione portante come [FATTO] (con fonte), [IPOTESI] o
  [MANCANTE].
- Chiudi con le 3 obiezioni più gravi in ordine.

REGOLA INVIOLABILE: non puoi raccomandare la bocciatura sulla base di
obiezioni [SOSPETTO]. Se le tue obiezioni provate non bastano a bocciare,
dillo onestamente.
```

Gli altri prompt seguono lo stesso schema, cambiando mandato e regola inviolabile:

- **Ottimista** — mandato: massimo potenziale realistico. Formato: `opportunità → meccanismo → condizione verificabile`; il vago è `[AUSPICIO]`. Regola inviolabile: non puoi raccomandare l'approvazione sulla base di [AUSPICIO].
- **Indipendente** — mandato: è il progetto *giusto*? Confronta con almeno 2 alternative concrete (inclusa "non fare nulla"), valuta costo opportunità, coerenza con gli obiettivi dichiarati, timing. Regola inviolabile: non ripetere l'asse pro/contro — se il tuo parere somiglia a quello del Pessimista o dell'Ottimista, hai sbagliato lavoro.
- **Neutro** — riceve solo `dossier-neutro.md`. Mandato: valutazione a freddo per principi primi e tassi di base della categoria ("che percentuale di progetti così riesce, e cosa distingue quelli che riescono?"). Regola inviolabile: usa solo ciò che è scritto nel testo ricevuto; se un'informazione manca, dichiarala [MANCANTE], non inventarla.
- **Esecutore** — mandato: due piani operativi. Scenario successo: primi passi, milestone, risorse. Scenario insuccesso: kill criteria misurabili (quando fermarsi), exit, cosa si salva. Regola inviolabile: nessun giudizio di merito sul progetto — solo se e come è eseguibile.
- **Presidente** (Fase 3) — mandato: valutare la qualità degli argomenti e produrre la relazione nelle 6 sezioni previste. Regola inviolabile: niente media e niente conteggio dei "voti"; ogni punteggio di rubrica va motivato con gli argomenti ammessi; ogni argomento scartato va elencato con il motivo dello scarto.

## Red flags — fermati e correggi

- Tutti i pareri concordano, o hanno lo stesso tono → i ruoli sono collassati.
- Il Pessimista scrive "potrebbe fallire", "il mercato è difficile" senza fonte.
- L'Ottimista scrive "potenziale enorme", "trend in crescita" senza meccanismo né numero.
- L'Indipendente non nomina nessuna alternativa concreta.
- Il Neutro cita il proponente, il budget o l'entusiasmo — cose che non erano nel dossier sanificato.
- Nel contraddittorio nessuno concede nulla e nessuna obiezione cade → nessuno ha davvero dibattuto.
- Il punteggio del Presidente coincide col "sentimento medio" dei pareri e la motivazione non spiega nessuno scarto.
- La relazione riassume i pareri ("il Pessimista dice… l'Ottimista dice…") invece di giudicarli.
- Il verdetto è APPROVATO ma i [MANCANTE] critici non compaiono tra le condizioni.

## Razionalizzazioni comuni

| Scusa | Realtà |
|-------|--------|
| "L'esito è ovvio, il consiglio è teatro" | Se è ovvio, il contraddittorio lo conferma a basso costo. Se non lo conferma, l'ovvietà era bias. |
| "Interpreto io tutti i ruoli, faccio prima" | Un contesto unico contamina tutto: il Neutro non è più neutro, gli attacchi sono di comodo. Subagenti separati o niente consiglio. |
| "I pareri sono chiari, salto il contraddittorio" | Un argomento mai attaccato è un argomento mai testato. Il Presidente peserebbe carta straccia. |
| "La media dei giudizi è il metodo più oggettivo" | La media premia la quantità: un'obiezione fatale provata vale più di tre entusiasmi vaghi. Per questo i membri non emettono numeri. |
| "Mancano dati, decido con quel che c'è" | I dati mancanti si dichiarano. Se sono critici, il verdetto onesto è RINVIATO con la lista di cosa raccogliere. |
| "Il partner umano ha fretta, accorcio le fasi" | Una decisione sbagliata costa più di un'ora di consiglio. Se la fretta è reale, proponi al partner umano un consiglio ridotto e fallo scegliere — non tagliare in silenzio. |

## Esempio (estratti)

Progetto: "App di consegna farmaci a domicilio in città medie".

**Pessimista (Fase 1):** "Obiezione: la consegna di farmaci con obbligo di ricetta richiede intermediazione farmacia-corriere autorizzata → evidenza: il dossier dichiara [FATTO] che il team non ha partnership con farmacie → gravità 5. Obiezione: 'gli utenti non si fideranno' → nessuna evidenza nel dossier → [SOSPETTO]."

**Ottimista (Fase 1):** "Opportunità: popolazione 65+ in città medie con farmacie in consolidamento → meccanismo: accordo con 2 catene regionali che cercano canali digitali, consegna in giornata → condizione verificabile: almeno una catena firma una lettera d'intenti entro 60 giorni. Nota: 'il mercato healthtech esploderà' resterebbe [AUSPICIO], non lo conteggio."

**Contraddittorio:** l'Ottimista sull'obiezione normativa: "Concedo il punto: senza partnership farmaceutica il modello non parte; la mia condizione dei 60 giorni diventa precondizione, non milestone." Il Pessimista sull'opportunità 65+: "Non confuto il meccanismo; obietto [IPOTESI] che la fascia 65+ adotti l'app senza un canale telefonico — dato [MANCANTE]: tasso di adozione digitale della fascia target."

**Presidente (Fase 3, estratto):** "Solidità delle prove: 8/20 — il quadro regge su 3 FATTI e 6 IPOTESI, e il dato di adozione della fascia target è [MANCANTE] critico (tetto 10 applicato). … Punteggio totale: 52/100. Verdetto: RINVIATO. Argomento decisivo: l'obiezione normativa del Pessimista (gravità 5, provata, concessa dall'Ottimista). Scartato: '[SOSPETTO] gli utenti non si fideranno' — senza evidenza. Dati da raccogliere prima di riconvocare: lettera d'intenti di una catena, tasso di adozione digitale 65+ nelle città target."

Nota come il punteggio non è la media di nulla: nasce dalla rubrica, e il verdetto segue la banda 40–59.
