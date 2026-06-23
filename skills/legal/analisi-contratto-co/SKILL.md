---
name: Analisi Contratto CO
description: Analisi sistematica di contratti sotto il diritto svizzero delle obbligazioni (CO/OR)
when_to_use: when analizzare un contratto, rivedere clausole contrattuali, verificare la conformità al Codice delle Obbligazioni svizzero, identificare clausole nulle o abusive, valutare rischi contrattuali, controllare se un accordo è valido secondo il diritto svizzero, contratto svizzero da rivedere, esaminare termini e condizioni generali (TCG/AGB/CG)
version: 1.0.0
languages: all
---

# Analisi Contratto CO

## Principio fondamentale

Ogni analisi contrattuale svizzera parte dalla qualificazione del contratto, poi verifica i requisiti di validità, poi analizza le singole clausole. Non analizzare clausole isolate senza prima qualificare il rapporto contrattuale.

## Fase 1 — Qualificazione del contratto

Determinare il tipo contrattuale e le norme CO applicabili:

| Tipo | Articoli CO | Particolarità |
|------|-------------|---------------|
| Compravendita | art. 184–236 | Garanzia per vizi, riserva di proprietà |
| Appalto | art. 363–379 | Accettazione opera, prescrizione 5 anni |
| Mandato | art. 394–406 | Revocabilità, diligenza del mandatario |
| Locazione | art. 253–304 | Protezione locatario, disdetta, deposito |
| Contratto di lavoro | art. 319–362 | Norme imperative, disdetta, certificato |
| Contratto misto | varie | Applicazione analogica per assimilazione |

Se il tipo non corrisponde a nessuna categoria nominata: contratto innominato → applicare per analogia le norme più vicine (art. 1 cpv. 2 e art. 7 CO).

## Fase 2 — Requisiti di validità (art. 1–40 CO)

Verificare nell'ordine:

1. **Consenso**: offerta e accettazione coincidenti (art. 1–10 CO). Esiste accordo su oggetto e prezzo/corrispettivo?
2. **Capacità**: le parti hanno la capacità di agire (art. 12–19 CC)?
3. **Forma**: il contratto richiede forma scritta o autentica?
   - Forma scritta: cessione crediti (art. 165 CO), fideiussione >500 CHF (art. 493 CO)
   - Forma autentica: compravendita immobiliare (art. 657 CC)
4. **Oggetto lecito e morale**: clausole contrarie a norme imperative o ai buoni costumi → nullità assoluta (art. 19–20 CO)

## Fase 3 — Analisi delle clausole critiche

### Condizioni generali (CG/AGB)
- Incorporazione: le CG erano conoscibili e accessibili al contraente? (art. 1 CO)
- Clausole insolite: avvertenza specifica necessaria per clausole che l'aderente non poteva attendersi
- Clausole abusive B2C: art. 8 LCD (Legge contro la concorrenza sleale) — nullità delle clausole che causano squilibrio significativo

### Limitazione/esclusione responsabilità
- Dolo e colpa grave: non escludibili (art. 100 CO)
- Colpa lieve: escludibile tra parti paritarie
- Responsabilità per ausiliari (art. 101 CO): escludibile contrattualmente

### Clausole penali (art. 160–163 CO)
- Riduzione giudiziale se eccessiva (art. 163 cpv. 3 CO)
- Cumulabilità con risarcimento danni? (art. 161 CO)

### Prescrizione (art. 127–142 CO)
- Termine ordinario: 10 anni (art. 127 CO)
- Termini brevi: 5 anni per affitto/interessi (art. 128), 2 anni per vizi merce (art. 210 CO)
- Modifica contrattuale del termine: ammessa entro limiti (art. 129 CO)

### Clausola di scelta del foro e diritto applicabile
- Proroga di foro: valida tra commercianti (art. 17 CPC)
- Arbitrato: verificare forma scritta e arbitrabilità (art. 354 CPC, art. 178 LDIP)
- Diritto straniero: verificare compatibilità con norme di applicazione necessaria svizzere (art. 18 LDIP)

## Fase 4 — Sintesi del rischio

Strutturare il risultato in tre livelli:

**Rosso — Clausole nulle o potenzialmente nulle:**
- Indicare articolo CO/CC violato
- Conseguenza: nullità parziale (art. 20 cpv. 2 CO) o totale

**Arancione — Clausole rischiose/squilibrate:**
- Clausole sfavorevoli ma valide
- Raccomandazione di rinegoziazione

**Verde — Clausole standard conformi:**
- Breve conferma di conformità

## Esempio

**Contratto**: clausola di esclusione totale di responsabilità in un contratto di appalto B2B.

Analisi:
- Tipo: contratto d'appalto (art. 363 CO) → norma CO applicabile
- Clausola: esclusione totale responsabilità per inadempimento
- Verifica art. 100 CO: esclusione dolo/colpa grave → **nulla** per la parte relativa a dolo e colpa grave
- Esclusione colpa lieve tra imprenditori paritari: **valida**
- Risultato **Rosso parziale**: clausola parzialmente nulla, si conserva per colpa lieve (art. 20 cpv. 2 CO)

## Segnali d'allarme

- Non qualificare il tipo contrattuale e saltare direttamente all'analisi delle clausole
- Applicare la disciplina B2C (LCD art. 8) a contratti puramente B2B
- Ignorare i requisiti di forma (nullità assoluta non sanabile)
- Confondere norme imperative e dispositive del CO
- Omettere la verifica della prescrizione nei contratti di durata

## Riferimenti incrociati

- `skills/legal/codice-civile-svizzero` — per la capacità delle parti (art. 12–19 CC) e i diritti reali (art. 657 CC)
- `skills/legal/codice-procedura-civile-svizzera` — per la validità di clausole di foro e arbitrato interno (art. 17, 354 CPC)
- `skills/legal/diritto-internazionale-privato-svizzero` — per clausole con elementi internazionali (art. 178, 18 LDIP)
- `skills/legal/redazione-clausole-co` — per dopo l'analisi, quando redigere una versione corretta
- `skills/legal/parere-legale` — per formalizzare l'analisi in un parere strutturato
- `skills/legal/due-diligence-legale-svizzera` — per analisi massiva di più contratti in DD
