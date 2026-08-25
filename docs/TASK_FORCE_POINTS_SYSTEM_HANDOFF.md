# Sea Power Task Force Points System Handoff

## Purpose

This document records the verified Pacific Strike Task Force Mode economy so a new campaign can initially duplicate it. Source data was inspected under `Sea Power_Data/StreamingAssets/original/campaigns/pacific-strike-task-force`; the user copy is under `Sea Power_Data/StreamingAssets/user/campaigns/pacific-strike-task-force`.

No source campaign files were modified during this investigation.

## Executive summary

Pacific Strike uses three separate point mechanisms:

1. **Unit and loadout purchase costs** are resolved from unit metadata at runtime.
2. **Mission completion rewards and fleet-cap increases** are authored per timeline mission in `campaign.ini`.
3. **Search-and-rescue rewards** are calculated from survivors rescued at mission end.

A new campaign can duplicate the system by copying the campaign-level Task Force settings, using the same unit definitions, and copying the mission reward fields. The unit purchase prices will remain the same automatically as long as the same base unit INIs are used.

## Campaign-level economy settings

File: `Sea Power_Data/StreamingAssets/original/campaigns/pacific-strike-task-force/campaign.ini`

```ini
[TaskForceMode]
Enabled=True
StartingPoints=500
PointCap=500
CompletionPointRewardMultiplier=1
CSARPointModifier=10
```

Pacific Strike difficulty presets override these values:

| Preset | Starting points | Starting cap | Completion reward multiplier | Ship airwings included | Initial crew | Repair modifier |
| --- | ---: | ---: | ---: | --- | --- | ---: |
| Easy | 650 | 650 | 1.75x | Yes | Trained | 0.75x |
| Moderate | 500 | 500 | 1.50x | Yes | Trained | 1.00x |
| Difficult | 400 | 400 | 1.25x | No | Green | 1.25x |

Other economy-related settings in the base campaign:

```ini
PurchaseLoadouts=True
BasicShipLoadoutVariants=Default
LockedShipLoadoutVariants=Late|LandAttack|AntiShip
CrewSkillThresholds=Trained:1|Seasoned:2|Veterans:5|Ultra:9
UnitDecommissionPointReturnModifier=0.25
UnitDismissPointReturnModifier=0.5
DamageToAllowRepair=Light,Moderate
DamageToDisallowRepair=Heavy
RepairPointsCost=Light,0.1|Moderate,0.25
```

Difficulty presets also override loadout purchasing, initial unlocked loadouts, crew starting skill, and unit-dismiss/decommission refunds.

## Mission completion rewards

These fields are in the `[MissionN]` sections of `campaign.ini`, not in the scenario mission INIs:

```ini
TaskForceModeCompletionPoints=100
TaskForceModeCompletionCapPoints=100
```

`TaskForceModeCompletionPoints` is the spendable-points reward. `TaskForceModeCompletionCapPoints` raises the maximum fleet-points cap. Pacific Strike’s authored values are:

These values are authored by the campaign designer. They are not calculated from the mission's combat score, and they are not normally set in the referenced scenario mission `.ini` file. The scenario controls the tactical mission; the campaign timeline controls the campaign-economy reward.

| Timeline node | Mission | Completion points | Cap increase | Builder before mission |
| ---: | --- | ---: | ---: | --- |
| Mission3 | Raid on Okinawa | 100 | 100 | Yes |
| Mission4 | Action in the Taiwan Strait | 100 | 100 | Yes |
| Mission6 | Running the Palawan Passage | 120 | 100 | Yes |
| Mission9 | Run Silent, Run Deep | 50 | 50 | No |
| Mission10 | Holding the Lombok Strait | 150 | 150 | Yes |
| Mission12 | Sunda Strait | 200 | 200 | Yes |
| Mission14 | Strike on the Monster | 200 | 200 | Yes |
| Mission17 | Raid on Lombok | 120 | 100 | Yes |
| Mission19 | Action in the Java Sea | 150 | 100 | Yes |
| Mission21 | Hunt for the Cruiser | 100 | 100 | No |
| Mission22 | Defense of North Borneo | 150 | 150 | Yes |
| Mission24 | Pathfinders | 100 | 100 | No |
| Mission26 | Shadows off Palawan | 150 | 150 | Yes |
| Mission29 | Vengeance at Luzon | 250 | 250 | Yes |

