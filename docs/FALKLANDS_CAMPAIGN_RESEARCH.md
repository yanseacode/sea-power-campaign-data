# Alternate-History Falklands Campaign Research

## Scope and safety

- Workspace inspected: `E:\Games\Sea_Power_BETA\Sea Power`
- First reconnaissance pass: 2026-08-25
- Current scope: **Stage 1 — Workspace map only**
- Stock content under `Sea Power_Data\StreamingAssets\original` is read-only reference material.
- Candidate custom content location is `Sea Power_Data\StreamingAssets\user`; no campaign or mission content has been created or changed.
- This research document is the only file created during Stage 1.

## Stage 1 — Workspace map

### 1. Primary data roots

| Location | Contents and relevance |
| --- | --- |
| `Sea Power_Data\StreamingAssets\original` | Stock, developer-supplied moddable data. This is the authoritative reference tree for campaigns, missions, units, weapons, sensors, localization, formations, scripts, and documentation. Do not edit. |
| `Sea Power_Data\StreamingAssets\user` | User-data/override tree. It already contains copies of the four stock campaign folders and mission folders. `user\_info.ini` describes this as the primary user-data location, loaded first and synchronized through Steam Cloud when available. This is the leading candidate for a future custom campaign, but load/override behavior must be verified before building. |
| `Sea Power_Data\Managed` | Compiled .NET/Unity assemblies. `Seapower-Scripts.dll` (about 7.4 MB) is the main decompilation target for campaign persistence, progression, task-force pricing, and parser defaults when static INIs are insufficient. `Assets.dll` and `Libraries.dll` may also contain relevant types. No assembly was decompiled in Stage 1. |
| `Sea Power_Data\Resources`, `Sea Power_Data\EntityScenes` | Unity runtime resources/scenes. Potentially relevant to models and map rendering, but not the primary authored campaign interface found in this pass. |

### 2. Campaign definitions and campaign-local content

Root: `Sea Power_Data\StreamingAssets\original\campaigns`

The root contains campaign folders plus global campaign geography/weather tables such as `ports.ini`, `sea_points.ini`, `sea_links.ini`, `patrol_areas.ini`, regional city/port/installation files, and `weather\*.tsv` wind tables.

Existing campaign folders:

| Campaign | Key files | Playable mission INIs observed | Initial Stage 1 value |
| --- | --- | ---: | --- |
| `campaign-proto-1` | `campaign.ini`, force/group prototype INIs, `New File.unitgroup` | 0 in a `missions` subfolder | Prototype/nonlinear or generated-campaign research lead. |
| `linear-campaign-proto-1` | `campaign.ini`, `missions\`, `art\` | 7 | Small developer prototype likely useful for identifying minimum linear-campaign fields. |
| `pacific-strike-task-force` | `campaign.ini`, `commander_settings.ini`, `player_task_force_roster.ini`, localized `campaign_rules_*.xml`, localized `unit_roster_descriptions_*.ini`, `missions\`, `art\` | 14 | Strongest task-force selection, points, resupply, and persistent-force research lead. Its timeline also includes narrative/free-event assets. |
| `strike-group-molniya-campaign` | `campaign.ini`, `missions\`, `art\` | 5 | Compact authored linear campaign with newspaper, intro/interstitial/outro XML events; particularly useful for narrative comparison. |

Important campaign-local patterns found:

- `campaign.ini`: campaign metadata and timeline/progression nodes; Pacific Strike also exposes task-force configuration and reward-related fields.
- `commander_settings.ini`: commander identities/ranks and task-force commander settings (Pacific Strike).
- `player_task_force_roster.ini`: permitted vessel, submarine, helicopter, aircraft, variant, squadron, and loadout entries (Pacific Strike).
- `campaign_rules_<language>.xml`: localized task-force/campaign rules.
- `unit_roster_descriptions_<language>.ini`: localized builder/roster descriptions.
- `art\`: campaign backgrounds, title cards, photos, newspaper headers, and localized event XML.
- `missions\*.ini`: campaign tactical scenarios.
- `missions\<mission>_briefing\BriefingText_<language>.xml` and `BriefingMap_<language>.xml`: localized briefing text/map layouts with associated images.

The `user\campaigns` tree presently mirrors the same named campaign directories. Stage 1 did not assume those copies are pristine or active.

### 3. Standalone missions and scenario narrative

Root: `Sea Power_Data\StreamingAssets\original\missions`

Observed mission categories include:

- `Campaign Scenarios\Pacific Strike`
- `Demo`
- `Intro`
- `JMSDF`
- `NATO`
- `Other`
- `PLAN`
- `Tutorials`
- `Video Tutorials`
- `Warsaw Pact`

This tree contains 72 scenario `.ini` files and 1,219 XML files in the current installation. Most authored missions pair a scenario INI with a `<mission>_briefing` directory containing localized `BriefingText_*.xml`, `BriefingMap_*.xml`, and briefing imagery. Some missions also have `<mission>_data` directories.

The mission INIs are the main static source for environment/date, task forces, spawned units, formations, objectives, triggers/conditions/actions, messages, and campaign-specific mission flags. Exact semantics belong to Stage 3.

User-authored mission locations are present at `Sea Power_Data\StreamingAssets\user\missions\user_missions` and the editor/runtime also has `user\missions\_temp`.

### 4. Unit definitions, variants, squadrons, and costs

| Location | Count | Apparent role |
| --- | ---: | --- |
| `original\vessels` | 500 INIs | Surface ships and submarines. Base `<unit>.ini` files describe the class/type, systems, weapons, magazines, air groups, and flight decks. Matching `<unit>_variants.ini` files describe individual hulls/variants, nation, service dates, liveries, and variant-specific air groups or overrides. |
| `original\aircraft` | 223 INIs | Fixed-wing aircraft and helicopters. Base files define platform/flight/sensor/weapon/loadout behavior; `<unit>_squadrons.ini` files provide squadron/livery/nation/service-date metadata. |
| `original\land_units` | 374 INIs | Airbases, ports, SAM/AAA sites, radars, installations, mobile units, vehicles, buildings, bridges, and other land/mission objects. `LandUnitSubType` values observed/documented in files include `Airbase`, `SAM`, `Installation`, `MobileUnit`, `Radar`, and `Port`. Variant files follow the same broad base/variant pattern. |
| `original\ammunition` | 429 INIs | Missiles, torpedoes, bombs, rockets, guns/projectiles, countermeasures, and related weapon definitions. |
| `original\systems` | 5 INIs | Shared `weapons.ini`, `sensors.ini`, `modules.ini`, `cargo.ini`, and `wip_cargo.ini` system definitions referenced by units. |
| `original\biologic` | 6 INIs | Biological/noncombat contacts and variants. |

Representative authoritative metadata locations:

- `original\nations_reference.ini`: maps unit-name prefixes to nation names (17 entries in this build, including US, Soviet, UK, Canada, Australia, Japan, China, Israel, Iran, and Civilian). This is more reliable than guessing nationality from display names.
- `original\aircraft\usn_f-14a_squadrons.ini`: squadron-specific nation, service dates, liveries, carrier emblems, and modex data.
- `original\vessels\usn_dd_spruance_variants.ini`: individual hull variants with nation, service dates, hull numbers, liveries, and custom helicopter groups.
- `original\vessels\usn_dd_spruance.ini`: class-level role, sensors/weapons, flight deck, helicopter capacity, ammunition, and other platform behavior.
- `[TaskForce]` sections within base unit files are a lead for explicit task-force purchase/loadout costs. Runtime-calculated fallback costs require Stage 4/5 assembly verification.
- `original\InstantActionConfig.ini`: broad NATO/Warsaw Pact/civilian pools by vessels, transports, submarines, aircraft, and helicopters; useful as an index, not yet treated as campaign availability authority.

### 5. Formations, groups, installations, and geography

| Location | Contents |
| --- | --- |
| `original\formations` | Reusable `.unitgroup` formations such as US carrier/battleship battle groups and Soviet CBGs, plus SAM batteries and `FormationTemplates.ini`. |
| `original\templates\port_template.ini` and `port_template_variants.ini` | Port/installation template examples. |
| `original\terrain\objects` | Terrain-associated placed objects; relevant when mapping ports, bases, radars, SAMs, buildings, and scenery to mission geography. |
| `original\campaigns\ports.ini`, regional port/city/installation INIs, `sea_points.ini`, `sea_links.ini`, `patrol_areas.ini` | Strategic-map geography and routing candidates, especially for prototype/generated campaign systems. |
| `original\campaigns\weather` | January/June wind component tables plus `readme.md`; likely strategic weather support rather than all tactical weather configuration. |

### 6. Scripting and trigger support

| Location | Contents and relevance |
| --- | --- |
| `original\documentation\Mission Editor. Triggers and conditions.docx` | Developer-facing documentation specifically for mission-editor triggers and conditions. This is a primary Stage 3 reference. |
| `original\scripts` | JavaScript runtime files (`system.js`, `runtime.js`, `named-register.js`, `launch.html`), packaged Sea Power runtime/AI modules, and `script_infrastructure~` TypeScript source. The included `spai` sources expose agent/state concepts such as attack, airbase, loiter, and default carrier states. Whether ordinary mission INIs can invoke arbitrary scripts is not yet established. |
| `Sea Power_Data\Managed\Seapower-Scripts.dll` | Likely authoritative implementation of INI parsing, trigger/action behavior, campaign state, task-force generation, and persistence. Reserved for later decompilation where needed. |

### 7. Narrative and localization

| Location | Contents |
| --- | --- |
| Campaign `art\*.xml` | Newspaper, intro, interstitial/slideshow, commander-name, and outro event documents, often with language-specific siblings and image assets. `strike-group-molniya-campaign\art` is a compact example set. |
| Campaign/mission `*_briefing` directories | `BriefingText_<language>.xml`, `BriefingMap_<language>.xml`, and map/photo assets. |
| Mission `.ini` `[Language_*]` sections | Mission name/description, map labels, start/outro messages, objective strings, forecasts, and victory/defeat message text. |
| `original\language_en` (and parallel `language_*` trees) | Global localized names for vessels, aircraft, land units, ammunition, loadouts, nations, system groups, UI, environments, and other shared strings. |
| `original\documentation\Localization HowTo.pdf` | Developer localization guidance; a primary Stage 6 reference. |

### 8. Documentation and developer examples

`Sea Power_Data\StreamingAssets\original\documentation` contains:

- `SeaPower_Manual_en.pdf` and `SeaPower_Manual_de.pdf`
- `Mission Editor. Triggers and conditions.docx`
- `Localization HowTo.pdf`
- `Camera controls.pdf`

Additional useful examples include `original\reference\*_squadrons.ini`, `original\templates\*.ini`, prototype campaigns, tutorial missions, and numerous inline comments in campaign/unit/mission INIs.

### 9. Persistence and carry-over investigation targets

No obvious campaign save/state file was identified in the installation workspace during Stage 1. The likely separation is:

- authored defaults/progression rules in campaign and mission INIs;
- runtime state serialized outside the stock `original` tree (possibly Steam Cloud/user profile storage);
- persistence implementation in `Seapower-Scripts.dll`.

This is deliberately **not** yet a behavioral conclusion. Stage 2 must locate save-path code and serialized field names, then compare them with any runtime-created state available on the machine.

### 10. Previous AI handoff/reference documents

Workspace-root references found:

- `TASK_FORCE_CAMPAIGN_HANDOFF.md`
- `TASK_FORCE_POINTS_SYSTEM_HANDOFF.md`
- `SEA_POWER_UNIT_REFERENCE.md`
- `SEA_POWER_UNIT_REFERENCE.html`
- `SEA_POWER_UNITS_BY_1982.md`

They are useful research leads for Pacific Strike, task-force costs, and 1982 unit availability, but are not authoritative. One concrete discrepancy was already found: `TASK_FORCE_CAMPAIGN_HANDOFF.md` says `user\_info.ini` loads Pacific Strike as a base campaign, while the current file contains only a localized name and description. All significant claims will be rechecked against current files and, where required, current decompiled code.

### 11. Stage 1 conclusions and next-stage research queue

Confirmed from the current file layout:

1. Sea Power exposes a broad text-data authoring surface under `StreamingAssets`, with a clear stock (`original`) and user (`user`) split.
2. Four distinct campaign examples exist: a general prototype, a linear prototype, a conventional five-mission authored campaign, and a 14-mission task-force campaign.
3. Pacific Strike is the primary structural lead for points-based force selection, persistent task forces, reward/cap progression, roster filtering, repairs, and rearming.
4. Strike Group Molniya and the linear prototype provide important comparison cases for narrative and minimum required campaign fields.
5. Units are distributed across base class/type INIs and variant/squadron metadata INIs, with supporting shared systems, ammunition, localized names, formations, and nation-prefix mappings.
6. Developer documentation exists for triggers/conditions and localization, and the managed assembly is available for questions static files cannot answer.

Open for Stage 2 and later:

- Exact campaign-node requirements, branching semantics, and defaults.
- Exact serialization/save location and carry-over fields.
- Task-force generation and loss/resupply behavior.
- Cost precedence and automatic point calculation in the current build.
- Mission trigger/action schema and runtime scripting hooks.
- Verified 1982 faction/unit availability and carrier affordability curve.

Stage 1 does not yet select a final template; Pacific Strike is the leading candidate to test in Stage 2 because it matches the requested force-selection model, while Molniya remains the leading narrative comparison.

## Stage 2 — Campaign architecture

### 1. Evidence and confidence

Stage 2 compares these authored definitions:

- `Sea Power_Data\StreamingAssets\original\campaigns\linear-campaign-proto-1\campaign.ini`
- `Sea Power_Data\StreamingAssets\original\campaigns\strike-group-molniya-campaign\campaign.ini`
- `Sea Power_Data\StreamingAssets\original\campaigns\pacific-strike-task-force\campaign.ini`
- `Sea Power_Data\StreamingAssets\original\campaigns\campaign-proto-1\campaign.ini`

It also checks the current implementation in `Sea Power_Data\Managed\Seapower-Scripts.dll` and a read-only, runtime-created Pacific Strike save at:

`C:\Users\User\AppData\LocalLow\Triassic Games\Sea Power\saves\campaigns\linear_campaign_20260822T003146.sav`

The latter is direct evidence of the serialized state produced by this installed build. No save was changed.

The rest of Stage 2 concerns `Type=Linear` campaigns. `campaign-proto-1` is a different strategic/generated campaign architecture and is not interchangeable with this system.

### 2. Overall linear-campaign structure

A linear campaign definition has three important layers:

1. `[File]` identifies the authored base campaign file.
2. `[Campaign]`, optional `[TaskForceMode]`, and `[Language_*]` sections define campaign-level presentation and rules.
3. `[Missions]` plus `[MissionN]` sections define a timeline graph. Despite the section name, a node may be a tactical mission or a narrative/free event.

Pacific Strike begins with:

```ini
[File]
Base=campaigns/pacific-strike-task-force/campaign.ini

