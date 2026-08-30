# INDEX-13 — BIM, CAD e modellazione 3D

**Ambito.** Modellazione parametrica e BIM: Bonsai/Blender IFC, FreeCAD, editor 3D di edifici.

**Si attiva quando il task riguarda:** modellare in BIM o CAD: IFC, Bonsai/Blender, FreeCAD, pianta, muri, solai, facciate, tavole 2D, modello 3D di edificio.

**Già installate localmente:** superpowers-skills: cad/ (2 skill: freecad-scripting, freecad-bim-modeling)

**Contenuto:** 2 repository, 7 skill.

## Come procedere

1. Leggi la tabella qui sotto e scegli **al massimo 2-3 skill** pertinenti al task.
2. Se la skill sta in un repository non ancora sul disco, recuperalo con
   `skill-select fetch <repo>`. **Non clonare a mano**: perderesti la cache condivisa,
   e su una home con spazi o apostrofi il clone diretto può riuscire in apparenza
   senza scrivere nulla — `skill-select` sceglie un percorso sicuro e se ne accorge.
3. Apri con Read, sul percorso completo (`.../SKILL.md`), le skill scelte e nessun'altra.
4. **Non caricare l'intera categoria**: questo indice esiste proprio per evitarlo.
5. Se nessuna skill copre il task, dillo e passa a `INDEX-01-cataloghi-skill.md` per cercarne una nuova.

## Repository della categoria

### bonsai-bim-skills
- **Origine:** ProfRino/bonsai-bim-skills
- **Cosa offre:** Fork completo (licenza GPLv3) di skill BIM per Bonsai/Blender — tenuto separato dalla raccolta MIT per incompatibilità di licenza.
- **Inventario:** 7 skill
- **Skill:** bonsai-drawings, bonsai-openings, bonsai-project-setup, bonsai-roofs, bonsai-spaces-grid, bonsai-stairs, bonsai-walls

### editor
- **Origine:** pascalorg/editor
- **Cosa offre:** Editor 3D (Pascal Editor) per la progettazione di edifici, con React Three Fiber e WebGPU, per modellare pareti, solai e zone.
- **Inventario:** 0 skill
- **Skill:** nessuna SKILL.md — è una libreria/tool, si usa come dipendenza o riferimento