There are 31 timeline nodes, but only these 14 nodes contain completion rewards. Free-event nodes do not need reward fields unless deliberately used that way.

### Reward application order

The verified runtime behavior is:

```text
mission_points = max(0, authored TaskForceModeCompletionPoints)
mission_points = round(mission_points * selected difficulty multiplier)
cap_increase = max(0, authored TaskForceModeCompletionCapPoints)
available_points += mission_points
cap_points += cap_increase
```

The completion multiplier affects spendable mission rewards only. It does not affect cap increases. The reward and cap values are recorded in the post-mission campaign state, and a `CompletionRewardsApplied` flag prevents duplicate application when a debrief is revisited.

Example using Pacific Strike's Moderate preset:

```text
authored completion points = 100
Moderate multiplier = 1.5
spendable reward = round(100 * 1.5) = 150
authored cap increase = 100
```

The result is therefore `+150` available points and `+100` fleet-cap points. Survivor points are added separately afterward and do not receive this completion multiplier.

The completion routine adds the cap increase to the stored cap and adds the completion reward to available points. It does not clamp available points down to the cap in that routine. The cap is therefore a purchase limit, not necessarily a hard ceiling on every source of available points.

## Survivor / CSAR reward

Campaign setting:

```ini
CSARPointModifier=10
```

The English campaign rules state that every 10 survivors rescued during a mission awards 1 campaign point at mission end, and partial groups do not award a point.

Verified calculation:

```text
csar_points = floor(max(0, survivors_rescued) / max(0, CSARPointModifier))
```

If the modifier is zero or negative, the result is zero. With Pacific Strike’s value of 10:

| Survivors rescued | CSAR points |
| ---: | ---: |
| 0-9 | 0 |
| 10-19 | 1 |
| 20-29 | 2 |
| 100-109 | 10 |

CSAR points are applied after the normal completion reward and are added to available points. They do not increase the cap. The CSAR application is also idempotent: the saved post-mission section records `CSARPointRewardApplied` so the same reward is not added twice.

Life rafts can appear when ships are sunk or aircraft are lost. A helicopter or ship must approach the rafts to rescue survivors. The campaign rules describe this as a mission-end campaign-point reward, not as a mid-mission spendable balance.

## Static unit purchase prices

### Actual source and precedence

The purchase-price lookup is performed by the game’s `UnitMetadataProvider`:

```text
ReadUnitIniTaskForceCost(unitFolder, unitType)
    -> UnitMetadataProvider.UnitData[(unitFolder, unitType)]._taskForceCost
```

The loader reads these optional fields from each base unit definition INI:

```ini
[TaskForce]
TaskForceCost=...
LoadoutCost_Default=...
LoadoutCost_Late=...
LoadoutCost_LandAttack=...
LoadoutCost_AntiShip=...
```

The exact loadout key is `LoadoutCost_<loadout reference>`, for example `LoadoutCost_LandAttack`.

Pacific Strike’s `player_task_force_roster.ini` does **not** contain numeric costs. Its `|points_cost` syntax is only a comment/documentation convention in this build. The roster selects which units and variants/squadrons are permitted; it does not supply the prices observed in the Task Force Builder.

### Pacific Strike behavior

When a positive `[TaskForce] TaskForceCost` is present, the runtime treats it as a hand-authored cost and multiplies it by:

```text
HandAuthoredScaleBridge = 10.0
```

The result is rounded to an integer. Hand-authored loadout costs are scaled the same way.

When no positive hand-authored task-force cost exists, the game computes a deterministic automatic point value from the unit’s combat metadata. The resulting value is used as the base purchase cost. This explains why Pacific Strike prices remain static throughout the campaign even though they are absent from the campaign roster.

