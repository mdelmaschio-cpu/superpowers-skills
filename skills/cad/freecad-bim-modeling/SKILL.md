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

**`room.Area` is wrong as written above — `makeSpace(walls, ...)` computed `Area = 799999.99...` mm² (≈0.8 m²)** for a room whose real interior is ~10.6 m², suspiciously equal to just one wall's face area. Passing a list of unjoined wall objects at creation time does not reliably establish the space boundary.

**Verified fix**: create the `Space` empty (no `objectslist` arg), then add boundaries explicitly via `Arch.addSpaceBoundaries`, using the actual interior-facing face of each wall — computed geometrically, not guessed:

```python
def find_interior_face(wall, room_center):
    """Returns the index (0-based) of the wall's face whose normal points
    most toward room_center, i.e. the interior-facing face."""
    best_idx, best_dot = None, -1e9
    for i, face in enumerate(wall.Shape.Faces):
        u0, u1, v0, v1 = face.ParameterRange
        normal = face.normalAt((u0 + u1) / 2.0, (v0 + v1) / 2.0)
        to_room = App.Vector(room_center.x - face.CenterOfMass.x,
                              room_center.y - face.CenterOfMass.y, 0)
        if to_room.Length < 1e-6:
            continue
        to_room.normalize()
        n2d = App.Vector(normal.x, normal.y, 0)
        if n2d.Length < 1e-6:
            continue
        n2d.normalize()
        dot = n2d.dot(to_room)
        if dot > best_dot:
            best_idx, best_dot = i, dot
    return best_idx

class _BoundarySel:
    """Stand-in for a Gui.Selection SelectionObject — addSpaceBoundaries
    requires .Object/.SubElementNames, not plain objects or (obj, ("FaceN",))
    tuples despite its own docstring claiming the tuple format also works."""
    def __init__(self, obj, subnames):
        self.Object = obj
        self.SubElementNames = subnames

room_center = App.Vector(2000, 1500, 1350)   # a point inside the room
room = Arch.makeSpace(name="Living Room")     # empty — do NOT pass walls here
doc.recompute()

boundaries = [_BoundarySel(w, ("Face" + str(find_interior_face(w, room_center) + 1),))
              for w in walls]
Arch.addSpaceBoundaries(room, boundaries)
doc.recompute()
```
Verified on a real FreeCAD 1.1.3 install: for the 4000×3000mm/200mm-thick example, this produced `room.Area == 10640000.0` mm² (10.64 m²) — an exact match to the hand-calculated interior footprint `(4000-200) * (3000-200)`. Two earlier attempts failed and are worth knowing about if you hit them again: (1) calling `Arch.addSpaceBoundaries(room, walls)` with plain wall objects raises `AttributeError: 'FeaturePython' object has no attribute 'SubElementNames'`; (2) creating the room *with* `walls` passed to `makeSpace(walls, ...)` and *then* calling `addSpaceBoundaries` on top produces a silently wrong area even with the correct face — the room must be created empty first.

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

## Producing 2D drawings: plans, elevations, sections

**`TechDraw::DrawViewArch` is broken on 1.1.3 — do not use it**, despite it being the type this skill previously recommended and despite `Arch`/BIM documentation still referencing it. Confirmed: `doc.addObject("TechDraw::DrawViewArch", "PlanView")` succeeds and reports `TypeId == "TechDraw::DrawViewArch"`, but the live object has no `Direction` property (`AttributeError: 'TechDraw.DrawViewSymbol' object has no attribute 'Direction'`) — it's a non-functional legacy shell, not a working projection view.

Use **`TechDraw::DrawViewPart`** instead — verified to work for both plan (top-down) and elevation/facade views:

