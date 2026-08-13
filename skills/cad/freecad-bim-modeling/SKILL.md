---
name: FreeCAD Architectural (BIM) Modeling
description: Use FreeCAD's Draft, Arch/BIM, and TechDraw workbenches from Python to draw floor plans, walls, rooms, levels, facades, and doors/windows, and export 2D plan drawings.
when_to_use: when the user asks to draw a floor plan (pianta), model walls/rooms/stories, design a facade, place doors/windows, or produce a 2D architectural drawing (plan, elevation) from a FreeCAD model
version: 1.0.0
languages: [python]
allowed-tools:
  - Bash
  - Write
  - Read
---

# FreeCAD Architectural (BIM) Modeling

Architectural elements in FreeCAD (walls, rooms, floors, windows) are parametric objects from the `Draft` and `Arch` Python modules (the workbench is labeled "BIM" in the GUI in recent versions; the underlying module is still `Arch`). This skill assumes the document/recompute/placement/boolean mechanics from `skills/cad/freecad-scripting` — read that first if unfamiliar.

**Verify function names before use** — `Draft` gained snake_case aliases alongside the original camelCase names (`makeWire`/`make_wire` both exist), but `Arch` has NOT been given snake_case aliases as of 1.1.3 — only `makeWall`, `makeSpace`, `makeWindow`, `makeFloor`, `makeBuilding`, `makeStructure` (camelCase) exist. Confirmed against a real FreeCAD 1.1.3 install on 2026-08-13: `dir(Arch)` contains no `make_*` names at all. Check `dir(Draft)` / `dir(Arch)` on the installed version rather than trusting either spelling blind — a future release may add the aliases.

**Objects aren't identifiable by TypeId or class name** — on 1.1.3 every `Arch.make*` result is a generic scripted object (`Part::FeaturePython`, or `App::GeometryPython` for `makeFloor`/`makeBuilding`), so `obj.isDerivedFrom("Arch::Wall")` etc. never matches — there is no such class. Identify what an object *is* with `obj.Proxy.Type` instead (confirmed values: `"Wall"`, `"Space"`, `"Window"`; `makeFloor` produces `Proxy.Type == "BuildingPart"`, not `"Floor"` — Floor/Building/Site are unified under `BuildingPart`, distinguished by the `IfcType` property).

## Floor plan outline → walls

A room/building outline is a closed 2D wire; walls are built on top of it:

```python
import FreeCAD as App
import Draft, Arch

doc = App.newDocument("Plan")

outline = Draft.make_wire([
    App.Vector(0, 0, 0),
    App.Vector(4000, 0, 0),
    App.Vector(4000, 3000, 0),
    App.Vector(0, 3000, 0),
], closed=True)

wall = Arch.makeWall(outline, width=200, height=2700)
doc.recompute()
```
`Arch.makeWall` extrudes the wire into a closed loop of walls with the given thickness (`width`) and story height (`height`). For a single straight wall instead, base it on a two-point `Draft.make_wire` (open, not closed).

## Rooms and stories

```python
room = Arch.makeSpace([wall], name="Living Room")     # named, area-tagged space enclosed by walls
floor = Arch.makeFloor([wall, room])                    # groups elements into one story
building = Arch.makeBuilding([floor])                    # stacks stories into a building
```
Group per story with `makeFloor` before stacking multi-story buildings — elements not assigned to a floor won't appear in per-story plan views later.

## Doors, windows, and facades

Openings are hosted on a wall face, not modeled as separate volumes to boolean-cut yourself — `Arch.makeWindow` handles the cut automatically:

```python
window = Arch.makeWindow(width=1200, height=1400)
window.Hosts = [wall]
window.Placement.Base = App.Vector(1000, 0, 900)   # position along the wall + sill height
```
A facade is not a distinct object type — model it as the exterior `Arch.makeWall` (or `Arch.makeStructure` for a non-wall facade element like a curtain-wall panel or column grid) with windows/doors hosted on it. Position openings by setting `Placement.Base` relative to the host wall's local origin; use `Draft.move`/`Draft.rotate` to reposition existing elements instead of recreating them.

## Changing dimensions after modeling

Same rule as `skills/cad/freecad-scripting`: these are parametric, so mutate the property and recompute — don't delete/recreate.
```python
wall.Width = 250      # thicken the wall
window.Height = 1600   # resize the opening
doc.recompute()
```

## Producing a 2D plan drawing (pianta)

To hand back a printable/exportable floor plan rather than just a 3D model, use `TechDraw`:

```python
import TechDraw

page = doc.addObject("TechDraw::DrawPage", "Plan")
template = doc.addObject("TechDraw::DrawSVGTemplate", "Template")
page.Template = template

view = doc.addObject("TechDraw::DrawViewArch", "PlanView")   # or DrawViewPart for a plain projection
view.Source = [floor]
view.Direction = App.Vector(0, 0, 1)   # top-down = plan view; (0,-1,0) etc. for an elevation/facade view
page.addView(view)
doc.recompute()
```
Export with `TechDraw` GUI-side commands, or via `importSVG`/`importDXF` modules for headless SVG/DXF/PDF output — confirm the exact export call against the installed version the same way as above.

## Verification

After generating a plan, check it satisfies the stated intent before reporting done: room count and names (`[o.Label for o in doc.Objects if getattr(getattr(o, "Proxy", None), "Type", None) == "Space"]` — not `isDerivedFrom`, see above), overall footprint (`floor.Shape.BoundBox` if a floor's shape is meaningful, or the fused outline), and wall thickness/height against what was requested. See `skills/cad/freecad-scripting` for the general verification pattern.
