---
name: Swiss Code of Obligations
description: Consult the bundled Fedlex Italian Swiss Code of Obligations (CO/SR 220) to answer legal questions with cited article numbers.
when_to_use: when the user asks legal questions connected to the Swiss Code of Obligations (Codice delle obbligazioni, CO; RS/SR 220), including contracts, companies, employment, lease, liability, prescription, commercial register, securities, or other Swiss civil/commercial obligations issues
version: 1.0.0
languages: all
---

# Swiss Code of Obligations

## Source

Use the bundled Fedlex PDF:

`references/fedlex-rs-220-co-20260101-it.pdf`

Known metadata from the PDF:
- RS/SR: 220
- Title: Legge federale del 30 marzo 1911 di complemento del Codice civile svizzero (Libro quinto: Diritto delle obbligazioni)
- Version URL: `https://fedlex.data.admin.ch/eli/cc/27/317_321_377/20260101`
- Language: Italian
- Effective version represented by file name: 2026-01-01

Treat this PDF as a primary statutory source, but not as a complete legal research database.

## Workflow

1. Identify the legal issue and the relevant CO topic.
2. Search the PDF for article numbers, headings, or legal keywords using `scripts/search_co_pdf.py`.
3. Read the surrounding extracted text before answering.
4. Cite specific articles as `art. X CO`.
5. Distinguish statutory text from interpretation, doctrine, case law, or practical advice.
6. If the question depends on current law after 2026-01-01, cantonal law, case law, deadlines, litigation strategy, tax, criminal law, or individual facts, state the limitation and verify with official/current sources before giving a firm answer.

## Search Tool

```bash
python skills/legal/swiss-code-obligations/scripts/search_co_pdf.py --query "parola chiave"
python skills/legal/swiss-code-obligations/scripts/search_co_pdf.py --article 97
```

The script requires `PyPDF2` or `pypdf` (`pip install pypdf`).

## Answering Rules

- Answer in Italian unless the user requests another language.
- Be objective and explicit about uncertainty.
- Do not invent article content.
- Do not quote long passages; summarize and cite the article.
- Mention when text extraction may be incomplete, especially for tables, footnotes, or formatting-sensitive provisions.
- For legal advice, state that the answer is informational and that the exact outcome depends on facts and current sources.

## Common Keywords

Use these Italian keywords to start searches:
- inadempimento, mora, risarcimento, prescrizione
- contratto, vendita, locazione, mandato, appalto
- lavoro, disdetta, salario, vacanze
- societa anonima, societa a garanzia limitata, societa semplice
- responsabilita, indebito arricchimento
- fideiussione, procura, rappresentanza
