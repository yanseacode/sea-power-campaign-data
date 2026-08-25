# Sea Power Task Force Campaign Handoff

## Scope and safety

- Game workspace: `E:\Games\Sea_Power_BETA\Sea Power`
- Moddable data root: `Sea Power_Data\StreamingAssets`
- Stock reference data: `Sea Power_Data\StreamingAssets\original`
- User override/mod data: `Sea Power_Data\StreamingAssets\user`
- Do not edit anything below `original`.
- The active user data file is `user\_info.ini`; it loads `campaigns/pacific-strike-task-force/campaign.ini` as its base campaign.
- This note is at the game workspace root and is not part of the game asset tree.

## Verified Pacific Strike layout

Campaign folder:

`Sea Power_Data\StreamingAssets\user\campaigns\pacific-strike-task-force`

Important files and folders:

- `campaign.ini`: campaign metadata, task-force rules, difficulty presets, localization, and the progression timeline.
- `commander_settings.ini`: commander names/ranks/navy display data and commander-related modifiers.
- `player_task_force_roster.ini`: task-force builder whitelist. It does not define units; it references existing unit types and limits their variants or squadrons.
- `unit_roster_descriptions_<language>.ini`: localized gameplay descriptions for roster entries.
- `campaign_rules_<language>.xml`: localized campaign rules/support text.
- `art/`: campaign events, slideshow/news assets, background/tile images, and localized event variants.
- `missions/`: playable mission `.ini` files and matching `_briefing` directories.

The copied campaign currently has 14 mission `.ini` files and a 31-node timeline. The timeline contains more entries than playable missions because it also contains free events such as news and slideshow nodes.

## Campaign control model

`campaign.ini` is a linear event graph:

```ini
[Campaign]
Type=Linear

[TaskForceMode]
Enabled=True
CommanderSettingsFile=commander_settings.ini
RosterFile=player_task_force_roster.ini

[Missions]
NumberOfMissions=31

[Mission3]
Type=Mission
MissionType=Main
MissionFile=campaigns/pacific-strike-task-force/missions/01 Raid on Okinawa.ini
TaskForceModeMissionGenerationType=Generated
RequiredResult=CostlyVictory
Parents=2
```

- A `[MissionN]` section is a timeline node, not necessarily a playable mission.
- `Type=FreeEvent` is used for authored news/slideshow/event content.
- `Type=Mission` points to a mission scenario using `MissionFile`.
- `Parents` defines the preceding timeline node(s) required for unlock.
- `IsUnlocked` and `IsComplete` are initial state flags in the authored campaign.
- `RequiredResult` defines the result needed before dependent nodes can proceed.
- `TaskForceModeMissionGenerationType=Generated` marks missions that receive the persistent player task force.
- `NumberOfMissions` must match the number of timeline mission sections, including free events, not just the number of mission scenario files.

## Task Force Mode contract

The campaign-level `[TaskForceMode]` section controls persistent force management:

- `TaskForceRequireFlagship`: whether destruction of the designated flagship causes mission loss.
- `DefaultTaskForceName` and `TaskForceNameOptions`: fixed/randomized player force names.
- `StartingPoints` and `PointCap`: initial and maximum spendable builder points.
- `TaskForceDifficultyPresets` plus `[TaskForceModeDifficulty_*]`: difficulty-specific points, repairs, loadouts, airwings, crew skill, and completion rewards.
- `ShipIncludesAirwing`: whether ship airwings arrive free or must be purchased.
- `PurchaseLoadouts`, `BasicShipLoadoutVariants`, `LockedShipLoadoutVariants`, and `InitialUnlockedLoadouts`: loadout availability rules.
- `CrewSkillInitial` and `CrewSkillThresholds`: crew progression across completed missions.
- `UnitDecommissionPointReturnModifier` and `UnitDismissPointReturnModifier`: point refunds.
- `DamageToAllowRepair`, `DamageToDisallowRepair`, `RepairPointsCost`, and difficulty `RepairCostModifier`: repair behavior and cost.
- `CSARPointModifier`: points awarded for rescued survivors.
- `CompletionPointRewardMultiplier`: spendable-point reward scaling on mission completion.

The campaign description explicitly states that ship/aircraft losses, weapon expenditure, and unit state carry between missions, with repair/resupply available at campaign-defined points.

## Roster contract

`player_task_force_roster.ini` is divided into:

- `[AllowedVessels]`
- `[AllowedSubmarines]`
- `[AllowedHelicopters]`
- `[AllowedAircraft]`
- `[LoadoutPrices]`

Observed entry patterns:

```ini
[AllowedVessels]
usn_dd_spruance=Variant2,Variant3,Variant5

[AllowedAircraft]
usn_f-14a=Squadron9
```

The roster is checked by the Task Force Builder first. Individual missions can restrict the available pool further with mission-level allowlisting. Existing unit definitions remain in the shared game data; the campaign roster selects which existing units are purchasable.

## Working assumptions for the new campaign

1. Create a uniquely named folder under `StreamingAssets/user/campaigns`.
2. Keep the new campaign self-contained: campaign file, commander settings, roster, localized descriptions/rules, art, missions, and briefings.
3. Use existing `original` files as read-only templates or references; copy content into the new user campaign before editing.
4. Design the timeline first, because it determines unlocks and the relationship between events and playable missions.
5. Mark persistent task-force missions with `TaskForceModeMissionGenerationType=Generated`.
6. Reuse existing unit type/variant/squadron identifiers in the roster unless a new unit definition is intentionally required.
7. Validate that every `MissionFile` exists, every briefing/art path matches its file, and `NumberOfMissions` matches the timeline node count.

## Still to determine during design

- Campaign setting, date, factions, and theater.
- Whether to reuse Pacific Strike scenario maps/objectives or author new scenarios.
- Desired timeline length and branching versus strictly linear progression.
- Starting task force composition, roster limits, and point economy.
- Which missions allow repairs, resupply, aircraft replacement, or special reinforcements.
- Localization scope; English can be the initial implementation if the game accepts missing optional language variants.