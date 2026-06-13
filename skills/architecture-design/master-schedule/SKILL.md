---
name: Master Schedule
description: Verify and set up the Google Sheets product library connection for the current project — runs silently before other product operations.
when_to_use: when setting up a project's product library sheet for the first time, reconnecting to a different sheet, or diagnosing Google Sheets MCP connection failures in the product workflow — oppure quando si configura per la prima volta il foglio libreria prodotti di un progetto, ci si riconnette a un foglio diverso, o si diagnosticano errori di connessione Google Sheets nel flusso prodotti
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /master-schedule — Master Schedule Setup

Verifies that `master-schedule.json` exists and the connected Google Sheet is accessible. Runs silently before other product operations or directly when invoked.

## Usage

```
/master-schedule          → verify connection or initialize setup
/master-schedule update   → change project name or connect different sheet
/master-schedule reset    → start fresh with a new template copy
```

## Three-Step Process

1. **Check config** — look for `master-schedule.json` (falls back to legacy `canoa.json`)
2. **Validate sheet access** — call Google Sheets MCP with the stored sheet ID
3. **Auto-setup** — if no config or sheet inaccessible, either copy a template sheet or create a fresh spreadsheet with proper headers

## Manual Mode

When run directly, displays connection status and offers:
- Update project name
- Connect a different sheet via URL
- Reset with a new template copy

## Error Handling

On MCP connection failures, provides detailed setup instructions for configuring Google Sheets authentication through Claude Code environment.

Config stores sheet ID, project name, setup method ("copy" or "fresh"), and ISO creation timestamp.