[Campaign]
Type=Linear

[Missions]
NumberOfMissions=31
```

`NumberOfMissions` is the number of timeline nodes, not the number of tactical scenario files. Pacific Strike has 31 nodes but only 14 mission INIs. Strike Group Molniya declares 15 nodes for 5 playable missions. The linear prototype declares 17 nodes for 7 playable missions.

The code opens the `[File] Base` definition and reads `Mission1` through `Mission<NumberOfMissions>`. If `Base` is missing, it uses the current filepath and logs that doing so “might be dangerous.” Accordingly, `Base` should be treated as mandatory for a production campaign even though a fallback exists.

### 3. How campaigns reference missions and narrative events

A tactical mission node uses:

```ini
[Mission3]
Type=Mission
MissionFile=campaigns/pacific-strike-task-force/missions/01 Raid on Okinawa.ini
IsUnlocked=False
IsComplete=False
RequiredResult=CostlyVictory
Parents=2
```

`MissionFile` is resolved through the StreamingAssets data system. Task-force missions add `TaskForceModeMissionGenerationType=Generated`; the generator combines the authored scenario with the saved player force according to the node rules.

A free-event node uses localized paths instead:

```ini
[Mission2]
Type=FreeEvent
Parents=1
AssetsPath_en=campaigns/pacific-strike-task-force/art
FilePath_en=campaigns/pacific-strike-task-force/art/19850626_breakingnews_event.xml
```

The current parser recognizes `Mission`, `FreeEvent`, and `NewspaperEvent`. Current stock authored campaigns primarily use `FreeEvent` with external XML/XAML content. Mission nodes obtain briefing-facing `Name`, `Description`, `MissionSequenceName`, `MapShortName`, `MissionImage`, `MissionIntro`, `MissionSpecialNote`, `MissionResupplyRules`, and `MissionWarningPopup` data from localized keys, with English fallbacks where implemented.

### 4. Order, unlocks, and branching

The timeline is a directed graph, not an array that automatically advances solely by numerical order.

- `Parents=2` is converted by the current parser into an unlock definition requiring node 2 to be complete.
- A comma-separated/multi-entry parent list becomes a requirement that **all listed nodes are complete**.
- `UnlockConditionsJSON` can explicitly require both completed nodes and persistent key/value equality.
- `OnCompleteActionJSON` can set persistent key/value data when a node completes.
- `IsUnlocked` and `IsComplete` seed initial authored state and are then written into the campaign save.

The unlock structure in code is effectively:

```json
{
  "completedMissions": [1, 2],
  "persistentEquals": [{"key":"SomeFlag", "value":"True"}]
}
```

Every `completedMissions` entry and every `persistentEquals` comparison must pass. Persistent comparisons are exact string comparisons; a missing key fails the condition.

Pacific Strike provides concrete nontrivial examples:

- Nodes 9, 10, and 12 all unlock from node 8, offering parallel operations.
- `Mission9` and `Mission10` both have `ExpiresAfterMissionComplete=12`, making them unavailable after the main timeline advances through node 12.
- `Mission24` uses `UnlockConditionsJSON={ "completedMissions": [21, 22], "persistentEquals": [] }`, so both its prerequisite submarine mission and the main defense mission must be complete.
- `Mission21` sets `07ASlavaDestroyed=True` with `OnCompleteActionJSON`; campaign or mission content can later test this persistent flag.

The linear prototype branches at node 10 into NATO node 11 and Soviet node 12, then continues those paths separately. It contains `CompletedParentsRequired=1`, but the current `LinearCampaign.ParseUnlock` path does not read that key. It should be considered an obsolete/prototype field, not a supported mechanism. Use `Parents` or `UnlockConditionsJSON` instead.

This architecture supports optional and parallel missions. It does not provide a stock example of branching directly on “victory versus defeat.” A tactical mission completes only when its result meets the threshold, so a below-threshold result normally leaves that node incomplete rather than following a defeat branch.

### 5. Result thresholds and mission completion

The installed build defines mission results in ascending order:

`Incomplete`, defeat grades, `PyrrhicVictory`, `Draw`, `CostlyVictory`, `MarginalVictory`, `MinorVictory`, `Victory`, `SignificantVictory`, `MajorVictory`, `DecisiveVictory`.

The decompiled `LinearCampaignMission.CheckComplete` comparison is:

```text
IsComplete = actualResult >= RequiredResult
```

Therefore `RequiredResult=CostlyVictory` accepts Costly Victory or any higher victory grade, but rejects Draw, Pyrrhic Victory, and defeats. When the property changes to complete, the campaign invokes completion actions and reevaluates other nodes' unlock definitions.

Confirmed stock campaigns consistently author `RequiredResult=CostlyVictory` for tactical nodes. It is safer to author this explicitly rather than rely on a parser/default value.

### 6. Pacific Strike task-force contract

Pacific Strike enables the persistent task-force layer at campaign level:

```ini
[TaskForceMode]
Enabled=True
CommanderSettingsFile=commander_settings.ini
RosterFile=player_task_force_roster.ini
StartingPoints=500
PointCap=500
```

The campaign-level roster is the broad purchase whitelist. Mission-level `TaskForceModeAllowedRosterUnits` can narrow the permitted types/variants/squadrons. The current code resolves the roster sections `AllowedVessels`, `AllowedSubmarines`, `AllowedHelicopters`, `AllowedAircraft`, and `LoadoutPrices`.

Mission deployment is controlled separately:

- `TaskForceModeIncludesTaskForce`: deploy the saved surface force.
- `TaskForceModeIncludesAirwing`: deploy its carried/purchased air component.
- `TaskForceModeIncludesSubmarine`: use submarine deployment behavior.
- `TaskForceModeRequireEntireTaskForce`: whether selection may use a subset.
- `TaskForceModeEnableTaskForceBuilder`: whether the player can purchase/dismiss/reconfigure before this mission.
- `TaskForceModeRequiredUnitType` and `TaskForceModeMaxUnits`: restricted detached-mission selection controls supported by current code.

Pacific Strike's detached submarine missions (nodes 9, 21, and 24) set `IncludesTaskForce=False`, `IncludesSubmarine=True`, and builder false. These are examples of missions using an assigned/restricted subset without deploying the main surface force.

### 7. Rewards, force-cap increases, and availability changes

Rewards are attached to the campaign timeline node, not normally the tactical mission INI:

```ini
TaskForceModeCompletionPoints=100
TaskForceModeCompletionCapPoints=100
```

- Completion points increase spendable points.
- Completion cap points increase the maximum fleet value the player may field.
- The installed code records `CompletionPointRewardApplied` and `CompletionCapRewardApplied`, preventing a completed mission from paying repeatedly.
- `TaskForceModeCompletionRewardedUnits` can grant specified unit/squadron quantities on completion.
- `TaskForceModeLoadoutsToUnlock` unlocks loadout categories after completion.
- `TaskForceModeAllowedRosterUnits` changes availability for an individual mission; the campaign roster remains the outer whitelist.
- `ExpiresAfterMissionComplete` removes optional missions after specified timeline progress.

Pacific Strike uses all of these mechanisms. Its 14 tactical nodes each carry authored point and cap rewards; the detailed growth curve is reserved for Stage 5.

The saved Pacific Strike state confirms persistent fields including `TaskForceAvailablePoints`, `TaskForcePointCap`, `TaskForceUnlockedLoadouts`, `Losses`, difficulty-rule selections, commander progression, ribbons, and cumulative service-record totals.

### 8. How selected units and state carry forward

The campaign save is a text INI-like `.sav` file. Its `[File] Base` points back to the authored campaign; it does not overwrite the stock campaign INI.

The current task-force implementation maintains several layers:

| Saved state | Purpose |
| --- | --- |
| `[PersistentData]` | Points, cap, task-force name, unlocked loadouts, cumulative losses, commander data, formation, difficulty/rule selections, and campaign flags. |
| `[CurrentTaskForce]` and `CurrentTaskForce_Unit*` | Canonical current roster and purchased quantities/loadouts. |
| `TaskForceMode_MissionN_Launch*` | Frozen roster and detailed unit state used to launch/replay a mission. |
| `TaskForceMode_MissionN_Post*` | Post-mission surviving roster, available points/cap, reward flags, and joined/rewarded units. |
| `TaskForceMode_MissionN_LaunchState_*` / `PostState_*` | Detailed platform state including damage/destruction and weapon-system/magazine contents. |
| `Mission_N_*` native sections | General campaign-unit persistence projected from the tactical mission: unit identity, variant/squadron, loadout, air group, flight-deck ammunition, magazines, and related state. |
| `TaskForceMode_Record` and mission debrief sections | Applied-mission indexes, kills/losses/score/survivors, and idempotency records. |

Each task-force item has a persistent instance ID plus type/folder/category, variant or squadron reference, loadout variant, cost, quantity, flagship eligibility, crew skill/survival credits, and aircraft assignments. The formation is stored as instance ID plus relative coordinates.

This confirms that the player's selected force is not reconstructed merely from points after every mission. The roster and individual state are serialized and advanced from launch to post-mission to the next available snapshot.

### 9. Loss persistence

The installed save manager explicitly:

- records destroyed player-unit instance keys;
- removes destroyed ships/submarines from the persistent roster;
- counts aircraft losses from the debrief and reduces persistent owned quantities;
- removes invalid aircraft assignments after losses;
- records a compact cumulative `Losses` list such as `unitType,quantity,MissionN`;
- preserves surviving units' detailed state and advances crew-survival credit.

The inspected Pacific Strike save contains real persistent loss entries for helicopters and aircraft across multiple missions, confirming this is active runtime behavior rather than unused serialization code.

For ordinary non-task-force linear campaigns such as Molniya, `LinearCampaign.SavePersistentDataFromMission` also copies campaign-tagged unit sections and their magazines/flight-deck state into the campaign save. Molniya's runtime save demonstrates ship state and ammunition persisting under sections such as `[Mission_4_p1]` and weapon-magazine subsections. Thus persistence is not exclusive to the points-based builder, although Pacific Strike adds a much richer canonical roster layer.

### 10. Rearm, repair, and resupply

Mission-node logistics keys are:

```ini
TaskForceModeRearm=True|False
TaskForceModeRepair=True|False
TaskForceModeEnableTaskForceBuilder=True|False
```

The current code reads these from `MissionN`. It also supports conditional rearming through `TaskForceModeRearmByVariableAND` and `TaskForceModeRearmByVariableOR`.

Behavioral separation:

- **Rearm** replenishes eligible campaign ammunition/loadout state when enabled.
- **Repair** allows damage to be cleared subject to campaign damage classes, repair-price rules, difficulty modifiers, and available points.
- **Builder** controls access to purchases, dismissals, loadout acquisition, and roster changes; it is independent of repair/rearm.
- When repair or rearm is false, the post-mission damage and magazine state remains available to the next generated deployment.

Pacific Strike deliberately alternates logistics states. Examples:

- Nodes 3, 4, 6, 10, 14, 17, 22, and 26 enable repair and rearm.
- Nodes 12 and 19 explicitly disable both while retaining builder access.
- Detached submarine nodes disable the main builder and do not deploy the saved surface task force.
- Final node 29 explicitly disables repair and rearm.

Localized `MissionResupplyRules_<language>` text explains these authored states to the player, but that text is presentation only; the boolean/conditional task-force fields control behavior.

### 11. Victory/defeat branches

Confirmed mechanisms:

- Threshold success: `actualResult >= RequiredResult` completes a mission node.
- Completion unlocks children through `Parents`/`UnlockConditionsJSON`.
- Completion can set persistent flags using `OnCompleteActionJSON`.
- Persistent flags can participate in later unlock conditions and tactical mission persistence.
- Optional missions can expire after another mission completes.

Not found in current stock examples:

- A direct `OnDefeat` campaign-node action.
- A child-node rule testing a particular result grade.
- An authored campaign route that continues after a required mission's defeat.

Therefore the safe current design model is “retry until the required result,” with branches based on which optional/parallel nodes were completed and on persistent flags. A true defeat-continuation branch would require runtime experimentation or a verified alternative action path.

### 12. Briefings, debriefings, and news attachment

Campaign-level attachment is divided as follows:

- Mission tile/intro/resupply text and imagery: localized keys inside the campaign node.
- Full tactical briefing: the referenced mission INI plus its sibling `<mission>_briefing` directory.
- Tactical victory/defeat messages and objectives: localized sections inside the mission INI.
- Between-mission news/documents/slideshows: `FreeEvent`/`NewspaperEvent` nodes pointing to localized XML/XAML under campaign `art`.
- Optional completion content: `OnCompleteEvent=True` plus localized `OnCompletePath_*` files, seen in the linear prototype.
- Post-mission persistent task-force report: generated from debrief and saved task-force state; current code writes task-force debrief and reward/loss records into the campaign save.

Narrative document schemas are reserved for Stage 6, but their campaign attachment points are confirmed here.

### 13. Mandatory versus optional values

#### Required or production-essential

- `[File] Base`: technically has a fallback, but the game warns when it is absent.
- `[Campaign] Type=Linear`.
- `[Missions] NumberOfMissions`, matching the numbered nodes intended to load.
- Unique `[MissionN]` sections. The linear prototype accidentally contains two `[Mission1]` headers, demonstrating why it should not be copied blindly.
- `Type` on every node (`Mission`, `FreeEvent`, or `NewspaperEvent`).
- `MissionFile` for a tactical mission node.
- A valid localized `FilePath_*` for free-event content intended to display.
- `RequiredResult` for predictable tactical completion.
- A valid unlock definition: initial `IsUnlocked=True` for entry nodes, and `Parents` or `UnlockConditionsJSON` for later nodes.
- For task-force mode: `Enabled=True`, a valid `RosterFile`, starting points/cap, mission generation/deployment rules, and explicit builder/repair/rearm values wherever logistics matter.

#### Optional or presentation/specialization fields

- `BackgroundImage`, map-display/tile fields, icon type, mission images, special notes, warning popups, and resupply explanatory text.
- Non-English localized values where English fallback exists. Missing assets still risk visibly missing content and should be validated.
- `CommanderSettingsFile`, commander/ribbon/crew rules, difficulty presets, threat profiles, deployment preview, air-tasking, airbase prep, reward units, loadout unlocks, and expiry rules.
- `IsComplete` normally begins false; both state flags are subsequently persisted in saves.
- `OnCompleteActionJSON` and `OnCompletePath_*`.

Unknown/unsafe to rely on:

- `CompletedParentsRequired`; current code does not read it in the active unlock parser.
- Implicit defaults for omitted task-force logistics booleans. Pacific Strike sometimes omits them on detached missions, but a new campaign should author explicit values for every persistent-force mission.

### 14. Concrete architecture recommendation after Stage 2

For the proposed alternate-history Falklands campaign, `pacific-strike-task-force` remains the recommended structural template because it already demonstrates the exact high-level model required:

- persistent player-selected forces;
- points and independently increasing fleet cap;
- surviving hull, aircraft, ammunition, damage, loadout, and crew state;
- full-resupply and limited/no-resupply stretches;
- detached missions that do not deploy the main force;
- optional missions and mission expiry;
- unit/loadout rewards and restricted availability;
- narrative timeline nodes interleaved with tactical missions.

It should not be copied literally. The new campaign should use a unique user-data folder and a cleanly authored timeline, while borrowing Molniya's more compact narrative presentation patterns where useful.

Stage 2 is complete. Mission/scenario internals remain reserved for Stage 3.

## Stage 3 — Mission architecture

### 1. Evidence and representative scenarios

Stage 3 examined the mission corpus under:

- `Sea Power_Data\StreamingAssets\original\missions`
- `Sea Power_Data\StreamingAssets\original\campaigns\*\missions`

Representative detailed comparisons included:

- `campaigns\pacific-strike-task-force\missions\01 Raid on Okinawa.ini` — generated surface task force, convoy/landing prevention, neutral traffic.
- `...\03A Run Silent Run Deep.ini` — detached submarine operation.
- `...\04 Sunda Strait.ini` — persistent task force without repair/rearm and rewarded air units.
- `...\05 Strike on the Monster.ini` — carrier/airwing operations, zones, random enemy placement.
- `...\08 Defense of North Borneo.ini` — airbase, SAM battery, amphibious shipping, multiple air strikes, submarines, campaign joins.
- `...\10 Vengeance at Luzon.ini` — final large task-force mission and deployment zones.
- `original\missions\NATO\Caron at Grenada 1983.ini` — standalone land/air/naval scenario.

The following were also used as implementation references:

- `original\documentation\Mission Editor. Triggers and conditions.docx`, revision 0.2 dated 2024-09-13.
- Trigger, condition, mission-manager, and task-force mission-generator types in `Sea Power_Data\Managed\Seapower-Scripts.dll`.

The documentation accurately explains the core trigger model but predates many condition/action types present in the current build. Current stock mission files plus current assembly metadata take precedence.

### 2. Scenario file layout

A typical mission INI is organized into these blocks:

```text
[Language_*]                 localized title, description, objectives, messages
[Environment]                date, time, weather, map center
[Mission]                    sides, unit counts, formations, trigger count
[Taskforce1Vessel1]          individual unit sections
[Taskforce2Aircraft1]
[NeutralLandUnit1]
[Trigger1]                   conditions and actions
[Taskforce1_Objectives]      objective scoring/behavior
[BackgroundData]             optional world datasets
[MapSymbols] / [MapSymbol_*] campaign/briefing overlays
[Zones] / [Zone_*]           task-force deployment/map zones
[GameplayAnchors]            retreat and other gameplay anchor points
```

The file is count-driven. `[Mission]` declares how many vessels, submarines, aircraft, helicopters, land units, biologics, formations, and triggers exist for each side. The loader then expects matching numbered sections. Counts and section numbers must remain synchronized.

### 3. Factions, sides, and player control

The tactical layer uses task forces rather than campaign nation names as its primary sides:

```ini
[Mission]
PlayerTaskforce=Taskforce1
EnemyTaskforce=Taskforce2
Taskforce1_Nation=...
Taskforce2_Nation=...
Taskforce1_RulesOfEngagement=Restricted
```

- `PlayerTaskforce` determines the player-controlled side.
- `EnemyTaskforce` identifies the opposing AI side.
- `Taskforce1` and `Taskforce2` unit sections hold combatants.
- `Neutral*` sections hold civilians, ambient traffic, biologics, or initially nonaligned military units.
- Nation can be supplied at task-force level and overridden on an individual unit with `Nation=...`.
- The side may change during play through `Action_UnitTransferToTaskforce`.

An individual player-side unit is normally controllable by virtue of belonging to the player task force. `SetSelected=True` chooses the initial selection. `Disabled=True` means a unit is authored but inactive until enabled; it is a common reinforcement technique, not an AI/player-control flag.

The mission-manager ROE enum supports `Unrestricted`, `Permissive`, and `Restricted` (plus an internal nonexistent/default value). Only a small number of current stock mission INIs explicitly set `TaskforceN_RulesOfEngagement=Restricted`; most instead control engagement using unit `WeaponStatus`, identification state, messages, and trigger-driven changes.

### 4. Environment, time, weather, and map

Observed `[Environment]` keys are:

```ini
Date=1985,9,19
Time=23,0
ConvertTimeToLocal=False
SeaState=3
Clouds=Broken
WindDirection=E
Weather=...
LayerDisabled=...
MapCenterLatitude=6.05
MapCenterLongitude=118.32
MapInitialZoom=...
LoadBackgroundData=False
```

The date/time establishes the tactical start and also affects unit service-date filtering where applicable. Positions in unit sections are normally relative nautical-mile coordinates around the map center: `RelativePositionInNM=x,height,z`. Some content uses absolute `GeoPosition`.

Height accepts numeric altitude/depth and named depth tokens such as `shallow`, `periscope`, or `low` depending on unit/domain. Submarine examples use `RelativePositionInNM=...,shallow,...`; aircraft use feet-like numeric altitude values in mission authoring.

Weather can change after mission start through trigger actions including sea state, clouds, wind, rain/snow, thunderstorm, and fog. Current stock files actively use sea-state, cloud, rain, thunderstorm, and fog changes.

`[BackgroundData]` optionally loads city, airport, port, installation, and scenery datasets and may specify default `.unitgroup` files. This is background/world population, separate from explicitly counted mission units.

### 5. Units and spawning

Unit section names encode side, domain, and index:

- `Taskforce1Vessel1`
- `Taskforce2Submarine1`
- `Taskforce1Aircraft1`
- `Taskforce1Helicopter1`
- `Taskforce2LandUnit1`
- `NeutralVessel1`
- `NeutralBiologic1`

Core identity fields are:

```ini
Type=usn_dd_spruance_abl
VariantReference=Variant2
```

or for aircraft:

```ini
Type=usn_f-14a
SquadronReference=Squadron9
LoadoutVariant=AirToAirLongRange
```

Common state/behavior fields include:

- Position: `RelativePositionInNM`, `GeoPosition`, `PositionRelativeTo`, `StationPosition`.
- Randomization: `RandomSpawnCenter`, `RandomSpawnRange`, `RandomSpawnDirection`, `SpawnChance`, `SpawnDifficulty`, `RandomizeCourse`.
- Movement: `Heading`, `Telegraph`, `Waypoints`, `AutomateRoute`.
- Combat: `WeaponStatus`, `OverrideWeaponStatus`, `RadarsActive`, `ActiveSonarsEnabled`, `TowedArrayDeployed`, `TowedDecoyDeployed`, `Attack`, `AllowedTargetForMissiles`.
- Human factors: `CrewSkill`, `Morale`, `UnlimitedFuel`.
- Lifecycle: `Disabled`, `SpawnByVariableAND`, `RetreatAfterWeaponsExpended`, `MissionTarget`, `IsValuableUnit`.
- Air operations: `HomeBase`, `CallsignIndex`, `CustomAirGroup`, per-aircraft-type embarked counts, flight-deck settings.

`SpawnByVariableAND` is a campaign-aware conditional spawn mechanism. It permits tactical content to include or omit a unit based on persistent campaign variable state. This is the main static bridge for optional-mission consequences such as an enemy ship already destroyed earlier.

### 6. Formations and naval groups

Formations are declared in `[Mission]`:

```ini
Taskforce1_NumberOfFormations=1
Taskforce1_Formation1=Taskforce1Vessel1,Taskforce1Vessel2|Group Name|Loose|1.5
```

The value combines:

1. comma-separated member section IDs;
2. display/group name;
3. formation pattern name;
4. spacing;
5. optional flags such as `OverrideSpawnPositions`.

Formation leaders normally carry route/attack behavior while other members use `StationRole` and/or `StationPosition`. Observed station roles include task-oriented values such as `Core` and `AAW`. Units can be removed from or returned to formation through waypoint directives and trigger actions:

- `Action_UnitDisbandFormation`
- `Action_UnitReformFormation`
- waypoint `ReturnToFormation`

Reusable `.unitgroup` files under `original\formations` are templates/reference groups. Mission INIs ultimately contain the concrete numbered units and formations used at runtime.

### 7. Movement, patrols, and waypoint actions

`Waypoints` is a pipe-separated route. A point can append slash-delimited commands. Commands observed in current mission files include:

- `SetTelegraph`
- `SetSensors`
- `SetWeaponStatus`
- `AttackAtWaypoint`
- `VID`

The current runtime also recognizes route directives such as loop/course/turn/random turns, return to formation, patrol-around variants, move to spawn/current position, and autogenerated route handling.

Example:

```ini
Waypoints=x,alt,z/SetWeaponStatus,Free|x,alt,z/AttackAtWaypoint,weapon,target,1
```

This permits deterministic attack profiles without external scripts. Formation followers need not duplicate the leader's entire route.

### 8. Aircraft, carriers, and airbases

Aircraft may begin airborne or be associated with a carrier/airbase:

- `HomeBase=Taskforce2LandUnit2` associates an aircraft with a base.
- `CustomAirGroup=True` followed by `unitType=SquadronReference,quantity[,crew]` defines embarked/based aircraft.
- `FlightDeckAIDisabled=True` suppresses autonomous deck operations until enabled.
- `FlightDeck_AmmoCapacity` and accountable ammunition-category fields override/persist aviation stores.
- `FlightDeck_ReadyUpTasks` and numbered ready-up entries can preconfigure deck activity.
- `Action_PrepareFlightDeck` and `Action_EnableFlightDeckAI` activate prepared aviation behavior.

Pacific Strike generated missions additionally tag aircraft placeholders with:

```ini
TaskForceModeAirTaskingSlot=1
TaskForceModeAirTaskingRole=CAP
```

The task-force generator replaces/fills these based on the player's pre-mission air-tasking selection.

Dynamic air reinforcement has two established patterns:

1. Author aircraft as `Disabled=True`, then use `Action_SetEnabledStatus=True` on their section IDs at the chosen time/condition.
2. Use `Action_AirStrike` with source units/bases, position/radius, maximum attackers, and partial-strike rules.

### 9. Submarines

Submarines use numbered `TaskforceNSubmarineN` sections and the same general identity, state, route, randomization, and trigger references as surface units. Their vertical coordinate uses depth values/tokens and they can start with sonar/towed-array state set explicitly.

Detached campaign submarine missions demonstrate two approaches:

- The tactical scenario contains an authored submarine.
- The campaign node sets `TaskForceModeIncludesTaskForce=False`, `TaskForceModeIncludesSubmarine=True`, and may impose a restricted-unit rule.

The main persistent surface roster consequently remains undeployed while the selected/assigned submarine operation is resolved.

### 10. Land units and installations

Land objects are ordinary counted mission units using `TaskforceNLandUnitN` or `NeutralLandUnitN`. Their referenced base definition determines whether they are an airbase, port, SAM element, radar, installation, mobile unit, building, bridge, or other target.

Composite sites are built as formations of individual pieces. Pacific Strike Mission 8, for example, forms a Hawk battery from a radar, fire-control radars, and launchers, while separately placing `airfield_small_1` and `wp_airbase_4` units.

Land units can:

- participate in formations;
- be named/localized like other units;
- host aircraft and aviation stores if their definition provides a flight deck/airbase;
- be objectives, trigger-condition units, or attack waypoint targets;
- be enabled, disabled, revealed, transferred, damaged, repaired, or destroyed through the trigger system.

### 11. Trigger model

Each scenario declares `NumberOfTriggers` and corresponding `[TriggerN]` sections. A trigger has:

- descriptive/identity fields (`Name`, optional `Description`);
- state such as disabled/repeatable;
- one or more `Condition_<key>_*` definitions;
- a `ConditionsCompleted` Boolean expression;
- zero or more `Action_*` fields.

Example:

```ini
[Trigger3]
Name=Victory
Condition_Condition1_Type=UnitDestroyed
Condition_Condition1_Units=Taskforce2Vessel1,Taskforce2Vessel2
Condition_Condition2_Type=Time
Condition_Condition2_Time=4500
ConditionsCompleted=<Condition1> AND <Condition2>
Action_Victory=Taskforce1
Action_EndMission=True
Action_ObjectivesCompleted=DestroyEnemyForces
```

Condition keys inside angle brackets are joined with uppercase `AND`, `OR`, `NOT`, and parentheses. Conditions in the file may be deliberately omitted from the expression or used negatively. Trigger names should be unique because trigger-chain actions identify them by name.

Condition types actually used in current stock mission files are:

- `Generic`
- `OnMissionStart`
- `Time`
- `VariableCheck`
- `UnitDestroyed`
- `UnitsInTheArea`
- `HasNoUnitsOfType`
- `UnitDetected`
- `UnitClassified`
- `UnitsAreOutOfAmmo`
- `UnitHasNoGuidanceSystems`

The current runtime enum also supports `NoIncomingWeapons`, `UnitDamageState`, `TriggerCompleted`, `TriggerFailed`, and `JoinedCondition`, even though the scanned stock mission corpus did not use all of them.

Condition parameters include units, unit type, task force, minimum count, time, ammunition, position, radius, localized area label/display side, and variable comparison data.

### 12. Trigger actions and reinforcements

Major action families confirmed in current stock files/current runtime include:

- Player communication: task-force messages, voice messages/nation, intel entries, free content, forecast.
- Mission result: `Action_Victory`, objectives complete/fail/cancel/hide/unhide, `Action_EndMission`, delayed end.
- Trigger control: enable, disable, reactivate, complete, or fail other triggers.
- Unit lifecycle: enable/disable, despawn, destroy, reveal/detect/classify/identify, transfer allegiance.
- Unit state: propulsion/sensor/weapon-system availability, flight-deck AI, rearm, repair.
- Movement: position relative to another unit, teleport, heading, telegraph, new waypoints, formation disband/reform.
- Aviation: prepare flight deck and initiate an air strike from selected sources.
- Environment: sea state, clouds, wind, precipitation, thunderstorm, fog, and time changes.
- Campaign state: set/add/multiply/divide/invert persistent mission variables.

The most common reinforcement pattern is pre-authoring units as disabled and enabling them from a time/event trigger. This retains explicit control over type, formation, route, home base, and loadout. `Action_AirStrike` is the more dynamic alternative for air attacks.

### 13. Objectives and victory/defeat

Player objectives reside in `[TaskforceN_Objectives]`:

```ini
DestroyEnemyForces=500,-500,Complete,Main
FlagshipMustSurvive=5,-5,Complete
HiddenIntelTarget=20,0,None,Hidden
```

The key is the objective ID referenced by localized strings and trigger actions. The comma-separated values encode:

1. score when completed;
2. score when failed;
3. mission-end behavior (`Complete`, `Fail`, or `None`/blank);
4. optional flags such as `Main` and `Hidden`.

Triggers explicitly update objectives through `Action_ObjectivesCompleted`, `Failed`, `Cancel`, `Hide`, and `UnHide`. Victory and defeat are not inferred solely from objective score: decisive triggers use `Action_Victory=TaskforceN`, often combined with `Action_EndMission=True` or `Action_EndMissionDelay`.

Common patterns are:

- player victory after required enemy units are destroyed or an area/time condition is satisfied;
- player defeat if a flagship, convoy, landing force, airbase, or protected installation is destroyed;
- defeat if hostile units enter a protected area;
- timeout/exit triggers enabled by a preceding victory/defeat trigger;
- optional objectives updated independently of the final result.

### 14. Messages and localization

`[Language_en]` and sibling language sections contain:

- mission `Name` and `Description`;
- unit name/short-name overrides;
- map-symbol labels;
- condition-area labels;
- objective strings (`Objective_<id>`);
- trigger messages, voice lines, intel, free-content references, and forecasts.

Trigger action fields reference these keys rather than duplicating localized prose:

```ini
Action_Taskforce1_Message=Taskforce1StartMessage
Action_Forecast=StartForecast
```

Message payloads can use popup fields such as title/body/button/style or naval-message headers. Runtime formatting supports unit substitutions such as `{$UnitName}`, `{$UnitNameFull}`, `{$UnitClass}`, `{$UnitClassFull}`, and `{$TrackId}`, plus campaign/mission variable substitutions.

### 15. Campaign-specific mission fields

Fields observed specifically in generated/persistent task-force scenarios include:

- `TaskForceModeAnchor=True`: reference point for inserting the saved force.
- `TaskForceModeReplacedUnitIndex=N`: authored slot replaced by a selected persistent unit.
- `TaskForceModePlaceholderUnit=True`: generator placeholder rather than a literal fixed unit.
- `TaskForceModeIgnoreUnit=True`: excluded from normal task-force persistence/generation treatment.
- `TaskForceModeAirTaskingSlot` and `TaskForceModeAirTaskingRole`: player-selected mission air assignment slots.
- `JoinTaskForce=True`: surviving authored/reward unit can join the persistent roster.
- `CampaignTag=...`: stable unit identifier for general campaign persistence.
- `CampaignRearm`, `CampaignRepair`, and `CampaignResetAirgroup`: unit-specific persistence/logistics overrides.
- `SpawnByVariableAND`: include a unit only when campaign variable conditions are satisfied.

These fields are essential when a mission both contains fixed scenario assets and accepts the player's persistent task force.

### 16. Map overlays, zones, and gameplay anchors

`[MapSymbols]` lists named symbol sections used in `CampaignMap` and/or `BriefingMap`. Current symbols include labels, threat arrows, unit icons, and other graphical forms with geographic points, bearing, domain, side/color, size, and localized label keys.

`[Zones]` and `[Zone_*]` define areas used by campaign deployment and map presentation. Pacific Strike uses task-force zones to constrain or preview where the generated player force may be placed.

`[GameplayAnchors]` lists anchor sections such as retreat points. A retreat anchor provides side, geographic location, and altitude/depth and is used by AI withdrawal behavior such as `RetreatAfterWeaponsExpended=True`.

### 17. Scripting hooks

No stock mission INI inspected in Stage 3 references a JavaScript file, module, or arbitrary script callback. The mission authoring interface is the declarative trigger/condition/action system plus waypoint commands and campaign variables.

The JavaScript/TypeScript infrastructure under `original\scripts` supplies runtime/AI facilities, but no supported per-mission `Script=...` field was found in the stock corpus or active mission trigger model. Therefore a new campaign should assume **no arbitrary mission script hook** unless a future runtime test or developer documentation proves otherwise.

Nearly all anticipated Mission 1 behavior—delayed identification, restricted engagement, convoy route, cargo arrival area, escalation messages, optional reveal, reinforcements, victory/defeat, and persistent outcome flags—can be implemented with existing declarative mechanisms.

### 18. Required versus optional mission data

#### Required or production-essential

- At least one valid unit/group for both opposed sides; the editor documentation treats this as a trigger-system precondition.
- `[Environment]` date/time and map center for predictable placement.
- `[Mission]` player/enemy task force, accurate unit/formation/trigger counts, and matching numbered sections.
- Valid unit `Type` plus `VariantReference` or `SquadronReference` as appropriate.
- Valid position, heading/state sufficient for each spawned unit.
- A player objective section and explicit result/end triggers for predictable campaign scoring.
- Unique trigger names, valid condition expressions, and action references.
- English mission/objective/message localization and valid briefing assets.

#### Optional/specialized

- Neutral traffic, biologics, randomized spawns, background data, map symbols, deployment zones, gameplay anchors.
- Explicit ROE, unit name overrides, custom air groups, deck stores, home bases, initial sensor/towed-system states.
- Dynamic weather, voice messages, free-content popups, intel entries.
- Campaign task-force placeholders, join rewards, persistent tags, campaign-variable spawns.

For a persistent campaign mission, campaign-specific insertion/persistence fields are not globally mandatory, but they become mandatory wherever the authored scenario expects the generator to replace or join particular units.

### 19. Stage 3 implications for the proposed first mission

Without designing Mission 1 yet, the current architecture can support its core concept:

- A Soviet convoy can follow an authored formation route toward a geographic/relative arrival area.
- Strategic-cargo arrival can trigger player defeat through `UnitsInTheArea`.
- The initial below-war political situation can use restricted ROE, held weapon status, detection/classification conditions, staged messages, and later weapon-status changes.
- Search uncertainty can use random spawn centers/ranges and initially unrevealed contacts.
- A small persistent US force can replace task-force placeholder slots while carriers are excluded by the campaign roster/mission allowlist.
- Survivors, expenditure, damage, and losses can carry forward through task-force persistence.
- Optional outcomes can set campaign variables for later missions.

These are capability findings, not a finalized scenario design.

Stage 3 is complete. Unit-database and 1982 availability analysis remain reserved for Stage 4.

## Stage 4 — Unit system

### 1. Evidence and correction to the prior unit references

The two root unit handoffs were read and compared:

- `SEA_POWER_UNIT_REFERENCE.md`
- `SEA_POWER_UNITS_BY_1982.md`

`SEA_POWER_UNIT_REFERENCE.html` contains the same 550 unique code/definition identifiers as the Markdown catalog; it is a rendered companion rather than independent evidence.

The full catalog correctly explains the database split and is a useful index. Its reported inventory is 549 base definitions: 250 vessels, 112 aircraft, and 187 land units. One extra code token comes from explanatory text rather than a standalone unit.

The compact 1982 document uses a deliberately loose rule: include a base type if its **earliest** variant or squadron began service by 1982. That is useful for brainstorming but unsafe for final rosters because:

- a base type can contain variants from different years and countries;
- a later refit may share an early class-level ID;
- many metadata entries, especially land units, have no service date;
- a default metadata section may not represent a real selectable hull;
- some in-game dates describe the represented fit rather than the historical class commission date.

Stage 4 therefore verifies nationality and dates at `VariantN`/`SquadronN` level. A dated entry is considered available in 1982 only when its interval includes 1982. Undated entries are reported separately as “database-present, historical verification required.”

### 2. Base class/type versus individual variant

The fundamental reference used in missions and campaign rosters is the base filename without `.ini`:

```ini
Type=usn_dd_spruance
VariantReference=Variant2
```

For aircraft and helicopters:

```ini
Type=usn_f-14a
SquadronReference=Squadron9
LoadoutVariant=AirToAirLongRange
```

The layers are:

| Layer | Source | Function |
| --- | --- | --- |
| Base platform | `original\vessels\<id>.ini`, `aircraft\<id>.ini`, `land_units\<id>.ini` | Physical/flight model, role, sensors, weapons, magazines, movement, damage, deck/base capability, and available loadouts. |
| Ship/land variant | matching `<id>_variants.ini` | Individual hull or national variant, livery, flag, service dates, loadout override, and variant-specific air group. |
| Aircraft squadron | matching `<id>_squadrons.ini` | Squadron/nation, service dates, livery, serial/modex textures, emblem, and flag. |
| Mission instance | mission `[Taskforce...UnitN]` section | Selected variant/squadron, loadout, starting position/state, skill, ammunition/deck overrides, and campaign persistence tags. |

A base prefix is only a naming convention. It is not sufficient nationality evidence. For example, Argentine aircraft use base `fr_mirage_iii` with `Squadron6 Nation=Argentina`, and Argentine radar uses `usa_radar_tps-43 Variant2 Nation=Argentina`.

### 3. Country and faction restrictions

Authoritative country affiliation comes from the resolved variant/squadron metadata `Nation` value. `[Default]` values are inherited unless the numbered entry overrides them. `AllVariantsAreOfSameNation=False` flags mixed-nationality metadata files.

`original\nations_reference.ini` maps broad ID prefixes to a smaller set of display nations, but it does not enumerate every country used in variant metadata. Campaign roster filtering operates on the selected unit type and allowed variant/squadron; mission files can additionally override `Nation` for a specific instance.

Availability is layered:

1. The unit definition must exist.
2. The selected variant/squadron must satisfy date filtering when `LimitUnitDates` is enabled.
3. The campaign roster must permit the type/reference.
4. The individual mission allowlist can narrow it further.
5. Purchased-loadout and loadout-unlock rules may restrict configuration even when the platform is available.

This makes staged NATO escalation practical without changing base unit definitions: later missions can expand their allowlists or the campaign can reward particular units/loadouts.

### 4. Service-date behavior and data quality

Typical metadata uses:

```ini
Nation=US
ServiceDate=1976|1987
```

Single-year values also occur. Empty values are common. The current database has much better service-date coverage for vessels than for land units; land-unit metadata is largely undated. Aircraft squadron coverage is also incomplete.

Important 1982 examples:

- `usn_cv_america_79 Variant1`: `1977|1996` — valid.
- all four `usn_cv_forrestal_75` numbered hulls: intervals include 1982 — valid.
- `usn_cv_kitty_hawk` variants: begin 1983 — excluded by strict 1982 filtering in this represented fit.
- `usn_cvn_nimitz` variants: begin 1983/1987 — excluded despite the historical lead ship commissioning earlier; this is a database-fit limitation.
- `usn_cvn_enterprise Variant1`: ends 1978 — excluded because the represented fit is older.
- `usn_bb_iowa Variant2` (BB-62/New Jersey texture): begins 1982; other Iowa-class variants begin 1984, 1986, and 1988.
- `rn_dd_z-class Variant5` (UK): ends 1969. Its undated `[Default]` must not be mistaken for a valid 1982 British hull.
- `fr_mirage_iii Squadron6 Nation=Argentina`: service date is blank; usable technically, but its exact campaign date must be validated historically.

The campaign should use explicit numbered references and maintain its own reviewed 1982 whitelist rather than enabling an entire base class by earliest date.

### 5. Aircraft squadrons and loadouts

Squadron metadata primarily changes identity and presentation, not the base aircraft's flight model or weapon-system architecture. It supplies nation, service interval, serial/modex sets, livery, emblem/carrier marking, and flag.

Aircraft base INIs declare available loadout names and implement them with suffix-specific weapon sections. For example, `original\aircraft\usn_f-14a.ini` has:

```ini
AvailableLoadouts=AirToAirLongRange,AirToAir,AirToAirIntercept
```

and sections such as:

- `[WeaponSystem1Default]`
- `[WeaponSystem1AirToAir]`
- `[WeaponSystem1AirToAirLongRange]`
- `[WeaponSystem1AirToAirIntercept]`

The mission's `LoadoutVariant` selects the corresponding configuration. Friendly loadout names are localized through `original\language_en\loadout_names.ini`.

Not every theoretically appropriate historical weapon is available on every aircraft. Campaign design must use the exact `AvailableLoadouts` and weapon-section suffixes present on the selected base ID.

### 6. Sensors, weapons, and ammunition

Base unit files provide platform installation points and system composition:

- `[SensorSystems]` and numbered sensor systems.
- `[WeaponSystems]` and numbered launchers/guns/CIWS.
- weapon magazines and ammunition counts.
- optical/visual signature, RCS, IR signature, sonar/noise, and damage-related data.

Shared implementations live in:

- `original\systems\sensors.ini`
- `original\systems\weapons.ini`
- `original\systems\modules.ini`
- `original\ammunition\*.ini`

The platform references shared system/ammunition IDs, while its own mount, arc, capacity, launcher, and loadout sections determine how they are installed. Consequently, platform capability cannot be inferred reliably from `Role=` alone; weapon, sensor, magazine, and loadout sections must be inspected for mission balancing.

### 7. Ship helicopters and carried aircraft

Carrier, aviation ship, helicopter-capable escort, and airbase definitions use `[AirGroup]` and `[FlightDeck]`:

```ini
[AirGroup]
usn_sh-2f=Default,2

