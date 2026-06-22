---
name: Codice di Procedura Civile Svizzero
description: Consulta il testo Fedlex del Codice di procedura civile svizzero (CPC/RS 272) e risponde a domande giuridiche con citazione degli articoli.
when_to_use: when rispondere a domande sul Codice di procedura civile svizzero (CPC, RS 272), competenza del giudice, foro, proroga di foro, conciliazione, procedimento civile, mezzi di prova, provvedimenti cautelari, ricorso, appello, arbitrato interno, spese giudiziarie, the user asks legal questions about Swiss civil procedure (CPC/ZPO/RS 272), jurisdiction/venue, forum selection clauses, conciliation proceedings, civil litigation procedure, domestic arbitration agreements under Swiss law
version: 1.0.0
languages: all
---

# Codice di Procedura Civile Svizzero

## Principio fondamentale

Questo skill legge il PDF Fedlex ufficiale (RS 272, versione 2026-07-01, 134 pagine) come fonte normativa primaria. Cita sempre gli articoli specifici estratti dal documento. Non inventare mai il contenuto degli articoli — se il testo estratto è incompleto, indicarlo esplicitamente.

## Fonte

Usare il PDF Fedlex incluso nel repository:

`references/fedlex-rs-272-cpc-20260701-it.pdf`

Metadati:
- RS/SR: 272
- Titolo: Codice di diritto processuale civile svizzero (Codice di procedura civile, CPC) del 19 dicembre 2008
- URL: `https://www.fedlex.admin.ch/eli/cc/2010/262/it`
- Lingua: italiano
- Versione vigente: 2026-07-01
- Pagine: 134

Trattare questo PDF come fonte normativa primaria, non come banca dati completa di ricerca giuridica.

## Workflow

1. Identificare la questione giuridica e il tema CPC pertinente (competenza, procedura, mezzi di prova, rimedi giuridici).
2. Cercare nel PDF con `scripts/search_cpc_pdf.py` per numero d'articolo o parole chiave.
3. Leggere il testo estratto circostante prima di rispondere.
4. Citare gli articoli specifici come `art. X CPC`.
5. Distinguere il testo normativo dall'interpretazione, dottrina, giurisprudenza e consigli pratici.
6. Se la questione dipende da diritto successivo al 2026-07-01, diritto procedurale cantonale residuo, giurisprudenza, arbitrato internazionale (→ LDIP), o esecuzione forzata (→ LEF): indicare il limite e rimandare alla fonte pertinente.

## Strumento di ricerca

```bash
# Dalla radice del repository
python skills/legal/codice-procedura-civile-svizzera/scripts/search_cpc_pdf.py --query "parola chiave"
python skills/legal/codice-procedura-civile-svizzera/scripts/search_cpc_pdf.py --article 59
python skills/legal/codice-procedura-civile-svizzera/scripts/search_cpc_pdf.py --article 17 --query "proroga di foro"

# Installazione dipendenza (una tantum)
pip install -r skills/legal/codice-procedura-civile-svizzera/scripts/requirements.txt
```

## Regole di risposta

- Rispondere in italiano salvo richiesta diversa dell'utente.
- Essere obiettivi ed espliciti sull'incertezza.
- Non inventare il contenuto degli articoli.
- Non citare lunghi passaggi; riassumere e citare l'articolo.
- Segnalare quando l'estrazione del testo può essere incompleta (tabelle, note a piè di pagina, disposizioni formattate).
- Per consulenza legale individuale, precisare che la risposta è informativa e che l'esito dipende dai fatti concreti e dalle fonti aggiornate.

## Esempio

**Domanda:** In un contratto commerciale tra due società svizzere vogliamo pattuire che ogni controversia sia decisa esclusivamente dal tribunale di Zurigo. È valida questa clausola e cosa serve per fissarla correttamente?

**Ricerca:** `--article 17 --query "proroga di foro"`

**Risposta:**
Sì, è valida. L'art. 17 cpv. 1 CPC permette alle parti di pattuire il foro per una controversia esistente o futura in materia di pretese derivanti da un determinato rapporto giuridico, salvo che la legge disponga altrimenti (vi sono fori imperativi, es. art. 20 CPC per la protezione della personalità). Salva diversa stipulazione, l'azione potrà essere proposta soltanto al foro pattuito (foro esclusivo).

Requisito di forma: l'art. 17 cpv. 2 CPC richiede che il patto sia stipulato per scritto o in un'altra forma che consenta la prova per testo (es. e-mail).

Va inoltre verificato che il giudice adito esamini d'ufficio i presupposti processuali (art. 59-60 CPC), tra cui la competenza per materia e per territorio: una proroga di foro non sana l'assenza di altri presupposti come l'interesse degno di protezione o la capacità processuale delle parti.

*Risposta informativa. Se il contratto ha elementi internazionali (controparte estera, esecuzione all'estero), si applica la LDIP e non solo il CPC.*

## Parole chiave per la ricerca

Termini italiani utili per le ricerche nel PDF:
- competenza, foro, proroga di foro, costituzione in giudizio
- presupposti processuali, litispendenza, regiudicata
- conciliazione, petizione, istanza
- mezzi di prova, prova documentale, testimonianza
- provvedimenti cautelari, misure superprovvisionali
- appello, reclamo, ricorso al Tribunale federale
- patto d'arbitrato, tribunale arbitrale interno
- spese giudiziarie, gratuito patrocinio

## Segnali d'allarme

- Inventare il contenuto di un articolo senza aver estratto il testo dal PDF
- Citare articoli senza riportarne il contenuto concreto
- Applicare il CPC a controversie con elementi internazionali senza verificare la LDIP
- Confondere foro/procedura civile (CPC) con esecuzione forzata e fallimento (LEF)
- Non indicare i limiti informativi in contesti di consulenza legale
- Usare una versione del CPC antecedente a quella Fedlex in bundle (2026-07-01)

## Riferimenti incrociati

- `skills/legal/diritto-internazionale-privato-svizzero` — per controversie con elementi internazionali (foro, arbitrato internazionale, riconoscimento sentenze estere)
- `skills/legal/legge-esecuzione-fallimento-svizzera` — per l'esecuzione delle sentenze e i rimedi contro l'esecuzione (opposizione)
- `skills/legal/analisi-contratto-co` — per la valutazione di clausole di foro e arbitrato in un contratto
- `skills/legal/redazione-clausole-co` — per redigere clausole di proroga di foro o arbitrato
- `skills/legal/ricerca-giurisprudenza-svizzera` — per trovare sentenze BGE/ATF che integrano il testo normativo
