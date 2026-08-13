---
name: FreeCAD Scripting
description: Drive FreeCAD's Python API and freecadcmd to create, inspect, and modify 3D volumes and .FCStd files from written instructions, with or without the GUI open.
when_to_use: when the user asks to model, draw, assemble, position, space out, union/cut/intersect, resize, or otherwise manipulate 3D volumes in FreeCAD; when a .FCStd file needs to be created, opened, edited, or exported by script; when automating FreeCAD headlessly via freecadcmd or a macro; or as the foundation before skills/cad/freecad-bim-modeling for floor plans and facades
version: 1.0.0
languages: [python]
allowed-tools:
  - Bash
  - Write
  - Read
---

# FreeCAD Scripting

Everything the FreeCAD GUI can do has a Python equivalent — that equivalence is what lets written instructions become 3D geometry. This skill covers the mechanics common to any FreeCAD automation: running scripts, managing documents, creating/positioning/resizing objects, and combining volumes.

Use `skills/cad/freecad-bim-modeling` on top of this one for floor plans, walls, rooms, and facades.

## How to run FreeCAD from Claude Code

Two execution modes, pick based on whether a human needs to watch:

- **`freecadcmd` (headless, default for agent-driven work)** — no GUI, deterministic, scriptable exit codes and stdout. Locate it with `which freecadcmd || which FreeCADCmd`; on an AppImage use `./FreeCAD.AppImage --console`. Run a script with:
  ```bash
  freecadcmd my_script.py
  ```
- **FreeCAD's own Python console** — only when the user has the GUI open and wants to see actions happen live. Same API, plus `FreeCADGui` (aliased `Gui`) is available for view/selection control, which `freecadcmd` does not have.

**If an MCP server for FreeCAD is connected to this session** (several open-source ones exist — they expose FreeCAD as live MCP tools instead of generated scripts), prefer calling those tools directly: you get real-time feedback from the running instance instead of write-then-guess. Check the available tool list first; don't assume one is configured. Fall back to `freecadcmd` when none is available.

## Version drift — verify before trusting memorized calls

FreeCAD's scripting API shifts between major versions (0.20 / 0.21 / 1.0+) — most notably `Draft` gained snake_case aliases alongside its camelCase names (`makeWire` and `make_wire` both exist). Don't assume `Arch` follows the same pattern: confirmed against a real FreeCAD 1.1.3 install (2026-08-13), `Arch` still exposes only camelCase (`makeWall`, `makeSpace`, `makeWindow`, `makeFloor`, `makeBuilding`, `makeStructure` — no `make_*` aliases). Before relying on a function from memory or from this skill:
```bash
freecadcmd -c "import FreeCAD; print(FreeCAD.Version())"
```
then inside a script or console, confirm the real name/signature with `dir(Draft)` / `help(Draft.make_wire)` rather than guessing.

## Document lifecycle

```python
import FreeCAD as App

doc = App.newDocument("Project")          # or App.openDocument("/path/file.FCStd")
# ... create/modify objects ...
doc.recompute()                            # ALWAYS before reading geometry or saving
doc.saveAs("/path/to/Project.FCStd")       # first save; use doc.save() afterward
```
`recompute()` is not optional — parametric objects (booleans, dimensions, placements) don't resolve their geometry until it runs. Reading `.Shape`/`.BoundBox` or saving before a recompute reflects stale state.

## Creating and resizing volumes

Part primitives are parametric: set a property, then `recompute()` — never delete and recreate an object just to change its size.

```python
box = doc.addObject("Part::Box", "Wall1")
box.Length = 4000   # mm, along X
box.Width  = 200    # mm, along Y
box.Height = 2700    # mm, along Z
```
Other primitives follow the same pattern: `Part::Cylinder` (`Radius`, `Height`), `Part::Sphere` (`Radius`), `Part::Cone`. Units default to mm and degrees unless the document's `Unit` preference is changed.

## Positioning and spacing volumes apart

Move or space any object with its `Placement`:
```python
box.Placement = App.Placement(App.Vector(x, y, z), App.Rotation(App.Vector(0, 0, 1), angle_deg))
```
To space two volumes N mm apart along X, set the second object's `Placement.Base.x` to `first.Length + N`.

## Assembling, spacing, and intersecting — boolean operations

| Goal | Object type | Example |
|---|---|---|
| Assemble/union several volumes into one | `Part::MultiFuse` | `fuse = doc.addObject("Part::MultiFuse", "Union"); fuse.Shapes = [box1, box2]` |
| Subtract one volume from another | `Part::Cut` | `cut = doc.addObject("Part::Cut", "Cut"); cut.Base = box1; cut.Tool = box2` |
| Keep only the overlap of volumes | `Part::MultiCommon` | `inter = doc.addObject("Part::MultiCommon", "Intersection"); inter.Shapes = [box1, box2]` |

After any of these, `doc.recompute()` before reading the result. The inputs (`box1`, `box2`, …) stay as children in the tree and remain individually editable — the boolean result updates automatically on recompute.

## Verification, not just execution

A script that exits 0 has not proven anything happened. After running, sanity-check the actual document state — don't report success on a silent exit:
```python
print(len(doc.Objects), "objects")
for obj in doc.Objects:
    if hasattr(obj, "Shape"):
        print(obj.Name, obj.Shape.BoundBox, obj.Shape.Volume)
```
If the user asked for specific dimensions or a specific spatial relationship (touching, N mm apart, fully contained), check the resulting `BoundBox`/`Volume` against that intent before calling the task done.

## Worked example

Two boxes fused, a third cut out, spaced and saved headlessly:
```python
import FreeCAD as App

doc = App.newDocument("Demo")

base = doc.addObject("Part::Box", "Base")
base.Length, base.Width, base.Height = 4000, 3000, 300

pillar = doc.addObject("Part::Box", "Pillar")
pillar.Length, pillar.Width, pillar.Height = 300, 300, 2700
pillar.Placement.Base = App.Vector(0, 0, 300)

assembly = doc.addObject("Part::MultiFuse", "Assembly")
assembly.Shapes = [base, pillar]

notch = doc.addObject("Part::Box", "Notch")
notch.Length, notch.Width, notch.Height = 100, 100, 300
notch.Placement.Base = App.Vector(50, 50, 0)

result = doc.addObject("Part::Cut", "Result")
result.Base = assembly
result.Tool = notch

doc.recompute()
doc.saveAs("/tmp/demo.FCStd")
print(result.Shape.BoundBox, result.Shape.Volume)
```
```bash
freecadcmd demo_script.py
```