[FlightDeck]
AircraftCapacity=2
AircraftSupported=Helicopters
```

Large carriers list several aircraft type/squadron/quantity combinations. `usn_cv_america_79.ini`, for example, has an 85-aircraft capacity and F-14A, A-7E, A-6E, E-2C, EA-6B, RA-5C, S-3A, and SH-3H entries. `wp_takr_kiev.ini` has capacity 36 and a default Yak-38/Ka-27 group.

Numbered hull variants may set `CustomAirGroup=True` and replace the base composition. Mission instances can override it again. The task-force campaign rule `ShipIncludesAirwing` decides whether the builder bundles an air group with a ship purchase; it does not change physical deck compatibility or capacity.

For 1982 carrier use, the selected hull's custom/default air group must also contain squadrons whose service interval covers 1982. A valid carrier hull does not automatically make every database aircraft/squadron historically valid.

### 8. Point costs

No current base unit INI under `original\vessels`, `original\aircraft`, or `original\land_units` contains a `[TaskForce]` section or authored `TaskForceCost`/`LoadoutCost_*` field. Therefore current stock task-force prices are runtime-calculated from combat metadata.

The installed code supports optional positive overrides:

```ini
[TaskForce]
TaskForceCost=...
LoadoutCost_<LoadoutReference>=...
```

but none are active in the present stock database. The `|points_cost` notation in comments around the Pacific Strike roster is not an operative source of its displayed stock prices.

Automatic valuation considers role/capability, weapons, sensors, range, survivability, stealth/mobility, aviation hosting, and loadout content. Exact displayed values are build-dependent runtime results. Stage 5 will analyze the current campaign economy and observed/derived prices; Stage 4 establishes that cost is a property of the resolved base platform/loadout, not its nationality label or individual hull paint scheme unless an override changes its equipment/loadout.

### 9. Land-unit representation

Land-unit base files use `UnitType=LandUnit` and a subtype such as:

- `Airbase`
- `Port`
- `SAM`
- `AAA`
- `Radar`
- `MissileSite`
- `Installation`
- `MobileUnit`
- `Bridge`
- `OilRig`

Complex sites are assembled from multiple separate units. A Hawk battery, for example, uses radar, fire-control radar, and launcher types rather than a single indivisible object. Some convenience/site definitions and `.unitgroup` formations bundle these pieces for editing.

Airbases have `[AirGroup]`/`[FlightDeck]` support just like aviation ships. Ports are mainly world/target objects and do not by themselves implement strategic campaign resupply; campaign-node logistics fields control persistent-force repair/rearm/builder access.

Because land-unit variants are mostly undated, historically plausible selection requires external/date-aware review. Obvious post-1982 systems such as SA-10/SA-11, HMMWV, M2 Bradley, M270, or later refits must not be admitted merely because their variant metadata is blank.

### 10. Verified 1982 major-capability reference

This is a concise planning reference, not a complete list of every hull. “Available” means at least one numbered dated reference covers 1982 unless explicitly marked undated.

#### United States

| Domain | Strong 1982 options in the current database | Important limitations |
| --- | --- | --- |
| Carriers | `usn_cv_america_79`; `usn_cv_forrestal_75` (Forrestal/Saratoga/Ranger/Independence variants) | Nimitz and Kitty Hawk represented fits start in 1983; Enterprise represented fit ends in 1978. |
| Major combatants | Belknap, Leahy, California, Spruance, Adams, Coontz, Kidd, Garcia, Knox, Brooke, Oliver Hazard Perry; one 1982 Iowa/New Jersey variant | Ticonderoga and several later refit IDs are post-1982. Use numbered hull dates, not class-wide enablement. |
| Amphibious/logistics | Tarawa, Austin, Newport, Charleston, Kilauea, Sacramento, T2 oiler, early Algol variants | These provide convincing escalation/support forces, though task-force RAS is not a substitute for campaign rearm rules. |
| Submarines | Los Angeles early/Flight 1 hulls, Sturgeon, Permit, Skipjack; Lafayette/Madison/Franklin SSBNs | Strategic SSBNs are scenario assets rather than sensible player-builder purchases. |
| Carrier air | F-14A, A-6E, A-7E, E-2C, EA-6B, S-3A, SH-3H; F-4J remains represented for earlier/selected squadrons | F/A-18A is not date-valid in the database for 1982. RA-5C is not active by 1982. |
| Land-based air | F-15A/C, F-4D/E, B-52D/G, P-3C, C-141B, selected P-2H; AV-8A/C and AH-1T | The in-game `usaf_e-3a` nationality/date combination needs squadron-specific review; do not rely on the class-level handoff list alone. |
| Land | Hawk components, TPS-series/FPS radars, Nike Hercules, M60, M113, AAV-7, M109/M110, Vulcan and older AAA, generic bases/ports | Most are undated. Exclude clearly later HMMWV/Bradley/M270 and other anachronistic assets unless deliberately substituted. |

#### Soviet Union / Warsaw Pact

| Domain | Strong 1982 options in the current database | Important limitations |
| --- | --- | --- |
| Major surface forces | Kirov, Kresta I/II, Kynda, Kara, Kashin/modified Kashin, Kanin, Udaloy, Sovremenny, Krivak I/II, Grisha III, Nanuchka | Only one Slava reference begins in 1982. Exact hull/refit selection matters. |
| Aviation ships | Kiev, Moskva | `wp_cv_orel` is an alternate/prototype carrier representation beginning in 1982, not a safe historical default. |
| Amphibious/logistics | Alligator, Ropucha, Ivan Rogov, Don tender, Kazbek; many Soviet merchants usable as convoy hulls | Several landing/auxiliary metadata files are undated and need historical checking. |
| Submarines | Foxtrot, Romeo, Tango, Kilo; Alfa, November, Victor I/II/III; Charlie I/II, Echo II, Oscar I; Yankee and Delta III | Excellent coverage, but select hull dates and theater-appropriate boats. |
| Naval/strike air | Il-38, Tu-95RT, Tu-142M, Tu-16/Tu-16K/P/N, Tu-22M2, Su-24A/M, Yak-38, Ka-25/Ka-27, Mi-14 | The database supports a much richer Soviet force than either Britain or Argentina. |
| Fighters/interceptors | MiG-21, MiG-23 variants including 1982 MLD, MiG-25 variants, Su-15, MiG-27 | Squadron nation/date metadata must distinguish Soviet from export operators. |
| Land | SA-2/3/4/5/6/7/8/13 families, P-series radars, Redut/Rubezh coastal missiles, T-55/T-72/PT-76, 2S3, BM-21, airbases and ports | Land metadata is mostly undated; SA-10/SA-11 and other later systems require explicit exclusion for a strict 1982 campaign. |

#### Other NATO contributors with useful 1982 database coverage

| Country | Useful available types |
| --- | --- |
| Australia | Perth-class DDG, Adelaide short-hull FFG, Oberon submarine, F-111C, Mirage III, P-3C/P-2H metadata variants. |
| West Germany | Lütjens DDG, Type 148 Tiger missile boats, Type 205/206 submarines; generic NATO land defenses. |
| Norway | Oslo frigate, Sleipner corvette, Hauk/Snøgg missile boats, Kobben submarine, P-3C squadron. |
| France | Agosta and Daphné submarines plus limited aircraft/helicopter metadata; no broad French surface-fleet set. |
| Spain | Baleares frigate and Delfín submarine, plus NATO radars/AAA and TPS-43 variant. |
| Canada | Oberon submarine and limited maritime-air metadata. |
| Portugal | Albacora submarine and P-2H metadata. |
| Denmark | Two Type 205 submarine variants and generic NATO land defenses. |

NATO breadth is uneven: several allies have only submarines, small combatants, aircraft liveries, or generic land systems rather than complete national orders of battle.

#### United Kingdom

The current 1982 British combat-unit gap is severe:

- No date-valid 1982 Royal Navy surface combatant was found among numbered variants.
- The UK Z-class variant ends in 1969.
- No Royal Navy carrier, Type 42 destroyer, Type 21/22 frigate, County-class destroyer, nuclear submarine, Oberon, Sea Harrier, Vulcan, Nimrod, or period Royal Navy helicopter is represented as a UK unit.
- UK land metadata includes ports, generic NATO radars/AAA, Rapier, and some borrowed/generic equipment, but is mostly undated.
- Civil aircraft and merchant/fishing variants exist but do not solve the combat-order-of-battle gap.

This validates the decision to make the United States the primary playable faction and use available US/NATO substitutes.

#### Argentina

Only two Argentine-national metadata entries were found:

| Type | Reference | Metadata status |
| --- | --- | --- |
| `fr_mirage_iii` | `Squadron6` | `Nation=Argentina`, blank service date. Provides an Argentine Mirage III identity but requires historical/loadout validation. |
| `usa_radar_tps-43` | `Variant2` | `Nation=Argentina`, undated. |

No Argentine-national ship, submarine, helicopter, attack aircraft, transport aircraft, SAM, army unit, port, or airbase variant was found. Argentine forces will therefore require generic objects, nation overrides, carefully chosen foreign-base substitutes, or deliberately authored variants later. Creating new unit variants is possible in principle but expands scope and testing risk.

### 11. Limitations most relevant to the campaign

1. **British and Argentine coverage is not merely incomplete; it is structurally too sparse for a faithful bilateral Falklands campaign.** US playability and Soviet/NATO substitution are justified.
2. **The database date filter is fit-specific and sometimes historically surprising.** Nimitz is the clearest example: historically present, but the represented variant begins in 1983.
3. **Undated does not mean timeless.** This especially affects SAMs, radars, vehicles, and installations.
4. **Class presence does not guarantee the desired hull/refit.** Every roster entry needs reviewed `VariantN` values.
5. **Aircraft presence does not guarantee a nationally/date-correct squadron or suitable loadout.** Every squadron/loadout pairing needs review.
6. **Carrier presence does not guarantee a period-correct air wing.** Hull, squadron dates, supported types, capacity, and mission role must be validated together.
7. **Current costs are computed, not tabulated in the files.** Exact economic placement of carriers and escorts must be measured in Stage 5/current runtime rather than guessed from platform role.
8. **No exact Soviet strategic missile cargo object has yet been selected.** Mission 1 may use cargo-bearing merchants plus land-system narrative/mission targets rather than physically embarking a deployable SAM/SSM unit.

### 12. Stage 4 conclusion

The current database strongly supports a US-versus-Soviet 1982 escalation campaign with credible carrier aviation, escorts, submarines, bombers, maritime patrol aircraft, amphibious forces, auxiliaries, SAMs, radars, and convoy shipping. It weakly supports British and Argentine national forces.

The recommended unit-authoring policy is:

- reuse existing base definitions;
- whitelist explicit numbered 1982 variants/squadrons;
- keep undated land systems on a manually reviewed list;
- use US forces as the playable core;
- add Australian, West German, Norwegian, Spanish, French, Canadian, Portuguese, or Danish assets only when their exact metadata and gameplay role fit the escalation;
- reserve new national variants or custom cost overrides for later, only where substitutions are unacceptable.

Stage 4 is complete. The existing campaign economy and affordability curve remain reserved for Stage 5.

## Stage 5 — Existing campaign economy

### 1. Best comparison campaign

`Sea Power_Data\StreamingAssets\original\campaigns\pacific-strike-task-force\campaign.ini` is the closest existing match for the intended Falklands campaign. It is the only inspected original campaign built around a persistent, player-selected task force with computed point costs, a growing force cap, persistent damage/ammunition/losses, mission-specific repair and rearm access, awarded units, unlockable loadout tiers, and occasional detached-force missions. Its geography and 1984 order of battle are not reusable, but its economic structure is the correct template.

The campaign-level baseline is:

| Difficulty | Starting points | Starting cap | Completion reward multiplier | Aircraft treatment | Repair multiplier |
| --- | ---: | ---: | ---: | --- | ---: |
| Easy | 650 | 650 | 1.75 | ship air wing included | 0.75 |
| Moderate | 500 | 500 | 1.50 | ship air wing included | 1.00 |
| Difficult | 400 | 400 | 1.25 | ship air wing not included | 1.25 |

The unspecialized `[TaskForceMode]` defaults are `StartingPoints=500`, `PointCap=500`, and `CompletionPointRewardMultiplier=1`; the difficulty sections override them. `ShipIncludesAirwing=True` is present at the campaign default and on Easy/Moderate, while Difficult changes it to false. These settings are at `campaign.ini:33-40`, `:68-77`, `:81-90`, and `:94-103`.

Points and cap are different resources:

- completion points are spendable currency, multiplied by difficulty;
- completion cap points increase the maximum fielded force value and are not multiplied in the authored data;
- repair, replacement, loadout, and dismissal/refund rules can change the actual balance available at any moment;
- automatically granted units can raise the cap by their value, as the current UI explicitly states in `Sea Power_Data\StreamingAssets\original\language_en\ui.ini:3071`.

### 2. Mission-by-mission authored progression

The table below excludes slideshow, news, document, and scoreboard nodes and lists the 14 playable operations. “Full access” means builder, repair, and rearm are all enabled on that mission node. The cap column is the simple Moderate starting cap plus every preceding listed cap award; optional operations can expire and therefore make the actual route lower.

| Operation | Role | Builder | Repair | Rearm | Base reward | Cap increase | Maximum cumulative cap if all prior operations completed |
| --- | --- | --- | --- | --- | ---: | ---: | ---: |
| 01 Raid on Okinawa | main task force | yes | yes | yes | 100 | 100 | 600 |
| 02 Action in Taiwan Strait | main task force | yes | yes | yes | 100 | 100 | 700 |
| 03 Running Palawan | entire task force | yes | yes | yes | 120 | 100 | 800 |
| 03A Run Silent Run Deep | optional detached submarine | no | not granted | not granted | 50 | 50 | 850 |
| 03B Holding Lombok | optional single vessel | yes | yes | yes | 150 | 150 | 1,000 |
| 04 Sunda Strait | entire task force, continuity pressure | yes | no | no | 200 | 200 | 1,200 |
| 05 Strike on the Monster | selected force plus air wing | yes | yes | yes | 200 | 200 | 1,400 |
| 06 Raid on Lombok | selected force plus air wing | yes | yes | yes | 120 | 100 | 1,500 |
| 07 Action in Java Sea | selected force plus air wing | yes | no | no | 150 | 100 | 1,600 |
| 07A Hunt for the Cruiser | optional detached submarine | no | not granted | not granted | 100 | 100 | 1,700 |
| 08 Defense of North Borneo | selected force plus air wing | yes | yes | yes | 150 | 150 | 1,850 |
| 08A Pathfinders | optional detached submarine | no | not granted | not granted | 100 | 100 | 1,950 |
| 09 Shadows Off Palawan | selected force plus air wing | yes | yes | yes | 150 | 150 | 2,100 |
| 10 Vengeance at Luzon | selected force plus air wing | yes | no | no | 250 | 250 | 2,350 |

The ten numbered main operations alone add 1,450 cap, taking Moderate from 500 to 1,950. Completing all four optional operations adds another 400, for a theoretical authored maximum of 2,350. Easy follows the same increases from 650 and Difficult from 400. The playable nodes author 1,940 base reward points in total: 1,540 on the main operations and 400 on all optional operations. Before repairs, refunds, CSAR, or rounding, that corresponds to 3,395 Easy, 2,910 Moderate, or 2,425 Difficult reward points.

The economy is deliberately not a smooth fixed increment. Early main missions generally add 100 cap; decisive mid/late operations add 150-200; the finale adds 250. Optional submarine/single-ship operations are meaningful economic accelerators but expire (`ExpiresAfterMissionComplete`) if the player advances too far.

### 3. How quickly capability expands

The roster expands independently of the cap. Each mission supplies an explicit `TaskForceModeAllowedRosterUnits` list, so a platform must satisfy both gates:

1. it is authorized for that operation in the roster/mission allowlist; and
2. the selected force fits the current cap and available-points budget.

Pacific Strike introduces aircraft-bearing operations at Mission 05, opens the `Late` loadout tier through optional Mission 03B, introduces more expensive late-war escorts during Missions 05-09, and grants aircraft after Missions 04 and 09. This produces escalation through a combination of cap growth, free rewards, new loadouts, and broader allowlists rather than cap growth alone.

The current generated valuation cache is authoritative for this installed build:

- `C:\Users\User\AppData\LocalLow\Triassic Games\Sea Power\cache\pointvalues.csv`
- `C:\Users\User\AppData\LocalLow\Triassic Games\Sea Power\cache\taskforce_pointvalues.json`

Representative current base-platform values are:

| Platform | Current computed base cost |
| --- | ---: |
| Garcia frigate | 60 |
| Knox (1972) | 95 |
| Adams early | 190 |
| Skipjack SSN | 205 |
| Tarawa LHA | 222 |
| Kara | 276 |
| Forrestal (1975) | 284 |
| Enterprise | 290 |
| Mahan DDG | 309 |
| Belknap | 444 |
| Kitty Hawk | 455 |
| Leahy | 552 |
| Nimitz | 629 |
| Slava | 857 |
| Kirov | 1,108 |

Representative 1982 aircraft/loadout rows include `A-6E Combined@1982=90`, `F/A-18A Combined@1982=109` (though its database service date makes it unsuitable for our strict 1982 roster), `F-14A Combined=193`, `S-3A Combined@1982=78`, and base `E-2C=148`. These values are per resolved platform/loadout entry; squadron quantity and any purchased upgrades affect the force total.

The values are automatic and build-dependent. The current decompiled code uses `SeaPower.PointValueCalculator`, `PointValueRoleScorers`, `PointValueSensorScorer`, and `PointValueWeaponScorer`; current tuning includes a global scale of 1.2, ship multiplier 1.19, submarine multiplier 1.25, and formula version 134. The JSON cache separates base, variant, and loadout costs. Older campaign saves contain stored `BaseCostPerUnit`/`CostPerUnit` values and discounts, so they are useful persistence evidence but should not be treated as the current universal price list.

### 4. Carrier affordability is not demonstrated by Pacific Strike

Pacific Strike contains descriptive text for Tarawa and Kitty Hawk, but both entries are commented out in `player_task_force_roster.ini:33-34`:

```ini
#usn_lha_tarawa=Variant5
#usn_cv_kitty_hawk=Variant1,Variant2
```

Neither is offered by the mission allowlists. Therefore, **carriers never become purchasable in Pacific Strike**, regardless of accumulated cap. The current cache shows that a bare carrier hull may cost less than an early or mid-campaign cap, but that is not the cost of a credible carrier task force: fixed-wing aircraft, loadouts, escorts, and submarines add their own values, and availability must be explicitly unlocked. `ShipIncludesAirwing` also changes by difficulty. Exact affordability of a complete custom carrier package must be tested in the builder after our eventual roster is authored; static inspection does not establish one universal “full carrier group” price.

For the planned campaign this is useful rather than limiting: NATO escalation can be implemented as a deliberate late allowlist expansion plus an appropriate cap award. Merely raising the cap would not accidentally expose the carrier earlier.

### 5. Resupply operations versus continuation operations

Pacific Strike uses three distinct patterns.

#### Full logistics/reset opportunity

Nodes with all of the following provide the broad reset/reselection pattern:

```ini
TaskForceModeEnableTaskForceBuilder=True
TaskForceModeRepair=True
TaskForceModeRearm=True
```

The English rules text commonly says, “After this mission, your Task Force will be fully rearmed, with repair facilities and reinforcements available” (examples at `campaign.ini:239`, `:307`, `:707`, `:831`, `:1064`, and `:1229`). The builder permits purchase/reselection within the current allowlist and budgets; repair and rearm restore surviving persistent units according to campaign rules.

#### Continuation/resource-pressure operation

Missions 04, 07, and 10 set repair and rearm false while retaining the builder. Mission 03's text similarly warns that the force is operating away from facilities (`campaign.ini:400`). Mission 07 explicitly combines:

```ini
TaskForceModeRearm=False
TaskForceModeRepair=False
TaskForceModeEnableTaskForceBuilder=True
```

This does not erase persistence. Surviving units retain damage and expended stores; the player may have whatever limited reinforcement/reselection the allowlist, cap, and available points permit. Mission 09's localized rule is especially informative: no resupply or repair, but “Limited reinforcements will be available” (`campaign.ini:1430`). This is the closest existing analogue to the planned low/no-resupply Falklands legs.

#### Detached-force operation

Missions 03A, 07A, and 08A exclude the task force and air wing, include a submarine, and disable the builder. Optional Mission 03B instead allows exactly one vessel and says that selected ship is fully rearmed before entry (`campaign.ini:593`). These nodes let a small subset operate without committing or reconstructing the main force. Their expiration gates also prevent indefinite reward farming.

The localized `MissionResupplyRules_*` text is presentation, while the `TaskForceModeRepair`, `TaskForceModeRearm`, and builder flags are operational configuration. The text consistently describes whether access occurs during or after the operation, but exact UI transition timing should still receive one runtime confirmation when the custom skeleton exists.

### 6. Rewards, free units, and real cap behavior

Mission 04 grants five aircraft entries after completion, while Mission 09 grants another package. Automatically granted units are stored at zero purchase cost in inspected saves and can raise the cap by their own value. This means the simple cumulative table above is an **authored minimum/base curve**, not necessarily the exact cap displayed in a live save after grants, migration repairs, or version changes.

One inspected completed Pacific Strike save at `C:\Users\User\AppData\LocalLow\Triassic Games\Sea Power\saves\campaigns\linear_campaign_20260822T003146.sav` reports a cap above the simple authored maximum and contains point-system/granted-unit migration state. It confirms persistence, but it is a long-lived migrated save and is not a clean balance benchmark. A fresh campaign run is required for exact end-to-end accounting.

### 7. Economic model to carry forward

Confirmed lessons for the alternate-history campaign are:

- use Pacific Strike's separate spendable-points and force-cap tracks;
- gate escalation through both mission allowlists and cap awards;
- use full-logistics nodes for major theater reinforcement/reselection moments;
- use repair/rearm-off nodes to make prior damage and ammunition expenditure matter;
- use detached/subset nodes when only a few persistent units should participate;
- use rewarded units when the story mandates reinforcement without charging the player, remembering that grants can raise cap;
- measure prices from the generated cache/runtime for the exact selected variant and loadout;
- do not infer capability or price changes from a flag override alone. Relagged US/USSR stand-ins retain their underlying equipment, dates, loadouts, and computed value unless those are separately changed.

### 8. Stage 5 conclusion

Pacific Strike grows from a small 400/500/650-point force into a maximum authored cap of 2,250/2,350/2,500 when every optional operation is completed, before automatic-grant adjustments. Its main-route Moderate cap reaches 1,950; optional missions can lift it to 2,350. Growth is paced through 100-point early increases, larger decisive-operation awards, roster expansion, free aircraft, and alternating logistics access.

It remains the recommended economic and structural template. For our campaign, the essential adaptation will be to authorize a carrier and its air wing only at the intended NATO-escalation point, then size that mission's cap increase against the current cached cost of the complete package—not just the carrier hull.

Stage 5 is complete. Narrative implementation remains reserved for Stage 6.

## Stage 6 — Narrative system

### 1. Narrative is implemented in three layers

Sea Power does not have one monolithic campaign script or debrief file. The stock campaigns divide narrative between:

1. **Campaign timeline nodes** in `campaign.ini`: mission tiles, short introductions, logistics warnings, unlock notices, and standalone between-mission events.
2. **External XML/XAML presentation files**: newspapers, orders, intelligence reports, slideshows, maps, and dynamic campaign scoreboards.
3. **Mission-local language strings plus triggers** in each scenario INI: initial orders, tasking changes, warnings, objectives, victory messages, and defeat messages.

This division is important for authoring. A newspaper shown between operations is a campaign node; a commander message received after identifying a contact is a mission trigger action; a mission-selection synopsis is a campaign-node field; and a full two-pane briefing is an optional scenario-level XML facility.

### 2. Campaign selection text and pre-mission story

A playable `Type=Mission` node in Pacific Strike combines its scenario reference and progression rules with localized presentation fields. Mission 03B at `Sea Power_Data\StreamingAssets\original\campaigns\pacific-strike-task-force\campaign.ini:552-599` is a particularly complete example:

```ini
[Mission10]
Type=Mission
MissionFile=campaigns/pacific-strike-task-force/missions/03B Holding the Lombok Strait.ini
RequiredResult=CostlyVictory
Parents=8

