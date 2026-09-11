# Pacific Strike Task Force Mode Example

## Why it matters

`StreamingAssets/original/campaigns/pacific-strike-task-force/` is the strongest current structural example for a persistent-force linear campaign. Build #366 combines:

- persistent player purchases and losses;
- separate spendable-points and force-cap progression;
- repair, rearm, builder, and restricted-detachment nodes;
- free-unit, rank, ribbon, and debrief rewards;
- narrative events and optional/expiring operations;
- pre-mission air tasking and airbase preparation;
- date-based loadout progression;
- dynamically generated enemy theater forces and a Situation view.

It is an example, not a schema. Prototype and other stock campaigns use different subsets.

## Top-level contract in #366

The campaign is `Type=Linear`, `DisplayFormat=MapView`, and Task Force Mode enabled. It starts from an authored player roster and commander settings. The moderate preset uses its own points, cap, repair/refund, crew, loadout-purchase, reward multiplier, and dynamic-formation multiplier values.

The player economy remains structurally unchanged from #363 at the mission-reward level: the inspected completion point, cap, and granted-unit rewards match. One progression mechanism changed materially: the old named `Late` loadout reward at `[Mission10]` was replaced by `TaskForceModeLoadoutYearReward=1988`.

## Logistics patterns

Pacific Strike demonstrates:

- full-logistics nodes with builder, repair, and rearm;
- continuation nodes with repair and rearm disabled;
- builder-disabled detached operations;
- one-ship and three-ship capped deployments;
- an entire-force deployment;
- later rewarded aircraft.

Do not read `TaskForceModeAllowedRosterUnits` as a complete owned-unit deployment constraint; the custom #363 laboratory disproved that interpretation.

## Dynamic theater conversion

Build #364 converted every Pacific Strike tactical mission to dynamic generation. Build #366 contains `enemy_theater_roster.ini`; mission placeholders opt in through `DynamicGenerationSlot` fields. Named flagships are usually fixed, persistent variants are tracked across the theater, generic small units and flights are reusable, and formation sizes respond to campaign/difficulty multipliers.

Some campaign nodes set `DynamicGenerationPersistent=True`, while others do not. Copying one mission without its roster and campaign-level connection is incomplete.

## Narrative structure

The campaign interleaves tactical nodes with localized news, intelligence, logistics, military-document, and ending assets. It is a good example of narrative pacing and reward communication. Build #366 also adds Chinese campaign-local narrative assets; language coverage therefore differs by build and asset.

## Safe reuse

Use Pacific Strike to learn contracts and field groupings. For a new campaign:

1. create a new ID and original assets;
2. reduce the system to the smallest required subset;
3. prove custom discovery and a one-node save;
4. add persistence and economy;
5. add dynamic generation only if variable theater forces improve the design;
6. validate every copied field on the current build.
