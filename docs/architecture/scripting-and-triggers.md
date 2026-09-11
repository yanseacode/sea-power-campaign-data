# Scripting and Triggers

## Trigger model

Numbered `[TriggerN]` sections form the mission event system. A trigger combines activation state, one or more conditions, optional repeat/reactivation behavior, and one or more actions. References are string IDs, so renaming a unit, group, zone, objective, or trigger can break distant consumers.

Observed condition families include:

- elapsed or absolute time;
- unit destroyed, damaged, alive, or in a region;
- detection/classification state;
- objective state;
- task-force or formation state;
- persistent or mission variable checks;
- compound AND/OR condition groups;
- difficulty and spawn conditions.

Observed action families include:

- mission victory/defeat and objective updates;
- messages and localized notifications;
- spawn, despawn, reveal, identify, and tasking changes;
- movement, formation, speed, heading, and waypoint changes;
- weapon/sensor/EMCON and ROE changes;
- variable writes;
- enabling, disabling, and reactivating triggers;
- enabling, disabling, and reactivating Air Operations in #366.

## Campaign variables

Mission trigger actions can write variables that later campaign nodes or missions read. Completion-time campaign JSON actions can also write persistent values. Treat every persistent key as an API:

1. give it a stable, namespaced name;
2. document its writer and exact success condition;
3. list every reader;
4. define behavior when missing or false;
5. expose the consequence to the player.

Stock patterns include prior reconnaissance revealing later targets and an earlier destroyed group being suppressed in a later mission.

## Dynamic-generation interaction

Build #366 placeholder sections can be replaced by generated units or formations. Keep trigger logic attached to stable group identifiers or authored anchors where possible. `DynamicGenerationGroupIdentifier` and trigger-side dynamic group identifier filtering appear in the new stock campaign. Exact edge cases—especially references to a removed slot, multi-unit replacement, and persistent generated units—need focused runtime tests.

## External scripts

`StreamingAssets/original/scripts` contains shipped scripting support and examples. Campaign and mission INIs also expose script-oriented fields and hooks. A field's presence proves parsing intent but not sandbox permissions or lifecycle; copy a currently shipped usage and test initialization, save/load, and cleanup before making a campaign depend on custom script code.

## Authoring discipline

- Reserve permanent prefixes for objectives, triggers, variables, zones, and formations.
- Separate detection, objective evaluation, messaging, and terminal-result triggers when debugging would otherwise be opaque.
- Guard one-shot rewards and narrative actions against repetition.
- Test simultaneous conditions and save/load on both sides of every state change.
- Never assume editor display order is execution order.
