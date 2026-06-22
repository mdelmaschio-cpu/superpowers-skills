---
name: Redazione Clausole CO
description: Redazione di clausole contrattuali conformi al Codice delle Obbligazioni svizzero, con formule standard e varianti negoziali
when_to_use: when redigere un contratto svizzero, scrivere clausole contrattuali, formulare termini e condizioni, adattare modelli di contratto al diritto svizzero, modificare un contratto esistente, negoziare clausole secondo il CO, drafting contrattuale diritto svizzero, clausola di limitazione responsabilità svizzera, clausola penale CO, clausola di disdetta, clausola arbitrale svizzera
version: 1.0.0
languages: all
---

# Redazione Clausole CO

## Principio fondamentale

Prima di redigere una clausola, classificarla: norma imperativa (inderogabile), semi-imperativa (solo in favor di una parte), o dispositiva (liberamente derogabile). Redigere in deroga a una norma imperativa produce nullità automatica.

**Mappa norme imperative / dispositive CO:**

| Area | Imperativo | Dispositivo |
|------|-----------|-------------|
| Dolo/colpa grave | Responsabilità non escludibile (art. 100 CO) | Colpa lieve escludibile tra pari |
| Contratto lavoro | Norme minime inderogabili in peius per lavoratore (art. 361–362 CO) | Termini di disdetta migliorabili |
| Fideiussione | Forma scritta (art. 493 CO) | Importo massimo |
| Clausola penale | Riducibilità giudiziale (art. 163 CO) | Importo, fattispecie |

## Formula-tipo per clausole comuni

### Limitazione di responsabilità (B2B)
```
La responsabilità di [Parte] per danni indiretti, perdita di guadagno e danni
consequenziali è esclusa nella misura massima consentita dal diritto svizzero.
La responsabilità per dolo o colpa grave rimane in ogni caso impregiudicata
(art. 100 CO).
```
> Non omettere il salvo art. 100 CO: clausola senza questa riserva è nulla nella parte eccedente.

### Clausola penale (art. 160 CO)
```
In caso di [inadempimento specifico], [Parte inadempiente] è tenuta a corrispondere
a [Parte creditrice] una penale di CHF [importo] / [X]% del valore contrattuale,
salva la prova di un danno maggiore e salva la facoltà del giudice di ridurre
la penale manifestamente eccessiva (art. 163 cpv. 3 CO).
```
> Specificare sempre se la penale è alternativa o cumulativa rispetto al risarcimento (art. 161 CO).

### Disdetta contratto a tempo indeterminato
```
Ciascuna parte può disdire il presente contratto con preavviso scritto di
[termine] mesi, da inviarsi mediante lettera raccomandata. La disdetta
produce effetto il [primo giorno del mese / data concordata] successivo
alla ricezione.
```

### Clausola di scelta del foro (art. 17 CPC)
```
Per qualsiasi controversia derivante dal presente contratto è esclusivamente
competente il Tribunale di [Città/Cantone], Svizzera. Le parti rinunciano
espressamente a qualsiasi altro foro.
```
> Valida tra parti con domicilio in Svizzera; per parti estere verificare LDIP art. 5.

### Clausola compromissoria (arbitrato svizzera)
```
Qualsiasi controversia derivante dal presente contratto o in connessione con esso
sarà deferita ad un arbitro unico / tribunale arbitrale nominato secondo il
Regolamento Swiss Rules of International Arbitration con sede a [Zurigo/Ginevra/Lugano].
La lingua del procedimento sarà [italiano/francese/tedesco/inglese].
Il diritto applicabile è il diritto svizzero.
```

### Riserva di proprietà (art. 715 CC / art. 226a CO)
```
La merce rimane di proprietà del venditore fino al pagamento integrale
del prezzo di vendita. Il compratore è tenuto a collaborare alla registrazione
della riserva nel registro delle riserve di proprietà (art. 715 cpv. 1 CC).
```

### Clausola di hardship / adattamento del contratto
```
Se circostanze imprevedibili e non imputabili alle parti alterano
sostanzialmente l'equilibrio delle prestazioni, le parti si impegnano a
negoziare in buona fede un adattamento del contratto entro [30] giorni
dalla notifica scritta della parte lesa.
```
> Il CO non prevede clausola rebus sic stantibus esplicita; la tutela è affidata all'art. 18 CO (interpretazione) e all'errore essenziale (art. 24 CO). La clausola contrattuale esplicita è raccomandata.

## Checklist di redazione

Dopo aver redatto la clausola, verificare:

- [ ] La clausola deroga a una norma imperativa CO? → riscrivere
- [ ] Le parti sono identificate con precisione (denominazione, sede, ruolo)?
- [ ] I termini (giorni, franchi, percentuali) sono univoci e completi?
- [ ] Il meccanismo di notifica è specificato (raccomandata, email con ricevuta)?
- [ ] La clausola è coerente con le altre clausole del contratto?
- [ ] Per contratti internazionali: la clausola vale anche sotto il diritto scelto?

## Segnali d'allarme

- Copiare clausole di contratti di diritto straniero senza adattarle al CO
- Escludere responsabilità per dolo senza aggiungere la riserva art. 100 CO
- Clausola penale senza specificare il rapporto con il risarcimento del danno
- Clausola compromissoria senza indicare sede, regolamento e lingua
- Termini di prescrizione contrattualmente modificati oltre i limiti dell'art. 129 CO

## Riferimenti incrociati

- `skills/legal/codice-civile-svizzero` — per clausole di riserva di proprietà e altri diritti reali (art. 715 CC)
- `skills/legal/codice-procedura-civile-svizzera` — per clausole di proroga di foro e arbitrato interno (art. 17 CPC)
- `skills/legal/diritto-internazionale-privato-svizzero` — per clausole di foro, legge applicabile o arbitrato con controparti estere (art. 5 LDIP)
- `skills/legal/analisi-contratto-co` — per verificare una clausola esistente prima di modificarla
- `skills/legal/parere-legale` — per documentare le scelte redazionali con motivazione giuridica
