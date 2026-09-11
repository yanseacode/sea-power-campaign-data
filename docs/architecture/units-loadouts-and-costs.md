# Units, Loadouts, and Costs

## Representation

Unit definitions are split by category under `StreamingAssets/original`: `vessels`, `aircraft`, and `land_units`. A base INI defines the class/platform; companion variant or squadron files define individual hulls, national operators, service periods, liveries, and formations. Mission files reference the base `Type` plus a `VariantReference` or `SquadronReference`.

Do not infer country, availability, or capability from the filename alone. Validate:

- definition-level nation/operator metadata;
- selected variant or squadron metadata;
- service dates;
- loadout dates and allowed weapons;
- mission-level nation/flag overrides;
- actual sensors, launchers, magazines, and carried aircraft.

## Aircraft and air groups

Aircraft definitions contain flight characteristics, sensors, refueling compatibility, and loadout families. Squadron files provide operator identity and service windows. Aircraft in a mission may be airborne, assigned to a land airbase, or carried by a ship. Ship `CustomAirGroup` entries and flight-deck capacity constrain embarked aviation.

Build #365 normalized aerial-refueling configurations, replaced the placeholder KC-135 with KC-10 files, removed the placeholder Tu-16N, and changed Tu-22M2 refueling compatibility. Any campaign using tankers must revalidate both unit availability and receiver/drogue compatibility.

## Ships and submarines

Individual hull variants matter: refits, launchers, sensors, helicopter facilities, and service dates can differ within one class. Build #364–#366 added or changed several loadouts and platforms, including Bunker Hill, Spruance VLS, California date-based Harpoons, restored ship loadouts, corrected Sturgeon dates, a revised Los Angeles load and speed, and an improved Victor III class. Recheck exact 1980s variants after every build.

Submarine effectiveness also depends on weapon load, endurance, noise, sensors, depth, and variant year. A class-level label is insufficient for balancing.

## Land units and installations

`land_units` covers mobile systems, radars, SAM components/sites, airbases, ports, artillery, buildings, infrastructure, and scenery-like mission targets. Composite sites may be represented as several sections or as a convenience definition. Build #364 added the SS-1C Scud-B TEL and ammunition, creating a new strategic land-target option.

## Point costs

`AI/UnitCostValue` is not a reliable Task Force Mode purchase price. Task-force costs are calculated at runtime from the platform, sensors, weapons, magazines, roles, carried capability, and current formula tuning, unless a supported authored override is used.

Current #366 facts:

- formula version is 140;
- formula 134 price snapshots are obsolete for current balancing;
- `HandAuthoredScaleBridge` remains 10 in code;
- the build corrected optional-default-weapon accounting, weapon swaps, manually set scaling, and stores pricing;
- ammunition and stores now have explicit pricing-related tuning in the active assembly.

Regenerate a local price cache after every formula or unit-database change. Never commit the cache as a universal truth; record the build, difficulty, roster rules, loadout, and whether the stores editor was enabled.

## Availability workflow

For each intended platform:

1. locate the base definition;
2. enumerate variants/squadrons;
3. filter by scenario date and operator metadata;
4. inspect loadout availability and date gates;
5. inspect sensors, weapons, magazines, and carried craft;
6. validate the mission reference in the editor;
7. capture the current runtime price under the intended campaign rules;
8. document any flag/operator override or stand-in explicitly.
