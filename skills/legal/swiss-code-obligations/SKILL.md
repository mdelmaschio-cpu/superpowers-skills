---
name: Codice delle Obbligazioni Svizzero
description: Consulta il testo Fedlex del Codice delle Obbligazioni (CO/RS 220) e risponde a domande giuridiche con citazione degli articoli.
when_to_use: when rispondere a domande sul Codice delle Obbligazioni svizzero (CO, RS 220), contratti, società, lavoro, locazione, responsabilità, prescrizione, registro di commercio, titoli di credito, inadempimento, mora, fideiussione, procura, arricchimento indebito, comprare o vendere secondo il diritto svizzero, the user asks legal questions about the Swiss Code of Obligations (CO/OR/RS 220), Swiss contract law, Swiss company law SA Sagl, employment termination, prescription periods, commercial register, securities
version: 1.1.0
languages: all
---

# Codice delle Obbligazioni Svizzero

## Principio fondamentale

Questo skill legge il PDF Fedlex ufficiale (RS 220, versione 2026-01-01, 538 pagine) come fonte normativa primaria. Cita sempre gli articoli specifici estratti dal documento. Non inventare mai il contenuto degli articoli — se il testo estratto è incompleto, indicarlo esplicitamente.

## Fonte

Usare il PDF Fedlex incluso nel repository:

`references/fedlex-rs-220-co-latest-it.pdf`

Metadati:
- RS/SR: 220
- Titolo: Legge federale del 30 marzo 1911 di complemento del Codice civile svizzero (Libro quinto: Diritto delle obbligazioni)
- URL: `https://fedlex.data.admin.ch/eli/cc/27/317_321_377/20260101`
- Lingua: italiano
- Versione vigente: 2026-01-01
- Pagine: 538

Trattare questo PDF come fonte normativa primaria, non come banca dati completa di ricerca giuridica.

## Workflow

1. Identificare la questione giuridica e il tema CO pertinente.
2. Cercare nel PDF con `scripts/search_co_pdf.py` per numero d'articolo o parole chiave.
3. Leggere il testo estratto circostante prima di rispondere.
4. Citare gli articoli specifici come `art. X CO`.
5. Distinguere il testo normativo dall'interpretazione, dottrina, giurisprudenza e consigli pratici.
6. Se la questione dipende da diritto successivo al 2026-01-01, diritto cantonale, giurisprudenza, scadenze processuali, strategia legale, diritto fiscale o penale: indicare il limite e rimandare a fonti ufficiali aggiornate.

## Strumento di ricerca

```bash
# Dalla radice del repository
python skills/legal/swiss-code-obligations/scripts/search_co_pdf.py --query "parola chiave"
python skills/legal/swiss-code-obligations/scripts/search_co_pdf.py --article 97
python skills/legal/swiss-code-obligations/scripts/search_co_pdf.py --article 97 --query "inadempimento"

# Installazione dipendenza (una tantum)
pip install -r skills/legal/swiss-code-obligations/scripts/requirements.txt
```

## Regole di risposta

- Rispondere in italiano salvo richiesta diversa dell'utente.
- Essere obiettivi ed espliciti sull'incertezza.
- Non inventare il contenuto degli articoli.
- Non citare lunghi passaggi; riassumere e citare l'articolo.
- Segnalare quando l'estrazione del testo può essere incompleta (tabelle, note a piè di pagina, disposizioni formattate).
- Per consulenza legale individuale, precisare che la risposta è informativa e che l'esito dipende dai fatti concreti e dalle fonti aggiornate.

## Esempio

**Domanda:** Il mio fornitore non ha consegnato la merce entro il termine pattuito. Posso chiedergli il risarcimento del danno?

**Ricerca:** `--article 97 --query "inadempimento"`

**Risposta:**
Sì. L'art. 97 cpv. 1 CO stabilisce che il debitore che non adempie l'obbligazione o non la adempie nel debito modo è tenuto al risarcimento del danno, a meno che provi che nessuna colpa gli è imputabile. La mancata consegna entro termine costituisce inadempimento. Per far valere il risarcimento occorre:

1. **Messa in mora** — se il termine non era perentorio (dies non interpellat), diffidare il fornitore per iscritto (art. 102 CO)
2. **Prova del danno** — documentare il pregiudizio economico subito
3. **Prescrizione** — agire entro 10 anni (art. 127 CO), salvo termini speciali (es. 2 anni per vizi della merce, art. 210 CO)

*Risposta informativa. L'esito dipende dai fatti concreti, dalle clausole contrattuali e dall'eventuale diritto straniero applicabile.*

## Parole chiave per la ricerca

Termini italiani utili per le ricerche nel PDF:
- inadempimento, mora, risarcimento, prescrizione
- contratto, vendita, locazione, mandato, appalto
- lavoro, disdetta, salario, vacanze
- società anonima, società a garanzia limitata, società semplice
- responsabilità, indebito arricchimento
- fideiussione, procura, rappresentanza

## Segnali d'allarme

- Inventare il contenuto di un articolo senza aver estratto il testo dal PDF
- Citare articoli senza riportarne il contenuto concreto
- Rispondere a questioni di diritto cantonale, penale o fiscale come se fossero CO
- Non indicare i limiti informativi in contesti di consulenza legale
- Usare una versione del CO antecedente a quella Fedlex in bundle (2026-01-01)

## Riferimenti incrociati

- `skills/legal/analisi-contratto-co` — per analisi strutturata di un contratto CO
- `skills/legal/parere-legale` — per formalizzare la risposta in un parere professionale
- `skills/legal/ricerca-giurisprudenza-svizzera` — per trovare sentenze BGE/ATF che integrano il testo normativo
- `skills/legal/redazione-clausole-co` — per redigere o modificare clausole contrattuali CO
