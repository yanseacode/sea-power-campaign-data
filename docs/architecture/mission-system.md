# Mission System

## File model

Mission/scenario files are INI-like documents. A typical file contains:

1. `[File]` path metadata;
2. `[Mission]` counts, time, weather, map/location, sides, and presentation;
3. task-force sections and individual unit sections;
4. formations, zones, reference points, and map annotations;
5. objectives;
6. triggers and actions;
7. scheduled routes/Air Operations;
8. localized strings or references to external briefing assets.

Count fields such as `NumberOfTaskforces`, `NumberOfTriggers`, and per-side unit counts must agree with numbered sections. The Mission Editor is the safest producer of complex geometry and generated briefing assets, but saved output should still be reviewed as text.

## Sides and control

`[TaskforceN]` sections define sides, nations, names, disposition, ROE-related defaults, and player ownership. Individual sections use category-specific names such as `Taskforce1Vessel1`, `Taskforce2Aircraft1`, `Taskforce1Submarine1`, and `Taskforce2LandUnit1`.

Player control comes from task-force/mission ownership, not the nationality encoded in a unit name. Unit-section country and flag overrides can represent allied, captured, exported, or substitute equipment; verify the exact visual and voice behavior at runtime.

## Units and formations

A unit section normally supplies `Type` plus `VariantReference` or aircraft `SquadronReference`, position, heading, readiness, doctrine/weapon status, and optional loadout. Ships may define `CustomAirGroup` entries for embarked helicopters or aircraft. Airbases are land units with aircraft and flight-deck-like support configured through their unit definition and mission air group.

Formation membership is expressed through parent/station relationships. Preserve section IDs referenced by triggers, objectives, waypoints, and campaign generation. Submarines use the same general object/trigger system but have submarine-specific depth, battery, sonar, and doctrine behavior.

## Navigation and environment

Mission-level fields establish date/time, geographic origin or map area, weather, sea state, cloud and precipitation parameters, and visibility. Units then use relative or geographic positions, headings, telegraph settings, patrol areas, and waypoint lists. Waypoints can carry actions such as speed/altitude changes, sensor state, attack, refuel, or return-to-base behavior.

Build #366 adds full Mission Editor support for legacy `CivilianRouteN` sections as **Air Operations**. It adds route visualization, scheduling, per-waypoint orders, unit-relative waypoints, range validation, and trigger enable/disable/reactivation. The serialized legacy route system remains supported; editor-created #366 output should be used as the template for new advanced fields rather than guessing their syntax.

## Objectives and outcome

Objectives attach scoring and player-facing text to conditions. Triggers evaluate time, unit state, location, detection, variables, or compound conditions and execute actions. Victory and defeat are normally explicit trigger actions after objective/condition evaluation; destruction alone does not guarantee the intended campaign result.

Always test:

- decisive, costly, marginal, and defeat paths as applicable;
- simultaneous terminal conditions;
- late-arriving reinforcements and mission-end timing;
- save/load before and after objective changes;
- campaign return and reward application.

## Campaign integration

Task Force Mode missions can be generated or replaced around authored anchors. Node fields decide whether persistent surface, air, or submarine components are included, whether the whole force is mandatory, and whether selection, repair, rearm, or purchasing is allowed. Build #366 also permits dynamic theater units to replace authored placeholder sections while retaining authored navigation and trigger integration.

See [Mission fields](../reference/mission-fields.md), [dynamic generation](../reference/dynamic-generation.md), and [scripting and triggers](scripting-and-triggers.md).
