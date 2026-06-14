---
name: Three.js Architectural Massing
description: Generate interactive 3D architectural massing studies as self-contained HTML files using Three.js — volumetric models from footprints and storey heights, with orbit controls and material zones.
when_to_use: when generating a 3D massing model for a building concept, visualizing a volumetric study for a client presentation, creating an interactive 3D HTML model from a building description, or studying the relationship between a building and its site in three dimensions — oppure quando si genera un modello di massa 3D per un concept edilizio, si visualizza uno studio volumetrico per una presentazione cliente, si crea un modello HTML 3D interattivo da una descrizione dell'edificio, o si studia la relazione tra un edificio e il suo sito in tre dimensioni
version: 1.0.0
languages: all
allowed-tools:
  - Write
  - Read
---

# /threejs-massing — Three.js Architectural Massing

Generates interactive 3D massing studies as self-contained HTML files. No server, no dependencies — opens directly in any browser. Orbit, zoom, and pan with mouse.

## Usage

```
/threejs-massing edificio residenziale 4 piani, impronta 15×20m, piano terra commerciale
/threejs-massing office tower: 25 floors, 30×30m footprint, set back above floor 5
/threejs-massing villa: L-shaped plan, 2 floors, pool terrace, flat roof
/threejs-massing urban block: 6 buildings, courtyard, vary heights 3–6 floors
```

## What It Produces

Self-contained HTML file with:
- **Three.js CDN** (loaded from cdn.jsdelivr.net)
- Orbit controls (mouse drag = rotate, scroll = zoom, right-drag = pan)
- **Ground plane** with site boundary
- **Building volumes** as BoxGeometry / custom extruded shapes
- **Material zones**: glass (blue tint), concrete (grey), ground floor (darker)
- **Shadows** enabled for realism
- **Compass** indicator and scale reference
- **Camera presets**: street view, aerial, isometric buttons

## Model Geometry Strategy

### Simple Rectangular Volume
```javascript
// For a 15×20m building, 4 floors at 3m each = 12m total
const geometry = new THREE.BoxGeometry(15, 12, 20);
const material = new THREE.MeshLambertMaterial({ color: 0xd0c8b8 });
```

### Setbacks and Stepbacks
- Model as separate BoxGeometry volumes stacked vertically
- Each volume: `new THREE.BoxGeometry(w, h, d)` positioned at correct Y offset

### Complex Footprints (L-shape, U-shape, courtyard)
Use `THREE.Shape` + `THREE.ExtrudeGeometry`:
```javascript
const shape = new THREE.Shape();
shape.moveTo(0, 0);
shape.lineTo(20, 0);
shape.lineTo(20, 10);
shape.lineTo(12, 10);
shape.lineTo(12, 20);
shape.lineTo(0, 20);
shape.closePath();
const extruded = new THREE.ExtrudeGeometry(shape, { depth: 12, bevelEnabled: false });
```

### Façade Materials
```javascript
// Ground floor commercial: darker
const groundMaterial = new THREE.MeshLambertMaterial({ color: 0x8a7a6a });
// Upper floors residential: warm grey
const upperMaterial = new THREE.MeshLambertMaterial({ color: 0xd0c8b8 });
// Glazing: blue-tinted semi-transparent
const glassMaterial = new THREE.MeshLambertMaterial({
  color: 0x88aacc, transparent: true, opacity: 0.6
});
// Roof: flat, slightly darker
const roofMaterial = new THREE.MeshLambertMaterial({ color: 0x999088 });
```

## Standard HTML Template Structure

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>[Project] — Massing Study</title>
  <style>
    body { margin: 0; background: #f0ede8; font-family: Helvetica, Arial, sans-serif; }
    canvas { display: block; }
    #ui { position: absolute; top: 10px; left: 10px; background: rgba(255,255,255,0.85);
           padding: 12px; border-radius: 4px; font-size: 12px; }
    #views { position: absolute; top: 10px; right: 10px; }
    .btn { padding: 6px 12px; margin: 2px; background: white; border: 1px solid #ccc;
            border-radius: 3px; cursor: pointer; font-size: 11px; }
    .btn:hover { background: #eee; }
  </style>
</head>
<body>
<div id="ui">
  <b>[Project Name]</b><br>
  [Description]<br><br>
  <span style="color:#666">Drag: rotate &nbsp; Scroll: zoom<br>Right-drag: pan</span>
</div>
<div id="views">
  <button class="btn" onclick="setView('street')">Street</button>
  <button class="btn" onclick="setView('aerial')">Aerial</button>
  <button class="btn" onclick="setView('iso')">Isometric</button>
</div>

<script src="https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/three@0.160.0/examples/js/controls/OrbitControls.js"></script>
<script>
  // Scene setup
  const scene = new THREE.Scene();
  scene.background = new THREE.Color(0xf0ede8);
  scene.fog = new THREE.Fog(0xf0ede8, 100, 400);

  const renderer = new THREE.WebGLRenderer({ antialias: true });
  renderer.setSize(window.innerWidth, window.innerHeight);
  renderer.shadowMap.enabled = true;
  document.body.appendChild(renderer.domElement);

  const camera = new THREE.PerspectiveCamera(45, window.innerWidth/window.innerHeight, 0.1, 1000);
  camera.position.set(60, 40, 60);

  const controls = new THREE.OrbitControls(camera, renderer.domElement);
  controls.enableDamping = true;
  controls.dampingFactor = 0.05;

  // Lights
  const ambient = new THREE.AmbientLight(0xffffff, 0.5);
  scene.add(ambient);
  const sun = new THREE.DirectionalLight(0xfff5e0, 1.2);
  sun.position.set(50, 80, 30);
  sun.castShadow = true;
  scene.add(sun);

  // Ground plane
  const groundGeo = new THREE.PlaneGeometry(200, 200);
  const groundMat = new THREE.MeshLambertMaterial({ color: 0xe8e4dc });
  const ground = new THREE.Mesh(groundGeo, groundMat);
  ground.rotation.x = -Math.PI / 2;
  ground.receiveShadow = true;
  scene.add(ground);

  // [BUILDING VOLUMES INSERTED HERE]

  // View presets
  function setView(v) {
    if (v === 'street') { camera.position.set(40, 8, 40); controls.target.set(0, 8, 0); }
    if (v === 'aerial') { camera.position.set(0, 80, 0.1); controls.target.set(0, 0, 0); }
    if (v === 'iso') { camera.position.set(60, 40, 60); controls.target.set(0, 10, 0); }
    controls.update();
  }

  // Animate
  function animate() {
    requestAnimationFrame(animate);
    controls.update();
    renderer.render(scene, camera);
  }
  animate();

  window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
  });
</script>
</body>
</html>
```

## Scale Convention

All dimensions in **meters** = Three.js units. A 4-storey building at 3m/floor = Y height of 12 units.

## Output

Saved as `[project-name]-massing.html`. Opens with double-click in any browser. No internet required after first load (CDN cached), or add `--no-internet` flag to embed Three.js inline (larger file).

## Limitations

- No texture mapping (materials are flat colors — edit in browser dev tools or Illustrator SVG export)
- No interior spaces (solid massing only)
- No automated sun study (position sun manually by adjusting DirectionalLight position)
- Not connected to CAD/BIM — schematic only
