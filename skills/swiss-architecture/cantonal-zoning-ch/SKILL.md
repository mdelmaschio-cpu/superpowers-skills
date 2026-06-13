---
name: Swiss Cantonal Zoning
description: Swiss land use planning and zoning analysis — RPG/LAT zones, FAR calculation, cantonal building regulations, setbacks, and height limits.
when_to_use: when analyzing zoning constraints for a Swiss property, understanding building zone types and permitted uses, calculating maximum buildable area per cantonal rules, checking setbacks and height limits, or advising on land use planning for a Swiss architecture project — oppure quando si analizzano i vincoli urbanistici di una proprietà svizzera, si comprendono i tipi di zona e gli usi ammessi, si calcola la superficie massima edificabile secondo le norme cantonali, si verificano i distacchi e i limiti di altezza, o si consulta un cliente sulla pianificazione territoriale in Svizzera
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Read
---

# /cantonal-zoning-ch — Swiss Cantonal Zoning

## Federal Framework: RPG/LAT

The **Raumplanungsgesetz (RPG)** / **Loi sur l'aménagement du territoire (LAT)** is the federal law governing land use in Switzerland. Key principles:

- **Building zone** (Bauzone): only zones designated in cantonal structure plan (Richtplan/Plan directeur) may be built upon
- **Agricultural zone**: no construction except agricultural use; strict protection
- **Protection zone**: historic sites, nature reserves, water protection areas
- Federal revision RPG 2012: major restriction on rezoning; cantons must reduce oversized building zones

## Zone Types (Cantonal Variation)

Zones are defined by **cantonal building law** and **municipal zone plan (Zonenplan/Plan de zones)**. Common zone types:

| Zone | Typical designation | Main use |
|------|---------------------|----------|
| W2, W3, W4 | Wohnzone 2/3/4 storeys | Residential |
| MK, MZ | Mischzone/Zone mixte | Mixed residential + commercial |
| Z3, Z4 | Zentrumzone | Town centre, high density |
| G, I | Gewerbezone/Zone industrielle | Commercial, industrial |
| OeB | Öffentliche Bauten | Public buildings, schools |
| GS | Grünzone | Green space, parks |
| LW | Landwirtschaftszone | Agricultural (no residential) |

**Always check the municipal Zonenplan** — zone names and rules vary by municipality.

## Key Zoning Parameters

### Ausnutzungsziffer (AZ) / Coefficient d'utilisation du sol (CUS)
Ratio of gross floor area (GF) to site area (Grundstücksfläche):

```
Max GF = Site area × AZ
Example: 800m² site × AZ 0.5 = 400m² GF permitted
```

### Ausnützungsziffer vs. Überbauungsziffer

| Term | Measures | Typical values |
|------|----------|----------------|
| **AZ / CUS** | Floor area ratio | 0.3–2.0 |
| **ÜZ / TOS** | Site coverage (footprint/site) | 20–60% |
| **Baumassenziffer (BMZ)** | Volume/site (older cantons) | 3–8 m³/m² |

### Height Limits

- **Traufhöhe (TH)**: height to eaves
- **Firsthöhe (FH)**: height to ridge
- **Gesamthöhe (GH)**: total building height
- Measured from **natural ground level** (gewachsenes Terrain) or from street level (varies by canton)

### Setbacks (Grenzabstände)

- **Grosser Grenzabstand (GGA)**: main setback (typically = H/2 or fixed distance)
- **Kleiner Grenzabstand (KGA)**: side setback (typically half GGA)
- **Strassenabstand**: distance from road centre line (cantonal road law)
- Check **Baulinienplan** for street alignments

## How to Research a Property's Zoning

1. **map.geo.admin.ch** — federal geoportal: building zones, forests, flooding, contaminated sites
2. **Cantonal geoportal** — more detailed cantonal layers
3. **Municipal zone plan** — exact zone designation (available from municipal website or building authority)
4. **Municipal building regulations** (Baureglement / Règlement des constructions) — AZ, heights, setbacks, parking requirements
5. **Richtplan/Plan directeur** — cantonal strategic plan for future development intentions

## Common Research Portals by Canton

| Canton | Geoportal |
|--------|-----------|
| ZH | maps.zh.ch |
| BE | map.apps.be.ch |
| VD | geo.vd.ch |
| GE | ge.ch/sitg |
| TI | map.geo.ti.ch |
| BS | map.geo.bs.ch |
| Federal | map.geo.admin.ch |

## Special Planning Instruments

- **Sondernutzungsplan / Plan spécial**: detailed plan for a specific area, overrides base zone
- **Gestaltungsplan**: design plan allowing deviation from standard rules in exchange for quality
- **Bebauungsplan**: detailed construction plan (some cantons)
- **Quartierplan**: block plan, used for large developments
- **Denkmalschutzzone**: heritage protection zone — special restrictions apply

## Practical Checklist for a Swiss Site Analysis

- [ ] Identify zone from municipal Zonenplan
- [ ] Obtain Baureglement and read zone-specific rules
- [ ] Calculate max GF using AZ
- [ ] Determine max height (TH, FH, GH)
- [ ] Measure setbacks from all boundaries
- [ ] Check ÜZ (site coverage limit)
- [ ] Verify parking requirement (typically per GF or per dwelling)
- [ ] Check Denkmalschutz, Gewässerschutz, Waldabstand
- [ ] Check Baulinien (building lines from roads)
- [ ] Check Richtplan for strategic overlays