Name_en=HOLDING THE LOMBOK STRAIT
MissionSequenceName_en=SIDE MISSION
MapShortName_en=03B
Description_en=Bali, Indonesia (Optional)
MissionImage_en=campaigns/pacific-strike-task-force/art/pacific_strike_03b_sheet.png
MissionIntro_en=OPTIONAL: Heavy enemy attacks ...
MissionResupplyRules_en=The ship selected ... will be fully rearmed ...
MissionSpecialNote_en=Note: this is an optional challenge mission ...
```

These fields have distinct UI jobs:

| Field | Purpose |
| --- | --- |
| `Name_<language>` | Displayed operation title. |
| `MissionSequenceName_<language>` | Main/side mission sequence label. |
| `MapShortName_<language>` | Compact campaign-map identifier. |
| `Description_<language>` | Short tile/location summary. |
| `MissionImage_<language>` | Mission sheet/tile illustration. |
| `MissionIntro_<language>` | Longer pre-launch operational situation and task. |
| `MissionResupplyRules_<language>` | Player-facing logistics/persistence warning. |
| `TaskForceModeBuilderSituation_<language>` | Context shown around force availability/reinforcement limits. |
| `MissionSpecialNote_<language>` | Highlighted exception such as detached force or unit limit. |
| `MissionSpecialNoteHighlightColor` | Presentation color for the special note. |
| `MissionWarningPopup_<language>` | Pipe-delimited confirmation shown for a deployment warning. |

Pacific Strike relies heavily on this campaign-facing briefing layer and on generated briefing-map symbols. Its scenario files do not use the older external `MissionBriefingLeftPane`/`RightPane` fields.

### 3. Full scenario briefing panes

The older `linear-campaign-proto-1` campaign demonstrates an additional, still-authored briefing system. `missions\01 Operation Shadow.ini:2-9` includes, per language:

```ini
[Language_en]
Name=01 Operation Shadow
Description=Soviet naval activity ...
MissionBriefingAssetsDirectory=campaigns\linear-campaign-proto-1\missions\01 Operation Shadow_Briefing
MissionBriefingLeftPane=...\BriefingText_en.xml
MissionBriefingRightPane=...\BriefingMap_en.xml
```

`BriefingText_en.xml` is a XAML `Grid` containing the formatted orders; `BriefingMap_en.xml` is a XAML `Viewbox`/`Canvas` containing maps, photographs, NTDS-style symbols, labels, and arrows. Images are resolved through bindings such as `{Binding Assets[Arctic_KirkenesNorth_Close]}` against the assets directory.

The mission editor UI confirms that the left pane is intended for mission briefing text, the right pane for the map, and “Expert Mode” accepts XAML (`Sea Power_Data\StreamingAssets\original\language_en\ui.ini:1324-1330`). Briefing-map content can also be generated from scenario map drawings; `VisibleIn=BriefingMap` controls which authored symbols appear there.

Therefore two briefing approaches coexist:

- **Pacific Strike/task-force approach:** campaign-node `MissionIntro`, image, special/logistics text, scenario start popup, and scenario map symbols.
- **Prototype/hand-authored approach:** external left/right XAML briefing panes plus the scenario start popup.

The external panes are optional in the sense that Pacific Strike missions function without them. For our campaign, the Pacific Strike approach is the lower-risk baseline; full two-pane XAML briefings can be added selectively where a detailed operations order materially helps.

### 4. Newspapers and between-mission events

Pacific Strike implements newspapers, intelligence reports, logistics advisories, slideshows, and its final combat record as `Type=FreeEvent` nodes in the same numbered `[MissionN]` timeline as playable scenarios. For example, `campaign.ini:157-168` contains:

```ini
[Mission2]
Type=FreeEvent
IsUnlocked=False
IsComplete=False
Parents=1

