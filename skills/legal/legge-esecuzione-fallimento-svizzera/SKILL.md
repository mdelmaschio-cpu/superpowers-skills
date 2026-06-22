---
name: Legge Federale su Esecuzione e Fallimento Svizzera
description: Consulta il testo Fedlex della Legge federale sulla esecuzione e sul fallimento (LEF/RS 281.1) e risponde a domande giuridiche con citazione degli articoli.
when_to_use: when rispondere a domande sulla Legge federale sulla esecuzione e sul fallimento svizzera (LEF, RS 281.1), precetto esecutivo, pignoramento, fallimento, sequestro, opposizione, attestato di carenza di beni, concordato, graduatoria, the user asks legal questions about Swiss debt collection and bankruptcy law (LEF/SchKG/RS 281.1), enforcement proceedings, garnishment/attachment (sequestro), bankruptcy filings, debt collection notices under Swiss law
version: 1.0.0
languages: all
---

# Legge Federale su Esecuzione e Fallimento Svizzera

## Principio fondamentale

Questo skill legge il PDF Fedlex ufficiale (RS 281.1, versione 2026-01-01, 148 pagine) come fonte normativa primaria. Cita sempre gli articoli specifici estratti dal documento. Non inventare mai il contenuto degli articoli — se il testo estratto è incompleto, indicarlo esplicitamente.

## Fonte

Usare il PDF Fedlex incluso nel repository:

`references/fedlex-rs-281-1-lef-20260101-it.pdf`

Metadati:
- RS/SR: 281.1
- Titolo: Legge federale sulla esecuzione e sul fallimento (LEF) dell'11 aprile 1889
- URL: `https://www.fedlex.admin.ch/eli/cc/11/529_488_529/it`
- Lingua: italiano
- Versione vigente: 2026-01-01
- Pagine: 148

Trattare questo PDF come fonte normativa primaria, non come banca dati completa di ricerca giuridica.

## Workflow

1. Identificare la questione giuridica e il tema LEF pertinente (esecuzione per debiti, fallimento, sequestro).
2. Cercare nel PDF con `scripts/search_lef_pdf.py` per numero d'articolo o parole chiave.
3. Leggere il testo estratto circostante prima di rispondere.
4. Citare gli articoli specifici come `art. X LEF`.
5. Distinguere il testo normativo dall'interpretazione, dottrina, giurisprudenza e consigli pratici.
6. Se la questione dipende da diritto successivo al 2026-01-01, competenza procedurale del CPC per le azioni connesse, giurisprudenza, o aspetti penali (es. bancarotta fraudolenta, CP): indicare il limite e rimandare alla fonte pertinente.

## Strumento di ricerca

```bash
# Dalla radice del repository
python skills/legal/legge-esecuzione-fallimento-svizzera/scripts/search_lef_pdf.py --query "parola chiave"
python skills/legal/legge-esecuzione-fallimento-svizzera/scripts/search_lef_pdf.py --article 271
python skills/legal/legge-esecuzione-fallimento-svizzera/scripts/search_lef_pdf.py --article 271 --query "sequestro"

# Installazione dipendenza (una tantum)
pip install -r skills/legal/legge-esecuzione-fallimento-svizzera/scripts/requirements.txt
```

## Regole di risposta

- Rispondere in italiano salvo richiesta diversa dell'utente.
- Essere obiettivi ed espliciti sull'incertezza.
- Non inventare il contenuto degli articoli.
- Non citare lunghi passaggi; riassumere e citare l'articolo.
- Segnalare quando l'estrazione del testo può essere incompleta (tabelle, note a piè di pagina, disposizioni formattate).
- Per consulenza legale individuale, precisare che la risposta è informativa e che l'esito dipende dai fatti concreti e dalle fonti aggiornate.

## Esempio

**Domanda:** Il mio debitore non ha domicilio fisso in Svizzera e temo che sposti i suoi beni all'estero prima che io possa ottenere un titolo esecutivo. Posso bloccare i suoi beni preventivamente?

**Ricerca:** `--article 271 --query "sequestro"`

**Risposta:**
Sì, tramite il sequestro. L'art. 271 cpv. 1 LEF permette al creditore di un credito scaduto e non garantito da pegno di chiedere il sequestro dei beni del debitore che si trovano in Svizzera in presenza di determinate cause di sequestro, tra cui:
- il debitore non ha domicilio fisso (n. 1)
- il debitore, per sottrarsi all'adempimento, trafuga i suoi beni, si rende latitante o si prepara alla fuga (n. 2)
- il creditore possiede un attestato provvisorio o definitivo di carenza di beni (n. 5)
- il creditore possiede un titolo definitivo di rigetto dell'opposizione (n. 6)

Nei casi delle cause n. 1 e n. 2, il sequestro può essere chiesto anche per crediti non ancora scaduti, la cui scadenza viene anticipata dal sequestro stesso (art. 271 cpv. 2 LEF).

Procedimento pratico: il sequestro va richiesto al giudice competente con istanza motivata e prova delle cause invocate; se concesso, dev'essere convalidato promuovendo entro termine l'azione o l'esecuzione corrispondente (art. 279 LEF), altrimenti decade.

*Risposta informativa. L'esito dipende dalla prova delle cause di sequestro e dalla localizzazione dei beni; se il debitore è all'estero si valuti anche la LDIP per la competenza e il riconoscimento di decisioni straniere.*

## Parole chiave per la ricerca

Termini italiani utili per le ricerche nel PDF:
- precetto esecutivo, opposizione, rigetto dell'opposizione
- pignoramento, graduatoria, realizzazione
- fallimento, concordato, moratoria
- sequestro, convalida del sequestro
- attestato di carenza di beni
- ufficio d'esecuzione, ufficio dei fallimenti

## Segnali d'allarme

- Inventare il contenuto di un articolo senza aver estratto il testo dal PDF
- Citare articoli senza riportarne il contenuto concreto
- Confondere esecuzione/fallimento (LEF) con procedura civile ordinaria (CPC)
- Trattare il sequestro come misura automatica senza convalida (art. 279 LEF)
- Non indicare i limiti informativi in contesti di consulenza legale
- Usare una versione della LEF antecedente a quella Fedlex in bundle (2026-01-01)

## Riferimenti incrociati

- `skills/legal/codice-procedura-civile-svizzera` — per la procedura davanti al giudice civile nelle azioni connesse all'esecuzione
- `skills/legal/diritto-internazionale-privato-svizzero` — per sequestro e riconoscimento di decisioni quando il debitore è all'estero
- `skills/legal/due-diligence-legale-svizzera` — per la verifica della solvibilità e di esecuzioni/fallimenti pendenti su una controparte
- `skills/legal/swiss-code-obligations` — per i presupposti del credito sottostante (inadempimento, mora)
- `skills/legal/parere-legale` — per formalizzare la risposta in un parere professionale