```python
import TechDraw

page = doc.addObject("TechDraw::DrawPage", "Plan")
template = doc.addObject("TechDraw::DrawSVGTemplate", "Template")
page.Template = template
template.Template = "/path/to/some_template.svg"   # required — see note below

planview = doc.addObject("TechDraw::DrawViewPart", "PlanView")
planview.Source = walls              # a LIST of objects with real Shapes (e.g. the wall list) —
                                      # confirmed working; NOT the Arch floor/BuildingPart object
planview.Direction = App.Vector(0, 0, 1)     # top-down = plan
page.addView(planview)

elevview = doc.addObject("TechDraw::DrawViewPart", "ElevationView")
elevview.Source = walls
elevview.Direction = App.Vector(0, -1, 0)    # facade/elevation, looking from -Y; use other axes as needed
page.addView(elevview)
doc.recompute()
```
Verified on a real FreeCAD 1.1.3 install: both views compute with no errors, `State == ['Up-to-date']`.

For a **section**, use `TechDraw::DrawViewSection` — it needs a `BaseView` (an existing `DrawViewPart`) **and** its own `Source` set explicitly; `Source` does NOT auto-populate from `BaseView` (confirmed: left empty after only setting `BaseView`):

```python
section = doc.addObject("TechDraw::DrawViewSection", "SectionA")
section.BaseView = planview
section.Source = walls                       # required — same object list as the BaseView's Source
section.SectionSymbol = "A"
section.SectionNormal = App.Vector(0, 1, 0)   # cutting-plane normal
section.SectionOrigin = App.Vector(2000, 1500, 1350)   # a point on the cutting plane
page.addView(section)
doc.recompute()
```
Verified: `section.State == ['Up-to-date']` and `section.Source` correctly lists the 4 wall `Part::Feature` objects once set explicitly.

**None of these TechDraw view objects expose a `.Shape` property** (`hasattr(view, "Shape")` is `False`) — they're 2D drawing views, not 3D solids, so don't try to verify them with `.Shape.BoundBox` like Arch/Part objects. Verify with `view.State == ['Up-to-date']` (no error string in the list) instead.

**`template.Template` is not auto-populated** — creating a `TechDraw::DrawSVGTemplate` object leaves its `Template` property (the actual `.svg` file path) as an empty string; recompute still succeeds, but the page has no real layout/border until you assign a real template file path. FreeCAD ships default templates (typically under its install's `data/Mod/TechDraw/Templates/`) — locate one for the installed version rather than assuming a path.

Export with `TechDraw` GUI-side commands, or via `importSVG`/`importDXF` modules for headless SVG/DXF/PDF output — confirm the exact export call against the installed version the same way as above (not verified in this pass).

## Verification

After generating a plan, check it satisfies the stated intent before reporting done — a script that ran without error has NOT proven the geometry is right (see the walls/window pitfalls above, all of which run silently to completion while producing wrong results):

- Room count and names: `[o.Label for o in doc.Objects if getattr(getattr(o, "Proxy", None), "Type", None) == "Space"]` (not `isDerivedFrom` — see above).
- Each wall is actually hollow/thin, not a solid block: compare `sum(w.Shape.Volume for w in walls)` against the hand-calculated hollow-loop volume (`perimeter * width * height`) for the requested dimensions — they should match closely, not be an order of magnitude larger.
- `room.Area`: only trust it if the room was built via the empty-`makeSpace` + `addSpaceBoundaries` + computed-interior-face recipe above — compare against a hand-calculated interior footprint before reporting it to the user regardless.
- Window/door presence: use `Arch.makeWindowPreset`, not bare `Arch.makeWindow` (see above), and still confirm with `window.Shape.Volume` (non-zero, no `RuntimeError`) rather than trusting a clean script exit.
- TechDraw views (plan/elevation/section): use `TechDraw::DrawViewPart`/`DrawViewSection`, not `DrawViewArch` (see above), and check `State == ['Up-to-date']` since these objects have no `.Shape` to inspect.
- Overall footprint: `floor.Shape.BoundBox` if a floor's shape is meaningful, or the fused wall outline.

See `skills/cad/freecad-scripting` for the general verification pattern.
