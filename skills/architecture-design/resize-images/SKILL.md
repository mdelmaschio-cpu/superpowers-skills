---
name: Resize Images
description: Batch-resize photos for web, social media, slides, and print — organized into dedicated output subfolders using Python/Pillow.
when_to_use: when preparing project photos for multiple output destinations, resizing images for presentations or social posts, or exporting architecture photos to print-ready DPI and dimensions
version: 1.0.0
languages: all
allowed-tools:
  - Bash
  - Read
  - Write
---

# /resize-images — Batch Image Resizer

Batch-resizes photos to multiple output formats for web, social, slides, and print.

## Usage

```
/resize-images
```

Prompts for source folder and desired output types.

## Output Types

| Type | Format | Sizes |
|------|--------|-------|
| **Web** | WebP | 1920px, 1200px, 400px wide (aspect preserved) |
| **Social** | WebP | Instagram 1080×1080, portrait 1080×1350, Twitter 1200×675, LinkedIn 1200×627 |
| **Slides** | JPEG | 4:3 (1024×768), 16:9 (1920×1080) |
| **Print** | JPEG 300 DPI | ARCH A (9×12"), ARCH B (12×18"), ARCH C (18×24") |

Social and slide outputs are center-cropped to fill target dimensions.

## Supported Input Formats

`.jpg`, `.jpeg`, `.png`, `.tif`, `.tiff`, `.webp`

## Output Organization

Creates subfolders within the source directory:
- `resized-web/`
- `resized-social/`
- `resized-slides/`
- `resized-print/`

## Behavior

- Originals are preserved untouched
- Aspect ratio preserved for web outputs (no upscaling)
- Transparency converted to RGB for JPEG outputs
- Individual file failures logged without stopping the batch
- Reports file sizes in KB per output

## Requirements

Python with `Pillow` installed (`pip install Pillow`)
