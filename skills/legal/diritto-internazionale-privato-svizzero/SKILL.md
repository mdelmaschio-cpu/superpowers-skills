---
name: Diritto Internazionale Privato Svizzero
description: Consulta il testo Fedlex della Legge federale sul diritto internazionale privato (LDIP/RS 291) e risponde a domande giuridiche con citazione degli articoli.
when_to_use: when rispondere a domande sul diritto internazionale privato svizzero (LDIP, RS 291), competenza internazionale, foro internazionale, legge applicabile, conflitto di leggi, arbitrato internazionale, riconoscimento ed esecuzione di sentenze straniere, contratti con controparti estere, the user asks legal questions about Swiss private international law (LDIP/IPRG/RS 291), choice of law, international jurisdiction, international arbitration agreements, recognition and enforcement of foreign judgments under Swiss law
version: 1.0.0
languages: all
---

# Diritto Internazionale Privato Svizzero

## Principio fondamentale

Questo skill legge il PDF Fedlex ufficiale (RS 291, versione 2026-01-01, 72 pagine) come fonte normativa primaria. Cita sempre gli articoli specifici estratti dal documento. Non inventare mai il contenuto degli articoli — se il testo estratto è incompleto, indicarlo esplicitamente.

## Fonte

Usare il PDF Fedlex incluso nel repository:

`references/fedlex-rs-291-ldip-20260101-it.pdf`

Metadati:
- RS/SR: 291
- Titolo: Legge federale sul diritto internazionale privato (LDIP) del 18 dicembre 1987
- URL: `https://www.fedlex.admin.ch/eli/cc/1988/1776_1776_1776/it`
- Lingua: italiano
- Versione vigente: 2026-01-01
- Pagine: 72

Trattare questo PDF come fonte normativa primaria, non come banca dati completa di ricerca giuridica. Ricordare che per le materie disciplinate dalla Convenzione di Lugano o da altri trattati internazionali, questi prevalgono sulla LDIP (art. 1 cpv. 2 LDIP).

## Workflow

1. Identificare la questione giuridica e il tema LDIP pertinente (competenza, legge applicabile, arbitrato internazionale, riconoscimento di decisioni estere).
2. Verificare se un trattato internazionale (es. Convenzione di Lugano) prevale sulla LDIP per la materia in questione.
3. Cercare nel PDF con `scripts/search_ldip_pdf.py` per numero d'articolo o parole chiave.
4. Leggere il testo estratto circostante prima di rispondere.
5. Citare gli articoli specifici come `art. X LDIP`.
6. Distinguere il testo normativo dall'interpretazione, dottrina, giurisprudenza e consigli pratici.
7. Se la questione dipende da diritto successivo al 2026-01-01, trattati internazionali specifici, giurisprudenza, o procedura puramente interna senza elementi internazionali (→ CPC): indicare il limite e rimandare alla fonte pertinente.

## Strumento di ricerca

```bash
# Dalla radice del repository
python skills/legal/diritto-internazionale-privato-svizzero/scripts/search_ldip_pdf.py --query "parola chiave"
python skills/legal/diritto-internazionale-privato-svizzero/scripts/search_ldip_pdf.py --article 5
python skills/legal/diritto-internazionale-privato-svizzero/scripts/search_ldip_pdf.py --article 178 --query "arbitrato"

# Installazione dipendenza (una tantum)
pip install -r skills/legal/diritto-internazionale-privato-svizzero/scripts/requirements.txt
```

## Regole di risposta

- Rispondere in italiano salvo richiesta diversa dell'utente.
- Essere obiettivi ed espliciti sull'incertezza.
- Non inventare il contenuto degli articoli.
- Non citare lunghi passaggi; riassumere e citare l'articolo.
- Segnalare quando l'estrazione del testo può essere incompleta (tabelle, note a piè di pagina, disposizioni formattate).
- Per consulenza legale individuale, precisare che la risposta è informativa e che l'esito dipende dai fatti concreti e dalle fonti aggiornate.

## Esempio

**Domanda:** Stiamo concludendo un contratto commerciale tra una società svizzera e una società estera e vogliamo pattuire che il foro per ogni controversia sia in Svizzera. È sufficiente una clausola generica "foro: Svizzera" oppure serve indicare un tribunale preciso?

**Ricerca:** `--article 5 --query "proroga di foro"`

**Risposta:**
L'art. 5 cpv. 1 LDIP permette alle parti di pattuire il foro per una controversia esistente o futura in materia di pretese patrimoniali derivanti da un determinato rapporto giuridico; il patto può essere stipulato per scritto o in un'altra forma che consenta la prova per testo. Salvo diversa stipulazione, il foro prorogato è esclusivo (art. 5 cpv. 1 LDIP).

Una clausola generica "foro: Svizzera" è comunque efficace: l'art. 5 cpv. 1bis LDIP (in vigore dal 1° gennaio 2025) prevede espressamente che se le parti hanno semplicemente convenuto che il foro competente è in Svizzera, la competenza dei tribunali svizzeri è determinata dalle disposizioni della LDIP; in mancanza di disposizioni specifiche, è competente il tribunale adito per primo. Per evitare incertezze è comunque preferibile indicare il tribunale specifico (es. "i tribunali del Cantone di Zurigo").

Limite: la proroga è inefficace se una parte si trova abusivamente privata di un foro previsto dal diritto svizzero (art. 5 cpv. 2 LDIP), e prevalgono eventuali trattati internazionali applicabili (es. Convenzione di Lugano se la controparte è domiciliata in uno Stato firmatario).

*Risposta informativa. Se le parti preferiscono l'arbitrato invece del foro statale, si applicano gli artt. 176 segg. LDIP (in particolare l'art. 178 LDIP sulla forma del patto d'arbitrato).*

## Parole chiave per la ricerca

Termini italiani utili per le ricerche nel PDF:
- competenza internazionale, foro, proroga di foro, foro di necessità
- legge applicabile, conflitto di leggi, rinvio
- domicilio, sede, cittadinanza
- arbitrato internazionale, patto d'arbitrato, tribunale arbitrale
- riconoscimento ed esecuzione di decisioni straniere
- fallimento internazionale, successioni internazionali, diritto di famiglia internazionale

## Segnali d'allarme

- Inventare il contenuto di un articolo senza aver estratto il testo dal PDF
- Citare articoli senza riportarne il contenuto concreto
- Applicare la LDIP senza verificare la prevalenza di trattati internazionali (es. Convenzione di Lugano)
- Applicare la LDIP a controversie puramente interne prive di elementi internazionali
- Non indicare i limiti informativi in contesti di consulenza legale
- Usare una versione della LDIP antecedente a quella Fedlex in bundle (2026-01-01)

## Riferimenti incrociati

- `skills/legal/codice-procedura-civile-svizzera` — per la procedura interna parallela quando non vi sono elementi internazionali
- `skills/legal/redazione-clausole-co` — per redigere clausole di scelta del foro, legge applicabile o arbitrato internazionale
- `skills/legal/analisi-contratto-co` — per analizzare contratti con controparti estere
- `skills/legal/legge-esecuzione-fallimento-svizzera` — per sequestro e riconoscimento quando il debitore è all'estero
- `skills/legal/ricerca-giurisprudenza-svizzera` — per trovare sentenze BGE/ATF che integrano il testo normativo
