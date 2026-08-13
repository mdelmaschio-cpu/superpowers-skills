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

**Do not pass a single closed wire to `Arch.makeWall`** — confirmed on a real FreeCAD 1.1.3 install: a closed outline produces a *solid filled block* the size of the whole footprint (`Shape.Volume` exactly equals `length × width × height` of the outline), not a hollow loop of walls. The `width` parameter is effectively ignored for a closed wire.

Instead, build each side of the room as its own wall from an **open**, two-point wire, then recompute:

```python
import FreeCAD as App
import Draft, Arch

doc = App.newDocument("Plan")

segments = [
    (App.Vector(0, 0, 0),    App.Vector(4000, 0, 0)),
    (App.Vector(4000, 0, 0), App.Vector(4000, 3000, 0)),
    (App.Vector(4000, 3000, 0), App.Vector(0, 3000, 0)),
    (App.Vector(0, 3000, 0), App.Vector(0, 0, 0)),
]

walls = []
for p1, p2 in segments:
    wire = Draft.make_wire([p1, p2], closed=False)
    walls.append(Arch.makeWall(wire, width=200, height=2700))

doc.recompute()
```
This is verified correct: for the 4000×3000mm outline above with `width=200`, `sum(w.Shape.Volume for w in walls)` comes out to exactly `7560000000.0` — matching the hand-calculated volume of a hollow 200mm-thick perimeter loop (`2*(4000+3000) * 200 * 2700`), and each wall's `Shape.BoundBox` is a thin 200mm-wide strip along its segment, not a block. Building a room from a closed wire is the natural-looking shortcut but is wrong; the per-segment loop above is the pattern to use.

## Rooms and stories

```python
room = Arch.makeSpace(walls, name="Living Room")     # named space enclosed by walls
floor = Arch.makeFloor(walls + [room])                 # groups elements into one story
building = Arch.makeBuilding([floor])                   # stacks stories into a building
```
Group per story with `makeFloor` before stacking multi-story buildings — elements not assigned to a floor won't appear in per-story plan views later.

**`room.Area` is not reliable as written above** — confirmed on a real install: `makeSpace(walls, ...)` computed `Area = 799999.99...` mm² (≈0.8 m²) for a room whose real interior is ~10.6 m², suspiciously equal to just one wall's face area (4000mm × 200mm). Passing a list of unjoined wall objects does not reliably establish the space boundary. `Arch.addSpaceBoundaries` (present in `dir(Arch)`) looks like the relevant fix but has not been verified — treat `room.Area` as untrustworthy until you've confirmed it against a known room size, and don't report an area to the user without that check.

## Doors, windows, and facades

Openings are meant to be hosted on a wall face, with `Arch.makeWindow` handling the cut automatically — but **this could not be verified as working** on a real install:

```python
window = Arch.makeWindow(width=1200, height=1400)
window.Hosts = [walls[0]]  # NOT window.Hosted — confirmed via window.PropertiesList
window.Placement.Base = App.Vector(1000, 0, 900)   # position along the wall + sill height
doc.recompute()
```
`window.Hosts` (not `Hosted`) is the confirmed correct property. However, after this, `window.Shape.Volume` raised `RuntimeError: shape is invalid` — a bare `makeWindow(width=, height=)` with no `Preset`/`WindowParts` does not produce valid geometry on 1.1.3. Before relying on this for real work, set a `Preset` (see `Arch.WindowPresets` / `Arch.makeWindowPreset`) or inspect the object in the GUI — do not assume the opening exists just because the script ran without error.

A facade is not a distinct object type — model it as the exterior wall(s) (or `Arch.makeStructure` for a non-wall facade element like a curtain-wall panel or column grid) with windows/doors hosted on it. Position openings by setting `Placement.Base` relative to the host wall's local origin; use `Draft.move`/`Draft.rotate` to reposition existing elements instead of recreating them.

## Changing dimensions after modeling

Same rule as `skills/cad/freecad-scripting`: these are parametric, so mutate the property and recompute — don't delete/recreate.
```python
walls[0].Width = 250   # thicken one wall segment
window.Height = 1600    # resize the opening
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

After generating a plan, check it satisfies the stated intent before reporting done — a script that ran without error has NOT proven the geometry is right (see the walls/area/window pitfalls above, all of which run silently to completion while producing wrong results):

- Room count and names: `[o.Label for o in doc.Objects if getattr(getattr(o, "Proxy", None), "Type", None) == "Space"]` (not `isDerivedFrom` — see above).
- Each wall is actually hollow/thin, not a solid block: compare `sum(w.Shape.Volume for w in walls)` against the hand-calculated hollow-loop volume (`perimeter * width * height`) for the requested dimensions — they should match closely, not be an order of magnitude larger.
- `room.Area` against a hand-calculated interior footprint before reporting it — do not repeat it to the user unverified (see above).
- Window/door presence: don't trust that a `makeWindow` call succeeded just because it didn't raise — try `window.Shape.Volume` (or inspect the object in the GUI) and expect it may need a `Preset` first.
- Overall footprint: `floor.Shape.BoundBox` if a floor's shape is meaningful, or the fused wall outline.

See `skills/cad/freecad-scripting` for the general verification pattern.