The automatic calculation considers the unit’s role scores and capabilities, including factors such as:

- Anti-air, anti-surface, ASW, scouting, electronic warfare, and land-attack capability
- Survivability, stealth, and mobility
- Weapon range, ammunition/loadout content, weapon volume, accuracy, penetration, and saturation behavior
- Aircraft range and air-unit loadouts
- Air-hosting capability on non-air units

The visible formula for non-air units is structurally:

```text
role_value = weighted_non_air_roles * survivability * stealth_factor * mobility_factor
             + air_hosting_value
base_cost = round(Scale * type_multiplier * role_value)
```

Current inspected tuning values include:

```text
Scale = 1.2
ShipCostMult = 1.19
SubCostMult = 1.25
HandAuthoredScaleBridge = 10.0
WeightAntiAir = 1.0
WeightAntiSurface = 1.0
WeightASW = 1.0
WeightScouting = 0.8
WeightEW = 0.9
WeightLandAttack = 0.6
ShipAswMult = 0.75
ShipLandAttackMult = 0.6
```

Surface ships receive an additional base bonus that fades as the calculated cost increases. Loadout costs are derived per loadout and represented as the difference above the unit’s cheapest/base loadout in the automatic value model.

`AI\UnitCostValue` is unrelated. It is an AI target-priority value and must not be used as a Task Force purchase price.

### Practical implication for our duplicate campaign

To preserve Pacific Strike’s exact prices:

- Reuse the same base unit definition files.
- Do not add `[TaskForce] TaskForceCost` or `LoadoutCost_*` overrides unless intentionally changing prices.
- Copy the same loadout rules and use the same unit types.
- Keep the same game build, because automatic point-value tuning is runtime code.

If we add or edit unit definitions later, prices may change automatically because the calculation reads their combat/loadout metadata. If exact custom prices are required, use positive `[TaskForce] TaskForceCost` and `LoadoutCost_<reference>` values, remembering that the runtime applies the 10x hand-authored scale bridge.

## Logistics and when points can be spent

Mission-level fields control whether the Task Force Builder, repairs, and rearming are available:

```ini
TaskForceModeEnableTaskForceBuilder=True
TaskForceModeRepair=True
TaskForceModeRearm=True
```

Pacific Strike’s localized `MissionResupplyRules_en` text describes the intended logistics states:

- After selected missions: fully rearmed, repairs and reinforcements available.
- Away from support: repair and rearming unavailable; weapon expenditure matters.
- Some optional missions: only the selected ship is fully rearmed before deployment.
- A mission can restrict the builder to a mission-specific allowlist with `TaskForceModeAllowedRosterUnits`.

This logistics layer is separate from the points reward. A mission can award points/cap while still limiting what can be repaired, rearmed, or purchased before the next deployment.

## Duplicate-campaign recipe

Copy the Pacific Strike campaign folder into `StreamingAssets/user/campaigns/<new-campaign>` and change paths/names while preserving these pieces initially:

1. `[TaskForceMode]` settings and the three difficulty preset sections.
2. The roster reference, commander settings reference, and localized campaign rules.
3. Every mission node’s `TaskForceModeCompletionPoints` and `TaskForceModeCompletionCapPoints`.
4. The `CSARPointModifier=10` setting.
5. Mission-level builder, repair, rearm, and resupply settings.
6. The same unit definition files, unless custom units are deliberately part of the design.

Then change only narrative content, mission sequencing, allowed-unit lists, and geography. The first implementation should not put prices into `player_task_force_roster.ini`; that file is primarily the availability whitelist in this system.

## Remaining validation target

The static prices are now explained by the runtime path and automatic formula, but the exact displayed cost for every unit/loadout would require either:

- reading the game’s runtime Task Force Builder or point-value dump, or
- reproducing the full combat-score calculation for each unit from the compiled assembly.

That is not necessary to preserve the system: using the same unit INIs and avoiding Task Force overrides preserves the same deterministic prices automatically.
