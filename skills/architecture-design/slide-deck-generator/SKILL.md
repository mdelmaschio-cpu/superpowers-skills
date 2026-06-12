---
name: Slide Deck Generator
description: Transform topics, outlines, documents, or data into self-contained HTML slide decks using the ALPA design system — 22 slide types, minimal aesthetic, keyboard navigation.
when_to_use: when generating a presentation from a topic, outline, report, or dataset; creating client-facing architecture presentations; or building a self-contained HTML slide deck with a professional minimal design
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /slide-deck-generator — HTML Slide Deck Generator

Transforms topics, outlines, documents, or data into self-contained HTML slide decks using the ALPA design system. Single `.html` file output with embedded assets, keyboard/touch navigation, no external dependencies.

## Usage

```
/slide-deck-generator [topic, outline, document path, or data]
```

## 22 Slide Types

Covers layouts for: titles, content, stats, comparisons, tables, timelines, charts, image grids, quotes, and more.

## Design System

- **Typography**: Helvetica, monochrome palette (black/white/grey)
- **Layout**: left-aligned by default; content breathes — at least 40% empty space per slide
- **Headlines**: bold, opinionated — state the insight, not just the topic
- **One major component per slide**
- **Dark slides** used sparingly (1-2 per deck for emphasis)
- **No decorative containers**; alternate white/grey backgrounds for rhythm

## Workflow

1. Understand user input (topic, outline, document, data, or images)
2. Plan deck structure (10-20 slides, narrative arc)
3. Encode local images as base64 for portability
4. Write HTML using reference template and component library
5. Save and deliver file path

## Output

Self-contained `.html` file with:
- Keyboard navigation (← →)
- Touch/swipe support
- Responsive typography
- All assets embedded (no external dependencies)
