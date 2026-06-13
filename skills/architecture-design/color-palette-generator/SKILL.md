---
name: Color Palette Generator
description: Generate harmonious color palettes from text descriptions, moods, images, or reference brands — outputs a self-contained HTML file with swatches, hex codes, and WCAG contrast ratios.
when_to_use: when generating a color palette for a project, client presentation, or brand system; extracting colors from a reference image or brand; or building a palette around a single anchor color — oppure quando si crea una palette colori per un progetto o presentazione cliente, si estraggono colori da un'immagine o brand di riferimento, o si costruisce una palette attorno a un colore base
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
  - Bash
---

# /color-palette-generator — Color Palette Generator

Generates harmonious color palettes from descriptions, moods, images, or brand references. Outputs a self-contained HTML file.

## Usage

```
/color-palette-generator warm earth tones for a desert spa
/color-palette-generator Aesop meets Ace Hotel
/color-palette-generator [image] extract palette
/color-palette-generator anchor #2E4057
```

## Input Formats

- Text descriptions ("warm earth tones for a desert spa")
- Image files (extracts color relationships and mood)
- Brand/style references ("Aesop meets Ace Hotel")
- Single anchor colors (builds complete palette around one hex)
- Combinations of the above

## Palette Structure

8-12 colors organized in four groups:

| Group | Count | Purpose |
|-------|-------|---------|
| Primary | 2-3 | Sets dominant mood |
| Secondary | 2-3 | Complementary support |
| Neutral | 2-3 | Backgrounds and text |
| Accent | 1-2 | Emphasis and calls to action |

## Output

Self-contained HTML file with:
- Color swatches with HEX, RGB, HSL values
- Suggested use per color
- Example text pairings with WCAG contrast ratios
- Harmony strip showing all colors together
- **Page itself uses the generated palette** for background, text, headings, borders, accents

## Color Theory Constraints

- Body text: minimum 4.5:1 contrast ratio
- Intentional harmony relationships (complementary, analogous, triadic)
- Balanced warm/cool distribution
- At least one true neutral
