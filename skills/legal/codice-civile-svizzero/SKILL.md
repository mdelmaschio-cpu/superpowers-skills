---
name: Codice Civile Svizzero
description: Consulta il testo Fedlex del Codice civile svizzero (CC/RS 210) e risponde a domande giuridiche con citazione degli articoli.
when_to_use: when rispondere a domande sul Codice civile svizzero (CC, RS 210), persone fisiche e giuridiche, capacità civile, protezione della personalità, diritto di famiglia, matrimonio, divorzio, filiazione, autorità parentale, curatela, successioni, eredità, testamento, diritti reali, proprietà, possesso, servitù, pegno immobiliare, registro fondiario, the user asks legal questions about the Swiss Civil Code (CC/ZGB/RS 210), personality rights, family law, inheritance/succession, property law, real rights, land register under Swiss law
version: 1.0.0
languages: all
---

# Codice Civile Svizzero

## Principio fondamentale

Questo skill legge il PDF Fedlex ufficiale (RS 210, versione 2026-07-01, 372 pagine) come fonte normativa primaria. Cita sempre gli articoli specifici estratti dal documento. Non inventare mai il contenuto degli articoli — se il testo estratto è incompleto, indicarlo esplicitamente.

## Fonte

Usare il PDF Fedlex incluso nel repository:

`references/fedlex-rs-210-cc-20260701-it.pdf`

Metadati:
- RS/SR: 210
- Titolo: Codice civile svizzero del 10 dicembre 1907
- URL: `https://www.fedlex.admin.ch/eli/cc/24/233_245_233/it`
- Lingua: italiano
- Versione vigente: 2026-07-01
- Pagine: 372

Trattare questo PDF come fonte normativa primaria, non come banca dati completa di ricerca giuridica.

## Workflow

1. Identificare la questione giuridica e il tema CC pertinente (persone, famiglia, successioni, diritti reali).
2. Cercare nel PDF con `scripts/search_cc_pdf.py` per numero d'articolo o parole chiave.
3. Leggere il testo estratto circostante prima di rispondere.
4. Citare gli articoli specifici come `art. X CC`.
5. Distinguere il testo normativo dall'interpretazione, dottrina, giurisprudenza e consigli pratici.
6. Se la questione dipende da diritto successivo al 2026-07-01, diritto cantonale (es. tariffe notarili, registro fondiario cantonale), giurisprudenza, diritto fiscale o penale: indicare il limite e rimandare a fonti ufficiali aggiornate.

## Strumento di ricerca

```bash
# Dalla radice del repository
python skills/legal/codice-civile-svizzero/scripts/search_cc_pdf.py --query "parola chiave"
python skills/legal/codice-civile-svizzero/scripts/search_cc_pdf.py --article 28
python skills/legal/codice-civile-svizzero/scripts/search_cc_pdf.py --article 28 --query "personalità"

# Installazione dipendenza (una tantum)
pip install -r skills/legal/codice-civile-svizzero/scripts/requirements.txt
```

## Regole di risposta

- Rispondere in italiano salvo richiesta diversa dell'utente.
- Essere obiettivi ed espliciti sull'incertezza.
- Non inventare il contenuto degli articoli.
- Non citare lunghi passaggi; riassumere e citare l'articolo.
- Segnalare quando l'estrazione del testo può essere incompleta (tabelle, note a piè di pagina, disposizioni formattate).
- Per consulenza legale individuale, precisare che la risposta è informativa e che l'esito dipende dai fatti concreti e dalle fonti aggiornate.

## Esempio

**Domanda:** Un ex collega sta diffondendo informazioni false sul mio conto sui social media. Posso agire legalmente per fare cessare questa lesione e ottenere una rettifica?

**Ricerca:** `--article 28 --query "personalità"`

**Risposta:**
Sì. L'art. 28 cpv. 1 CC stabilisce che chi è illecitamente leso nella sua personalità può chiedere l'intervento del giudice contro chiunque partecipi alla lesione. Secondo l'art. 28 cpv. 2 CC, la lesione è illecita quando non è giustificata dal consenso della persona lesa, da un interesse preponderante privato o pubblico, oppure dalla legge.

L'art. 28a CC precisa i provvedimenti che si possono richiedere al giudice:
1. **Divieto** di una lesione imminente
2. **Cessazione** di una lesione attuale
3. **Accertamento** del carattere illecito di una lesione che continua a produrre effetto turbatorio

Per la diffusione di informazioni false è inoltre possibile richiedere la pubblicazione di una rettifica o della sentenza, oltre a un eventuale risarcimento del danno secondo le regole generali del CO (art. 41 segg. CO) e la riparazione del torto morale (art. 49 CO).

*Risposta informativa. L'esito dipende dai fatti concreti, dalla prova della lesione e dalla giurisdizione competente (art. 20 CPC).*

## Parole chiave per la ricerca

Termini italiani utili per le ricerche nel PDF:
- capacità civile, persona fisica, persona giuridica
- protezione della personalità, diritto al nome
- matrimonio, divorzio, regime dei beni, filiazione, autorità parentale
- curatela, tutela
- successione, eredità, testamento, legato, porzione legittima
- proprietà, possesso, servitù, pegno immobiliare, registro fondiario

## Segnali d'allarme

- Inventare il contenuto di un articolo senza aver estratto il testo dal PDF
- Citare articoli senza riportarne il contenuto concreto
- Rispondere a questioni di diritto cantonale (tariffe notarili, registro fondiario), penale o fiscale come se fossero CC
- Non indicare i limiti informativi in contesti di consulenza legale
- Usare una versione del CC antecedente a quella Fedlex in bundle (2026-07-01)

## Riferimenti incrociati

- `skills/legal/swiss-code-obligations` — il CO è il Libro quinto del CC; per obbligazioni e contratti
- `skills/legal/analisi-contratto-co` — per la capacità delle parti e i diritti reali in un contratto
- `skills/legal/due-diligence-legale-svizzera` — per la verifica di diritti reali e registro fondiario
- `skills/legal/parere-legale` — per formalizzare la risposta in un parere professionale
- `skills/legal/ricerca-giurisprudenza-svizzera` — per trovare sentenze BGE/ATF che integrano il testo normativo
