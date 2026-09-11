# Persistence and Task Force Mode

## Persistent state

Task Force Mode stores campaign state beyond simple node completion. Build #363 save inspection and runtime tests confirmed persistence of owned units, variants/squadrons, loadouts, quantities, damage, magazines, aircraft assignment/state, losses, points, cap, commander progression, rewards, and campaign variables. Build #364 specifically fixed several campaign save/load cases, so the affected #363 observations require #366 regression passes.

Persistent forces are injected into tactical missions according to node-level inclusion and generation rules. Scenario-authored units are not automatically persistent merely because they are player-controlled.

## Force selection

The campaign roster defines what can be purchased. A mission node can narrow its builder pool with `TaskForceModeAllowedRosterUnits`, but #363 runtime testing showed that this allowlist did not by itself prevent an already-owned excluded ship from deploying when the builder was disabled. Use explicit inclusion, required-category, entire-force, and maximum-unit controls for deployment restrictions.

Relevant node controls include:

- `TaskForceModeIncludesTaskForce`, `TaskForceModeIncludesAirwing`, `TaskForceModeIncludesSubmarine`;
- `TaskForceModeRequireEntireTaskForce`;
- `TaskForceModeRequiredUnitType`;
- `TaskForceModeMaxUnits`;
- `TaskForceModeEnableTaskForceBuilder`;
- `TaskForceModeMissionGenerationType`;
- deployment options and default disposition.

## Economy

There are two independent balances:

- available points pay for units, loadouts, and repairs;
- force-cap points limit the value that may be fielded.

`TaskForceModeCompletionPoints` and `TaskForceModeCompletionCapPoints` increase them separately. Completion point payouts can be difficulty-scaled; cap rewards are not described as using that multiplier in the stock #366 comments. Free-unit rewards and loadout/year unlocks are separate benefits.

Runtime-derived prices are build-dependent. Build #366 uses point formula 140, replacing formula 134 in #363. It introduces ammunition/store pricing constants and fixes default optional weapons, weapon swaps, manual-price scaling, and stores-editor pricing. Therefore, every formula-134 price table is historical and must be regenerated before balancing on #366.

Positive authored `TaskForceCost` and `LoadoutCost_*` fields remain supported. `HandAuthoredScaleBridge=10` remains present in #366 code, but the corrected application path has not yet been isolated at runtime; do not assume every #363 displayed override result is unchanged.

## Logistics

These controls are independent:

- `TaskForceModeEnableTaskForceBuilder` — purchase/dismiss/loadout-management access and associated UI;
- `TaskForceModeRepair` — paid repair opportunity;
- `TaskForceModeRearm` — automatic ammunition restoration at mission launch;
- conditional rearm fields — gate rearm on campaign variables.

A “resupply mission” is therefore a design pattern, not one switch. Full logistics commonly enables all three; a pressure continuation disables repair and rearm and may either close or narrowly restrict the builder.

## Losses and rewards

Destroyed persistent units remain lost. Dismissal/decommission return modifiers control refunds. Crew skill can change through survival rules. Completion rewards use save flags such as completion-reward-applied state to prevent duplicate payout; stable node IDs are essential.

Build #364 fixed saving/loading of mission score, victory state, landing aircraft, survivors aboard aircraft, no-magazine ammunition, and map layers. These are confirmed changelog claims and affected systems should be tested on #366 before a production campaign depends on them.

## Year and loadout gates in #366

Build #366 code and Pacific Strike files confirm:

- `MaxLoadoutYear` establishes a campaign ceiling;
- `TaskForceModeLoadoutYearReward` raises the loadout ceiling;
- `TaskForceModeUnitYearReward` raises unit and loadout ceilings;
- named `LockedShipLoadoutVariants` are reward-gated instead of date-gated;
- explicitly roster-priced loadouts bypass the date ceiling in the documented stock behavior;
- disabling the difficulty option that limits unit dates removes both ceilings;
- `EnableStoresEditor=False` hides the stores interfaces by default while allowing the player to opt in during campaign setup.

These mechanisms are preferable to maintaining large manually staged allowlists when progression is fundamentally date-based.