Name_en=Breaking News\n26 June 1985
Description_en=Soviets strike! War in Europe and the Pacific!
AssetsPath_en=campaigns/pacific-strike-task-force/art
FilePath_en=campaigns/pacific-strike-task-force/art/19850626_breakingnews_event.xml
TileImagePath_en=campaigns/pacific-strike-task-force/art/bkg_tile_newspaper.png
```

The operational contract is:

- `Type=FreeEvent` tells the campaign to open authored presentation content rather than launch a scenario.
- `Parents` places the event in progression exactly like a mission node.
- `Name` and `Description` provide campaign-map/tile copy.
- `FilePath` points to the XML/XAML document to render.
- `AssetsPath` establishes the image-resource folder used by `{Binding Assets[...]}`.
- `TileImagePath` provides the campaign-map tile appearance and is commonly either a newspaper or message background.
- `UseAuthoredNavigation=True` is used on multi-page authored sequences such as the opening slideshow and final combat-record sequence; XML buttons call `OpenFileCommand` with the next/previous XML path.

Although the parser recognizes a `NewspaperEvent` node type (confirmed during Stage 2), current stock authored campaigns mainly use `FreeEvent` for newspaper content. Newspaper identity is therefore primarily conveyed by its XAML layout and tile art, not by requiring a special newspaper node type.

#### Newspaper example

`art\19850626_newspaper_event.xml` explicitly calls itself the standard linear-campaign newspaper setup. It uses a WPF-style `Page`, `Viewbox`, newsprint `Border`, columns and rows, `TextBlock` headlines/body copy, and bound images. Its header comment instructs translators to create language-specific XML and link those paths from `campaign.ini`.

#### Military-document example

`art\19850709_jcs_sitrep_palawan.xml` is a scrollable JCS message. It uses a paper image brush, monospaced text, message-routing fields, classification markings, and numbered narrative paragraphs. The campaign node at `campaign.ini:463-473` attaches it as another `FreeEvent`; no special “document” type is required.

#### Slideshow and dynamic ending

`art\s01_window_1.xml` implements page 1 of a seven-page introduction. Its next button binds `OpenFileCommand` to `s01_window_2.xml`. The final `event_task_force_77_combat_record.xml` goes further: it binds live persistent data such as task-force name, sink counts, surviving surface units, squadrons, proficiency, and battle stars. Thus free-event XAML is capable of both static story presentation and a save-dependent campaign epilogue.

### 5. Mission start messages and in-mission narrative

Scenario narrative strings live inside localized `[Language_<code>]` sections. The key name is arbitrary but must match the trigger action that references it. In `missions\02 Action in the Taiwan Strait.ini:18`, `Taskforce1StartMessage` is a structured intro popup. Trigger 1 fires it after five seconds:

```ini
[Trigger1]
Condition_Condition1_Type=Time
Condition_Condition1_Time=5
ConditionsCompleted=<Condition1>
Action_Taskforce1_Message=Taskforce1StartMessage
```

Current files demonstrate two compatible message encodings:

1. **Legacy compact encoding:** `Title|Body|Button text`, with `\n` line breaks and supported rich-text tags such as `<size=20>`.
2. **Rich key/value encoding:** embedded fields such as `From=`, `To=`, `Subj=`, `Precedence=`, `Classification=`, `Template=`, `Body=`, `ButtonText=`, `PopupStyle=`, and optional `MessageRole=`.

The Taiwan Strait example uses:

```ini
Taskforce1Landingforcedestroyed-playervictoryMessage=
From=CTF 77
To={TaskForceName}
Subj=RECON REPORT-MISSION ACCOMPLISHED
Precedence=Immediate
Classification=Secret
Template=USAUSNavy
Body=...
ButtonText=Continue playing
PopupStyle=NavalMessage
MessageRole=Outro
```

The files support runtime substitutions including `{TaskForceName}` and `{FlagshipName}`. `PopupStyle=Intro`, `Outro`, and `NavalMessage` select presentation. `MessageRole=Outro` explicitly marks rich victory/defeat traffic as result-oriented presentation. Ordinary warnings omit the outro role and allow play to continue.

Triggers may also update the intelligence/tasking panel without a popup through `Action_Taskforce1_Intel=<localized key>`. Operation Shadow demonstrates a mid-mission political escalation: a triggered message announces that the ship seizure has invoked Article 5, while the paired intel text and objective actions change the player's tasking. This is directly relevant to our planned NATO escalation, although the campaign-level unit unlock must remain a campaign progression reward rather than merely narrative text.

### 6. Objectives, victory/defeat text, and debrief behavior

Objectives have two linked definitions:

1. A localized label such as `Objective_DestroyInvasionForce=Destroy PLA landing force...` in `[Language_en]`.
2. A mechanical row under `[Taskforce1_Objectives]`, for example `DestroyInvasionForce=50,-50,Complete,Main`.

Triggers then change objective and mission state. The Taiwan Strait victory trigger at lines 653-660 sends the victory message, declares `Action_Victory=Taskforce1`, and completes both objectives. Its defeat trigger sends a different message, declares Taskforce 2 victorious, fails the main objective, cancels the survival objective, and ends the mission.

There is no separate universal prose `[Debriefing]` section in these examples. What the player experiences as mission-result/debrief narrative is assembled from:

- the trigger-selected victory or defeat popup;
- objective completion/failure/cancellation state;
- the scenario's declared victorious task force and resulting score category;
- campaign progression checking `RequiredResult`;
- optional task-force debrief notices authored on the campaign node;
- any subsequently unlocked newspaper/document `FreeEvent` node.

This permits different defeat causes to have different text. Taiwan Strait distinguishes loss of the flagship from the invasion force reaching Dongyin. Operation Shadow distinguishes destruction of the player submarines from accidental destruction of the protected US auxiliary. Each terminal trigger references its own localized message key.

`TaskForceModeDebriefNoticeTitle_<language>` and `TaskForceModeDebriefNoticeText_<language>` are campaign-specific post-result notices rather than the scenario's dramatic victory prose. Pacific Strike uses them after Mission 03B to announce enhanced loadouts (`campaign.ini:598-599`) and after Mission 04 to announce air-wing operations (`campaign.ini:708-709`).

### 7. Localization and fallback considerations

Campaign nodes suffix presentation fields with language codes (`_en`, `_de`, `_ru`, `_ja`, and others). Scenario files instead repeat the same unsuffixed keys inside `[Language_en]`, `[Language_de]`, etc. External XML content generally has one file per language, and `campaign.ini` or the scenario language section points to the appropriate file.

Stock content is not perfectly uniform: some languages reuse an English XML, some localized fields are absent, and legacy messages use pipe encoding while newer English messages use rich key/value encoding. For a new campaign, English should be complete and self-contained first. Other languages should not be declared until their referenced files and strings exist; invented partial localization creates more failure modes than relying on verified fallback behavior.

### 8. Mandatory, optional, and inferred narrative fields

#### Confirmed necessary for a narrative node intended to render

- A numbered `[MissionN]` entry included in `NumberOfMissions`.
- `Type=FreeEvent` for an external story/document node.
- Valid progression state (`IsUnlocked`, `IsComplete`, and normally `Parents`, except an initially unlocked root).
- A valid `FilePath_<language>` to render authored content.
- A matching `AssetsPath_<language>` whenever the XML uses bound assets.

#### Confirmed necessary for trigger-driven scenario text

- A localized message key in the active language section.
- An `Action_TaskforceN_Message` referencing that exact key.
- A reachable trigger with valid conditions.
- For localized objective display, an `Objective_<id>` label matching the objective ID in `[TaskforceN_Objectives]`.

#### Optional/presentation fields

- Campaign `Name`, `Description`, `TileImagePath`, and custom mission images improve timeline presentation.
- `MissionIntro`, logistics rules, builder situation, special note, warning popup, and debrief notice fields apply only when the associated UI feature is wanted.
- Scenario `MissionBriefingAssetsDirectory` and left/right pane XML are optional; Pacific Strike does not use them.
- `UseAuthoredNavigation` is needed for custom multi-page navigation, not ordinary single-page events.
- Rich message metadata such as routing, precedence, classification, template, popup style, and role is optional relative to a legacy `Title|Body|Button` message.

#### Strong inference / runtime check still warranted

- English fallback behavior exists in parts of the parser, but the exact fallback order for every campaign field and missing external XML path should be tested.
- The precise moment a task-force debrief notice appears relative to reward application and the newly unlocked `FreeEvent` should be verified in one clean run.
- Custom XAML supports extensive WPF-like controls and game data bindings, but arbitrary control/binding availability is constrained by the game's loader; new layouts should begin from a proven stock template.

### 9. Narrative architecture recommended for the Falklands campaign

The proven low-risk pattern is:

- one opening authored-navigation slideshow establishing the Argentine-Soviet pact and US political dilemma;
- `FreeEvent` newspaper pages for major public geopolitical changes;
- JCS, State Department, CIA, NATO, and naval-message documents for classified between-mission developments;
- concise campaign-node `MissionIntro`, resupply rules, and special notes on every operation;
- a scenario start message for immediate tactical orders;
- trigger-driven warnings and tasking changes during the mission;
- separate victory and each materially different defeat message;
- debrief notices only for mechanical unlocks such as new NATO availability or loadout tiers;
- a final dynamic or static campaign record/epilogue.

For Article 5 specifically, Operation Shadow provides a strong story model: a mid-mission incident can announce the political threshold through a triggered message and new tasking, followed by a campaign-node news/JCS event and actual NATO roster unlock in progression data after mission completion.

### 10. Stage 6 conclusion

Pacific Strike remains the best primary narrative template because it demonstrates an integrated timeline of missions, newspapers, intelligence documents, logistics advisories, unlock notices, an authored slideshow, and a persistent-data ending. `linear-campaign-proto-1` should be retained as the secondary template for optional two-pane XAML briefings and for Operation Shadow's Article 5 tasking-change example.

Stage 6 is complete. Risks, confidence levels, and runtime-test unknowns remain reserved for Stage 7.
