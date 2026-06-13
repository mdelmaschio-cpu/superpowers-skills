---
name: Architectural Rendering Prompt
description: Generate optimized prompts for AI image generators (Midjourney, DALL-E, Adobe Firefly, Stable Diffusion) to produce architectural concept renderings from a building description.
when_to_use: when generating an architectural concept rendering using an AI image generator, creating a mood image for a client presentation, visualizing a design concept before detailed modeling, writing prompts for Midjourney or DALL-E for architecture, or generating exterior/interior visualization images using Adobe Firefly — oppure quando si genera un rendering architettonico concettuale con un generatore di immagini AI, si crea un'immagine di mood per una presentazione cliente, si visualizza un concept di progetto prima della modellazione dettagliata, si scrivono prompt per Midjourney o DALL-E per architettura, o si generano immagini di visualizzazione esterna/interna con Adobe Firefly
version: 1.0.0
languages: all
allowed-tools:
  - Read
  - Write
---

# /rendering-prompt — Architectural Rendering Prompt Generator

Generates optimized text prompts for AI image generators to produce architectural concept renderings. Works with Midjourney, DALL-E 3, Adobe Firefly, Stable Diffusion, and similar tools.

## Usage

```
/rendering-prompt villa contemporanea in pietra naturale e vetro, Ticino, sera
/rendering-prompt open space ufficio minimalista, luce naturale zenitale, materiali naturali
/rendering-prompt edificio residenziale urbano Zurigo, facciata in calcestruzzo prefabbricato
/rendering-prompt interior: soggiorno con doppia altezza, travi legno, caminetto in pietra
```

## Prompt Architecture

A strong architectural rendering prompt has 6 components:

```
[SUBJECT] + [STYLE] + [MATERIALS] + [LIGHT] + [VIEW] + [QUALITY TAGS]
```

### Component Guide

| Component | What to specify | Examples |
|-----------|----------------|---------|
| **Subject** | Building type, program, setting | "contemporary single family house", "urban office lobby" |
| **Style** | Architectural reference or aesthetic | "Swiss brutalism", "Alpine vernacular contemporary", "Tadao Ando inspired" |
| **Materials** | Primary materials, textures | "raw concrete", "local stone", "corten steel", "larch wood cladding" |
| **Light** | Time of day, season, weather | "golden hour", "overcast Nordic light", "interior artificial warm", "winter morning" |
| **View** | Camera position and angle | "street level perspective", "aerial view", "interior wide angle", "detail shot" |
| **Quality** | Rendering style tags | "architectural photography", "photorealistic", "8K", "Hélène Binet style" |

## Midjourney Prompts (Recommended Format)

```
/imagine [subject], [style reference], [materials], [lighting], [view],
architectural photography, photorealistic, shot on Hasselblad,
8K resolution, f/8, natural light --ar 16:9 --v 6 --style raw --q 2
```

### Exterior Examples

**Contemporary Swiss House:**
```
contemporary villa in Ticino Switzerland, flat roof, floor-to-ceiling glazing,
natural stone cladding and weathered concrete, surrounded by chestnut forest,
golden hour soft light, dusk, warm interior light glowing through glass,
street level perspective slightly below eye level, architectural photography,
photorealistic, Hélène Binet inspired, 8K --ar 16:9 --v 6 --style raw
```

**Urban Residential Block:**
```
contemporary urban residential building Zurich, prefabricated concrete facade
with recessed balconies, ground floor retail, mature street trees, overcast
northern European light, pedestrian street level view, subtle reflections,
architectural photography, Peter Zumthor aesthetic, photorealistic 8K --ar 3:2 --v 6
```

**Alpine Renovation:**
```
traditional alpine farmhouse renovation, new glass extension, old stone walls
meeting minimal modern addition, mountain landscape background, afternoon sun
casting long shadows, exterior view from meadow, documentary photography style,
natural colors, Graubünden Switzerland --ar 16:9 --v 6 --style raw
```

### Interior Examples

**Minimal Living Space:**
```
minimalist living room, double height ceiling, exposed concrete walls,
larch wood floor, large south-facing window with mountain view,
natural diffused light, morning, warm neutral tones, single oak coffee table,
interior architectural photography, John Pawson aesthetic, 8K --ar 16:9 --v 6
```

**Office Open Space:**
```
contemporary open plan office, exposed concrete soffit, industrial steel
pendant lights, natural wood desks, acoustic panels in sage green,
abundant natural light from north-facing windows, people working,
candid photography style, photorealistic --ar 16:9 --v 6
```

## DALL-E 3 Prompts (OpenAI / ChatGPT)

DALL-E responds better to descriptive paragraphs than comma-separated tags:

```
A photorealistic architectural rendering of [building description].
The building features [materials and key design elements].
The scene is lit by [lighting conditions] at [time of day].
The viewpoint is [camera position and angle].
The overall aesthetic is [style reference].
Rendered in the style of professional architectural photography.
```

**Example:**
```
A photorealistic architectural rendering of a contemporary single-family house
in southern Switzerland. The building features a flat roof, exposed concrete
walls, and a large glazed facade overlooking a terraced garden. The scene is
lit by warm golden hour light with the interior glowing softly through the glass.
The viewpoint is a low street-level perspective looking up at the main entrance.
The overall aesthetic is reminiscent of Peter Zumthor's sensibility for
materiality and light. Rendered in the style of professional architectural
photography with a Hasselblad camera.
```

## Adobe Firefly Prompts

Firefly works best with shorter, direct prompts. Avoid overly complex references:

```
[subject], [materials], [lighting], [style]
architectural photography, photorealistic
```

**Example:**
```
contemporary alpine house, stone and glass, golden hour exterior,
professional architectural photography, photorealistic
```

Use Firefly's **Structure Reference** feature: upload a sketch or massing model
as structure image → describe materials and lighting in prompt → Firefly
preserves the geometry while generating photorealistic surfaces.

## Negative Prompts (Midjourney `--no`)

Always add to avoid common AI rendering failures:

```
--no distorted windows, asymmetric facade, floating elements, 
cartoon style, watercolor, sketch, people in foreground blocking building,
fisheye lens, oversaturated colors, unrealistic proportions
```

## Style Reference Photographers and Architects

Use these names in prompts for consistent aesthetic results:

| Reference | Style produced |
|-----------|---------------|
| **Hélène Binet** | Black & white, shadows, materiality |
| **Iwan Baan** | Documentary, people, context |
| **Fernando Guerra** | Warm light, drama, luxury |
| **Peter Zumthor** | Austere, material, Swiss |
| **Tadao Ando** | Concrete, geometry, Japanese minimalism |
| **Kengo Kuma** | Natural materials, screens, Japanese |
| **Herzog & de Meuron** | Texture, material experimentation |
| **Valerio Olgiati** | White concrete, monolithic, Swiss |

## Workflow: Concept → Rendering

1. Generate massing with `/threejs-massing` → screenshot from desired angle
2. Use screenshot as **image reference** in Midjourney (`/imagine [url] [prompt] --iw 0.5`)
3. Or use as **Structure Reference** in Adobe Firefly
4. Iterate: adjust materials, lighting, camera in follow-up prompts
5. Upscale best result (Midjourney U1–U4 or Firefly upscale)
6. Use in `/slide-deck-generator` or client presentation

## Saving Prompts

Keep a project prompt log (`prompts-log.md`) with:
- Date and tool used
- Full prompt text
- Result file name
- What worked / what to adjust
