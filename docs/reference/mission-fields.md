# Mission Field Reference

This reference groups commonly observed fields by responsibility. Complex delimiter syntax should be cloned from a current stock example and regenerated through the Mission Editor when supported.

## Mission header and counts

- `[File] Base`
- `[Mission]` date/time, location/map, weather, sea state, sides, and localized metadata
- `NumberOfTaskforces`
- per-side vessel, submarine, aircraft, helicopter, land-unit, and formation counts
- `NumberOfObjectives`, `NumberOfTriggers`, `NumberOfCivilianRoutes`

Incorrect counts can leave sections unparsed or produce editor/runtime inconsistencies.

## Task forces

`[TaskforceN]` sections define side identity, nation, player/AI relationship, names, doctrine/ROE defaults, and scoring/presentation. Nations on individual units or mission overrides may differ from the base unit definition.

## Unit sections

Section names encode side, category, and index, for example:

```ini
[Taskforce1Vessel1]
Type=<unit-id>
VariantReference=<variant>
RelativePositionInNM=<x>,<y>,<z>
Heading=<degrees>
```

Common optional families include:

- `SquadronReference` and `LoadoutVariant`;
- `CustomAirGroup` plus aircraft/squadron/count rows;
- `WeaponStatus`, sensor/EMCON flags, crew skill, morale, fuel, and readiness;
- `Telegraph`, speed, depth/altitude, heading, waypoints, patrol areas;
- `StationPosition`, formation parent/station data;
- random spawn center/range/direction and difficulty conditions;
- variable-controlled spawns;
- dynamic-generation fields described below.

## Dynamic replacement slots in #366

Confirmed stock keys include:

- `DynamicGenerationSlot`
- `DynamicGenerationRoster`
- `DynamicGenerationAllowedTypes`
- `DynamicGenerationAllowedNations`
- `DynamicGenerationMinUnits`, `DynamicGenerationMaxUnits`
- `DynamicGenerationFormation`
- `DynamicGenerationSpawnZone`
- `DynamicGenerationGroupIdentifier`
- `DynamicGenerationDisallowDuplicateType`

The placeholder retains authored position, navigation, and event context; the generator selects a matching unit or formation from the named theater roster. See [dynamic generation](dynamic-generation.md).

## Objectives

Numbered objective sections define player-facing title/text, score/priority, visibility, and success/failure state. Exact fields vary with objective type. Triggers usually update or complete objectives; verify that terminal victory/defeat actions agree with objective scoring.

## Triggers

Numbered trigger sections combine:

- enabled/disabled and repeat/reactivation state;
- `Condition_Type` and condition-specific values;
- compound condition references;
- `Action_*` fields for messages, objectives, units, systems, variables, and mission results.

Build #366 adds Air Operation enable/disable/reactivation actions and Force EMCON control within system actions. Serialize a test route/action through the #366 editor before documenting exact new action tokens.

## Routes and Air Operations

Legacy `[CivilianRouteN]` sections remain supported. Existing fields cover name/description, allowed nations/units/loadouts, unit type, group size, maximum units, start delay, spawn interval, repeatability, home/destination, radar state, and waypoints. The active #366 `SeaPower.CivilianRoute` class additionally contains initially-disabled/editor-authored state, an operation key, squadron name, waypoint definitions, and explicit `Enable`, `Disable`, and `Reactivate` methods.

Because #366's richer waypoint encoding is new, use editor-generated output as the canonical syntax for per-leg speed, altitude, sensors, ROE, attack, refuel, RTB, and unit-relative positioning.

## Presentation

Mission briefings can use legacy external panels or generated briefing-map text. Localized objective, message, victory, and defeat strings may be inline or externally referenced. Presentation must not be treated as enforcement.
