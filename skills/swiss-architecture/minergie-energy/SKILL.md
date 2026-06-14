---
name: MINERGIE and Swiss Energy Performance
description: Swiss energy performance standards — MINERGIE certification levels, SIA 380/1 thermal requirements, cantonal energy directives (MuKEn), and energy proof documentation.
when_to_use: when designing to MINERGIE standard, preparing the energy proof (Energienachweis) for a building permit, selecting a Swiss energy label target, evaluating a building's energy performance, or advising a client on Swiss energy requirements — oppure quando si progetta per lo standard MINERGIE, si prepara la documentazione energetica per il permesso di costruire, si sceglie l'etichetta energetica svizzera da raggiungere, si valuta la prestazione energetica di un edificio, o si consigliano i clienti sui requisiti energetici svizzeri
version: 1.0.0
languages: all
allowed-tools:
  - WebFetch
  - Read
---

# /minergie-energy — MINERGIE and Swiss Energy Performance

## Swiss Energy Certification Hierarchy

| Label | Energy demand | Key requirements | Typical premium over standard |
|-------|--------------|-----------------|-------------------------------|
| **Standard** (cantonal) | Per MuKEn | Minimum legal requirement | — |
| **MINERGIE** | ≤38 kWh/m²a (SIA 380/1) | Controlled ventilation, envelope quality | +3–8% construction cost |
| **MINERGIE-P** | ≤30 kWh/m²a (Passivhaus level) | Excellent envelope, MVHR, no thermal bridges | +8–15% |
| **MINERGIE-A** | Net zero / positive energy | Renewable generation ≥ demand | +15–25% |
| **MINERGIE-ECO** | Add-on: health and ecology | Material emissions, daylight, acoustics | +2–5% on top of base |

## SIA 380/1 — Thermal Energy in Buildings

The Swiss standard for thermal energy calculation. Required for building permits in all cantons.

### Key Indicators
- **Qh**: Annual heating demand [kWh/m²a] — primary metric
- **Qww**: Domestic hot water demand
- **Qk**: Cooling demand (if mechanically cooled)
- **Uw**: U-value of thermal envelope elements [W/m²K]
- **η**: Thermal bridge correction factor

### Typical U-value Targets

| Element | Standard (MuKEn) | MINERGIE | MINERGIE-P |
|---------|-----------------|----------|------------|
| Roof/ceiling | ≤0.20 W/m²K | ≤0.15 | ≤0.10 |
| Wall | ≤0.25 W/m²K | ≤0.17 | ≤0.12 |
| Floor (ground) | ≤0.25 W/m²K | ≤0.20 | ≤0.12 |
| Windows | ≤1.20 W/m²K | ≤1.00 | ≤0.80 |

## MuKEn — Cantonal Energy Model Prescriptions

The MuKEn (Mustervorschriften der Kantone im Energiebereich) is adopted by most cantons as their energy law. Key requirements (2014 edition, most cantons):

- New buildings: heating demand ≤ SIA 380/1 limits
- **No new oil/gas heating** for new buildings (most cantons from 2023)
- Renovation: thermal envelope upgrade on element replacement
- Renewable energy minimum for new buildings (varies by canton)
- Heat pump / solar / district heating preferred

## Energienachweis (Energy Proof) for Building Permit

Required in all cantons. Process:

1. **Software calculation**: LESOSAI (most common), ENERGIETOOL, or cantonal tool
2. **Input data**: building geometry, envelope U-values, HVAC system, occupancy
3. **Output**: Qh value, compliance statement, MINERGIE pre-certification if targeted
4. **Submission**: with building permit application; cantonal energy office reviews

## Heating System Options (post-fossil transition)

| System | Applicability | Notes |
|--------|---------------|-------|
| **Air-source heat pump** | Most buildings | Cost-effective, increasing COP |
| **Ground-source heat pump** | Good where ground conditions permit | Higher efficiency, requires boring permit |
| **District heating** (Fernwärme) | Urban areas | Canton/city dependent availability |
| **Wood pellet** | Rural, low-density | CO2-neutral, storage space needed |
| **Solar thermal + HP** | All | Combination reduces HP runtime |
| **PV + HP** | All | Self-consumption optimization |

## MINERGIE Certification Process

1. **Registration**: online at minergie.ch, choose label
2. **Planning**: design to target U-values and Qh; commission LESOSAI calculation
3. **Application**: submit to MINERGIE with energy proof and plans
4. **Building**: quality control during construction (envelope airtightness test required for P)
5. **Commissioning**: blower door test (n50 ≤ 0.6/h for MINERGIE-P)
6. **Certification**: label issued, valid for building life

## Useful References

- minergie.ch — certification portal
- sia.ch/normen — SIA 380/1 purchase
- lesosai.com — calculation software
- energieschweiz.ch — federal energy program
