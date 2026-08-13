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

**`room.Area` is not reliable as written above — and two attempted fixes both failed.** Confirmed on a real install: `makeSpace(walls, ...)` computed `Area = 799999.99...` mm² (≈0.8 m²) for a room whose real interior is ~10.6 m², suspiciously equal to just one wall's face area (4000mm × 200mm). Passing a list of unjoined wall objects does not reliably establish the space boundary.

`Arch.addSpaceBoundaries(room, subobjects)` looks like the fix, but:
- Calling it with the plain wall objects (`Arch.addSpaceBoundaries(room, walls)`) raises `AttributeError: 'FeaturePython' object has no attribute 'SubElementNames'` — internally it expects `SelectionObject`-like items (as returned by `Gui.Selection.getSelectionEx()`), not plain document objects or the `(obj, ("Face1",))` tuple format its own docstring claims also works.
- Working around that by passing objects that fake the expected shape (`class FakeSel: Object = obj; SubElementNames = ("Face1",)`) avoids the `AttributeError`, but FreeCAD then prints `Arch: error computing space boundary for Living Room` internally and `room.Area` is unchanged — so guessing `"Face1"` as the interior-facing face name is wrong (and likely differs per wall depending on orientation), and this path has not been made to work.

Until someone works out the correct per-wall face name (or confirms this genuinely requires an interactive GUI selection, not a scriptable one), **treat `room.Area` as untrustworthy** — don't report an area to the user without independently confirming it against a hand-calculated interior footprint.

## Doors, windows, and facades

**Do not create a window with bare `Arch.makeWindow(width=, height=)`** — confirmed on a real install: even with `Hosts` correctly set, its `Shape` raises `RuntimeError: shape is invalid`. This matches `Arch.makeWindow`'s own docstring: without a `baseobj` sketch or explicit `parts`, `WindowParts` is left undefined and the object stays shapeless.

Use `Arch.makeWindowPreset` instead — verified to produce valid geometry:

```python
window = Arch.makeWindowPreset(
    "Open 1-pane",   # windowtype - must be one of Arch.WindowPresets
    1200, 1400,       # width, height
    100, 30, 100,     # h1, h2, h3 - vertical frame/sash dimensions (mm)
    30, 30,           # w1, w2 - horizontal frame/sash dimensions (mm)
    0, 0,             # o1, o2 - offsets (mm)
)
window.Hosts = [walls[0]]      # NOT window.Hosted — confirmed via window.PropertiesList
window.Placement.Base = App.Vector(1000, 0, 900)   # position along the wall + sill height
doc.recompute()
```
Verified on a real FreeCAD 1.1.3 install: `window.Shape.Volume` came out to `21271200.0` (nonzero, valid) with the call above, versus `RuntimeError` for bare `makeWindow`. `Arch.WindowPresets` lists the valid `windowtype` values (`'Fixed'`, `'Open 1-pane'`, `'Open 2-pane'`, `'Sash 2-pane'`, `'Sliding 2-pane'`, `'Simple door'`, `'Glass door'`, `'Sliding 4-pane'`, `'Awning'`, `'Opening only'`); `h1/h2/h3/w1/w2/o1/o2` control frame/sash proportions and were not individually verified for visual correctness — only that they produce a valid, non-degenerate shape. `window.Hosts` (not `Hosted`) is the confirmed correct property for attaching to a wall.

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
template.Template = "/path/to/some_template.svg"   # required — see note below

view = doc.addObject("TechDraw::DrawViewArch", "PlanView")   # or DrawViewPart for a plain projection
view.Source = floor    # a single object, NOT a list — confirmed: [floor] raises
                        # "TypeError: Type must be App.DocumentObject or None, not list"
view.Direction = App.Vector(0, 0, 1)   # top-down = plan view; (0,-1,0) etc. for an elevation/facade view
page.addView(view)
doc.recompute()
```
Verified on a real FreeCAD 1.1.3 install: with `view.Source` as a single object, `page.addView`/`doc.recompute()` complete with no errors and `view.State == ['Up-to-date']`. The one bug found was `Source` taking a list (matching the plural-sounding property name is a natural but wrong assumption).

**`template.Template` is not auto-populated** — creating a `TechDraw::DrawSVGTemplate` object leaves its `Template` property (the actual `.svg` file path) as an empty string; recompute still succeeds, but the page has no real layout/border until you assign a real template file path. FreeCAD ships default templates (typically under its install's `data/Mod/TechDraw/Templates/`) — locate one for the installed version rather than assuming a path.

Export with `TechDraw` GUI-side commands, or via `importSVG`/`importDXF` modules for headless SVG/DXF/PDF output — confirm the exact export call against the installed version the same way as above (not verified in this pass).

## Verification

After generating a plan, check it satisfies the stated intent before reporting done — a script that ran without error has NOT proven the geometry is right (see the walls/area/window pitfalls above, all of which run silently to completion while producing wrong results):

- Room count and names: `[o.Label for o in doc.Objects if getattr(getattr(o, "Proxy", None), "Type", None) == "Space"]` (not `isDerivedFrom` — see above).
- Each wall is actually hollow/thin, not a solid block: compare `sum(w.Shape.Volume for w in walls)` against the hand-calculated hollow-loop volume (`perimeter * width * height`) for the requested dimensions — they should match closely, not be an order of magnitude larger.
- `room.Area` against a hand-calculated interior footprint before reporting it — do not repeat it to the user unverified; this is a known-broken value with no confirmed fix (see above).
- Window/door presence: use `Arch.makeWindowPreset`, not bare `Arch.makeWindow` (see above), and still confirm with `window.Shape.Volume` (non-zero, no `RuntimeError`) rather than trusting a clean script exit.
- Overall footprint: `floor.Shape.BoundBox` if a floor's shape is meaningful, or the fused wall outline.

See `skills/cad/freecad-scripting` for the general verification pattern.
