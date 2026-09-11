# Campaign Field Reference

This is a curated authoring reference, not a claim that undocumented parser fields do not exist. Fields are confirmed in stock files and/or active code through Build #366.

## File and campaign

| Section/field | Purpose | Notes |
| --- | --- | --- |
| `[File] Base` | Content-relative path to the definition | Treat as required where stock comments say so |
| `[Campaign] Type` | Campaign model | `Linear` is the documented model here |
| `Difficulty`, `Length` | Campaign presentation/default metadata | Do not confuse with Task Force difficulty presets |
| `DisplayFormat` | Timeline presentation | Pacific Strike uses `MapView` |
| `BackgroundImage` | Campaign background | Content-relative path |
| `NumberOfMissions` | Total numbered timeline nodes | Includes tactical and narrative nodes |

## Timeline node

| Field | Purpose |
| --- | --- |
| `Type` | `Mission`, `FreeEvent`, `NewspaperEvent`, or another supported node type |
| `MissionFile` | Tactical scenario path |
| `Parents` | Prerequisite node numbers; multiple entries form a join |
| `IsUnlocked`, `IsComplete` | Initial authored state |
| `RequiredResult` | Minimum result needed for completion |
| `ExpiresAfterMissionComplete` | Expire this node after another node completes |
| `UnlockConditionsJSON` | Completed-node and/or persistent-value conditions |
| `OnCompleteActionJSON` | Completion actions such as persistent state writes |
| `OnCompleteEvent`, `OnCompletePath_*` | Completion presentation asset |
| `OnCompleteForceOpen` | Force/open another node; edge behavior needs runtime testing |
| `MissionSequenceName_*`, `MapShortName_*` | Display labels independent of internal node number |
| `TileImagePath_*` | Localized tile image |
| `MissionSpecialNote_*` | Prominent special-mechanics warning |
| `MissionResupplyRules_*` | Player-facing logistics summary only |
| `MissionWarningPopup_*` | Pre-launch confirmation text |

## Task Force Mode global

| Field | Purpose and important behavior |
| --- | --- |
| `Enabled` | Enables persistent Task Force Mode |
| `TaskForceRequireFlagship` | Applies flagship requirement/loss rule |
| `DefaultTaskForceName`, `TaskForceNameOptions` | Naming |
| `CommanderSettingsFile` | Commander/rank/award settings; required in tested custom layout |
| `RosterFile` | Player roster and authored price source |
| `StartingPoints`, `PointCap` | Initial spendable balance and fleet cap |
| `CompletionPointRewardMultiplier` | Difficulty-sensitive completion payout multiplier |
| `CSARPointModifier` | Converts rescued survivors to points according to active implementation |
| `ShipIncludesAirwing` | Whether purchased ships include their initial air wing |
| `PurchaseLoadouts` | Whether unlocked loadouts must be purchased |
| `BasicShipLoadoutVariants` | Immediately available named loadout categories |
| `LockedShipLoadoutVariants` | Named reward-gated categories; #366 treats these separately from date gates |
| `MaxLoadoutYear` | Initial date ceiling for ship loadouts |
| `EnableStoresEditor` | Default availability of per-hull stores editing; unset defaults true in Pacific Strike comments |
| `CrewSkillInitial`, `CrewSkillThresholds` | Starting proficiency and survival promotions |
| `UnitDecommissionPointReturnModifier`, `UnitDismissPointReturnModifier` | Refund policy |
| `DamageToAllowRepair`, `DamageToDisallowRepair`, `RepairPointsCost` | Repair eligibility and price bands |
| `DynamicGenerationFormationMultiplier` | Global generated-formation size multiplier |

## Difficulty presets

`TaskForceDifficultyPresets` names presets, `DefaultTaskForceDifficultyPreset` chooses the default, and `[TaskForceModeDifficulty_<name>]` overrides applicable rules. Build #365 presents campaign difficulty settings as sliders; build #364 moved commander setup and difficulty customization into campaign pre-launch.

Common overrides include starting points, cap, airwing inclusion, loadout purchasing, initial loadouts, repair/refund modifiers, crew skill, completion payout, and dynamic formation multiplier.

## Task Force Mode node fields

| Field | Purpose |
| --- | --- |
| `TaskForceModeIncludesTaskForce` | Include persistent surface force |
| `TaskForceModeIncludesAirwing` | Include persistent/carried air component |
| `TaskForceModeIncludesSubmarine` | Include persistent submarine component |
| `TaskForceModeRequireEntireTaskForce` | Require all applicable owned units |
| `TaskForceModeRequiredUnitType` | Restrict selectable category; `Vessel` is proven in examples |
| `TaskForceModeMaxUnits` | Cap selectable deployed units |
| `TaskForceModeAllowedRosterUnits` | Node builder/purchase pool; not a proven owned-unit deployment filter |
| `TaskForceModeEnableTaskForceBuilder` | Enable force management/purchases |
| `TaskForceModeRepair` | Permit paid repairs |
| `TaskForceModeRearm` | Automatically restore eligible ammunition at launch |
| `TaskForceModeRearmByVariableAND/OR` | Conditional rearm through persistent state |
| `TaskForceModeMissionGenerationType` | Persistent-force insertion mode, including generated/replaced patterns |
| `TaskForceModeDeploymentOptions` | Enable pre-launch placement controls |
| `TaskForceModeDefaultDisposition` | Initial formation/dispersed disposition |
| `TaskForceModeCompletionPoints` | Spendable points reward |
| `TaskForceModeCompletionCapPoints` | Fleet-cap increase |
| `TaskForceModeCompletionRewardedUnits` | Grant exact units/variants/squadrons |
| `TaskForceModeLoadoutsToUnlock` | Grant named reward-managed loadouts |
| `TaskForceModeLoadoutYearReward` | Raise loadout ceiling in #366 |
| `TaskForceModeUnitYearReward` | Raise unit and loadout ceilings in #366 |
| `TaskForceModeCommanderIncreaseRank` | Promote commander |
| `TaskForceModeRibbonAwards` | Grant service awards |
| `TaskForceModeDebriefNoticeTitle_*`, `...Text_*` | Explain rewards/consequences |
| `TaskForceModeFinalMission` | Mark terminal task-force mission |
| `TaskForceModeAirTaskingAvailable`, `...Flight1..3` | Pre-mission air tasking |
| `TaskForceModeAirbasePrepAvailable` and slot rules | Pre-mission land-air preparation |
| `TaskForceModeThreatProfileShip/Air/Sub/Land` | Planning-UI threat summary |
| `DynamicGenerationPersistent` | Use campaign-persistent dynamic theater behavior for the node |

## Dynamic theater global section

`[DynamicUnitGeneration] TaskforceNRosterFile=<file>` attaches a theater roster to a side. See [dynamic generation](dynamic-generation.md).

## Localization

`[Language_<code>]` and `_en`/other suffix fields supply campaign and node presentation. Paths and supported token bindings vary by view; copy from the same node/view type.
