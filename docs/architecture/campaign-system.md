# Campaign System

Validated statically against 0.8.2 Build #366. Earlier custom-campaign runtime observations are labeled #363.

## Model

A stock campaign is a directory beneath `StreamingAssets/original/campaigns/<id>/`; custom content belongs beneath the parallel `StreamingAssets/user/campaigns/<id>/` tree. A linear campaign is driven by `campaign.ini`, with local mission files, optional rosters and commander settings, and narrative assets referenced by relative path.

`[Campaign] Type=Linear` selects the linear timeline system. `NumberOfMissions` counts timeline nodes, not just tactical battles: `Mission`, `FreeEvent`, and `NewspaperEvent` nodes all occupy numbered `[MissionN]` sections.

## Topology and progression

Each node has its own identity and state. The common progression controls are:

- `Type` — tactical mission or narrative event type;
- `MissionFile` — path to a tactical mission for `Type=Mission`;
- `Parents` — one or more prerequisite node numbers; multiple parents are treated as a join;
- `IsUnlocked` and `IsComplete` — authored initial state, later superseded by save state;
- `RequiredResult` — minimum qualifying tactical result;
- `ExpiresAfterMissionComplete` — closes an optional opportunity after another node;
- `UnlockConditionsJSON` — additional completed-node and persistent-value gates;
- `OnCompleteActionJSON` — completion-time persistent writes;
- `OnCompleteEvent` and localized `OnCompletePath_*` — completion vignette;
- `OnCompleteForceOpen` — implemented field whose exact edge behavior should be tested before production reliance.

The graph can branch and rejoin. Display names such as `3A` are presentation; dependencies refer to internal numbered sections. Keep those internal IDs stable after real saves exist.

## Results and endings

The mission file calculates a tactical outcome through objective and trigger logic. The campaign node compares it with `RequiredResult`. Decompiled campaign code confirms that a below-threshold result leaves the node incomplete; Build #363 runtime confirmed an above-threshold result completes it. The below-threshold retry path should still receive a focused runtime pass. No general defeat-continuation branch should be assumed without a dedicated test.

`TaskForceModeFinalMission=True` marks a terminal task-force operation. Ending presentation may additionally use a completion event or subsequent narrative node.

## Campaign-local dependencies

A Task Force Mode campaign normally references:

- `CommanderSettingsFile` — commander nations, ranks, presentation, discounts, and awards;
- `RosterFile` — player purchase pool and optional authored prices;
- `[DynamicUnitGeneration] TaskforceNRosterFile` — theater roster for generated enemy or allied forces;
- `art/` and localization assets — tiles, briefings, newspapers, orders, and endings;
- `missions/` — tactical scenarios.

Build #363 runtime testing established that commander settings are operationally mandatory for the tested Task Force Mode layout: absent nation/rank data caused a blocking commander-selection state.

## Authoring rule

Copy structure and field patterns, not shipped content. Start from a minimal custom skeleton, prove discovery, prove a one-node completion, then add topology and persistence. See [Campaign field reference](../reference/campaign-fields.md) and [new-campaign checklist](../workflows/new-campaign-checklist.md).

## Open questions

- Exact #366 runtime ordering when expiry, forced-open nodes, completion events, and multi-parent unlocks coincide.
- Whether all narrative node types have identical localization fallback behavior.
- Save compatibility guarantees after node renumbering; treat renumbering as unsafe.
