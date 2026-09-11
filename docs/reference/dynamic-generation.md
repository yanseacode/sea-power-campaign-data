# Dynamic Unit Generation

Introduced into the shipped Pacific Strike campaign in Build #364 and present in #366.

## Purpose

Dynamic generation lets a linear campaign maintain an enemy theater order of battle while varying which eligible forces appear in each mission. It is not unstructured random spawning: missions still contain authored placeholder units with positions, waypoints, triggers, and scenario roles.

At mission launch, the generator selects replacements from a campaign roster according to each placeholder's filters. The roll is written into the save. The changelog states that replay/quit-to-replay keeps the same roll, while loading a pre-launch save rerolls it.

## Campaign connection

```ini
[DynamicUnitGeneration]
Taskforce2RosterFile=enemy_theater_roster.ini
```

`DynamicGenerationPersistent=True` on selected campaign nodes enables persistent theater treatment. Pacific Strike uses this on only some nodes, so persistence is an explicit node choice rather than a safe universal default.

## Roster pools

The stock roster documents these roles:

| Pool role | Behavior |
| --- | --- |
| Major flagships | Named/story units usually remain pre-placed rather than generated |
| Persistent surface/submarine units | Exact variants are tracked; destroying one removes it from the campaign theater state |
| Reusable surface units | Generic/light units may appear repeatedly |
| Reusable aircraft/helicopters | Type, squadron, and default formation size drive generated flights |

Nation-specific sections can change Situation-panel presentation; Pacific Strike uses `ShowOnlyClassName=True` for PLAN forces.

Entries consist of type, variants or squadron/count pairs, and optional tags. Tags can describe capabilities for filters. The stock `Hide` tag conceals a unit's identity/profile in the Situation view while retaining it in the theater assessment.

## Formations

Formation sections define:

- `Nation`
- `MinStations`
- numbered `StationN` type alternatives
- numbered `OffsetN` positions
- shared `CustomFields`
- per-station `StationNCustomFields`
- optional `GeneratedFormation` and spacing.

`Loose` preserves authored station/offset geometry and is the default described by the stock roster. `Circle` uses native circular formation rendering. Formation size is scaled by global/difficulty multipliers, subject to `MinStations`.

## Mission slots

A mission placeholder opts in with `DynamicGenerationSlot=True` and names a roster. It can constrain allowed type/nation, minimum/maximum units, formation, spawn zone, group identity, and duplicate types. Ordinary unit fields on the slot provide authored context that the generator can carry into the output.

## Persistent state and selection

The #366 assembly contains explicit concepts for assignments, snapshots, persistent/reusable entries, theater records, last-known positions, recorded kills, hidden state, roster/nation/pool, and status. It also contains campaign save section prefixes for per-mission generator snapshots and enemy theater ORBAT.

The implementation exposes selection filters for allowed pools/types/nations and required/excluded tags. Not every internal filter has a shipped authoring example; do not publish guessed INI keys without an editor or stock example.

## Design cautions

- Keep story-critical named units fixed unless the narrative tolerates substitution.
- Attach critical triggers to stable anchors or generated group identifiers, not a particular replaceable hull.
- Ensure every allowed replacement can perform the placeholder's tactical job.
- Balance minimum and maximum strength at every difficulty multiplier.
- Test destroyed, merely encountered, never detected, and skipped-mission paths.
- Test save/load and replay seeding before relying on strategic continuity.
- The Situation panel is information presentation; verify what is revealed for hidden, unknown, and encountered units.
