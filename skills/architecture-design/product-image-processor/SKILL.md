---
name: Product Image Processor
description: Batch-download, resize, and remove backgrounds from product images stored in a Google Sheet.
when_to_use: when preparing product images for presentations or schedules, removing backgrounds from furniture photos, or batch-resizing product images to a standard size — oppure quando si preparano immagini prodotto per presentazioni o computi, si rimuovono gli sfondi da foto di arredamento, o si ridimensionano in batch immagini prodotto
version: 1.0.0
languages: all
allowed-tools:
  - Bash
  - Read
  - Write
---

# /product-image-processor — Product Image Processor

Automates downloading, resizing, and background removal for product images stored in Google Sheets.

## Usage

```
/product-image-processor
```

Prompts for spreadsheet ID, column locations, and output directory.

## Workflow

1. **Input collection** — gather sheet ID, image URL column, product name column, output directory
2. **URL retrieval** — read image URLs and product names from Google Sheet
3. **Folder setup** — create output directory with `originals/`, `resized/`, `nobg/` subdirectories
4. **Download** — use `curl` (NOT WebFetch) to download images, named sequentially with slugified product names
5. **Resize** — Python/PIL normalizes to max 2000px on longest edge, all converted to RGBA PNG
6. **Background removal** — `rembg` library strips backgrounds from resized images
7. **Report** — summary table showing success/failure counts per stage

## Important

**Use `curl`, NOT WebFetch.** WebFetch processes content through an AI model which corrupts binary image data.

Resizing preserves aspect ratio without upscaling. The rembg model (~170MB) downloads on first use only. Individual failures at any stage are logged without stopping the batch.

## Requirements

- Python with `PIL`/`Pillow` installed
- `rembg` library installed (`pip install rembg`)
- `curl` available in shell
