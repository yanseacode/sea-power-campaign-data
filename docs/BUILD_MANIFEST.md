# Build Manifest

| Item | Current value | Evidence/status |
| --- | --- | --- |
| Campaign project ID | TBD before real campaign implementation | Do not reuse disposable test ID |
| Disposable test campaign ID | `falklands-infrastructure-test` | Reserved for Milestones A and B only |
| Current static game baseline | 0.8.2 Build #366 (23810), 2026-09-06 | Read-only inspection of the new installation and `changelog.txt` |
| Last project runtime baseline | 0.8.2 Build #363 (23607), 2026-08-04 | Disposable campaign laboratory results |
| Point formula version | 140 current; 134 for existing price snapshots | Reflected `SeaPower.PointValueTuning`; recapture #366 prices before balancing |
| Repository source path | `E:\Games\Sea_Power_BETA\Sea Power\sea-power-falklands-1982` | Git source of truth |
| Authored campaign source | `mod\campaigns\falklands-infrastructure-test` | Created during Milestone A |
| Deployment destination | `E:\Games\Sea_Power_BETA\Sea Power\Sea Power_Data\StreamingAssets\user\campaigns\falklands-infrastructure-test` | Exact disposable destination |
| Supported languages | English only | Additional languages are not declared |
| Primary stock reference | `pacific-strike-task-force` | Task-force persistence/economy/narrative structure |
| Secondary stock references | `linear-campaign-proto-1`; `strike-group-molniya-campaign` / Operation Shadow | Minimal XAML/topology and compact narrative/Article 5 patterns |
| Save path | `C:\Users\User\AppData\LocalLow\Triassic Games\Sea Power\saves\campaigns` | Milestone saves confirmed through `Falklands Milestone B - Post B2.sav` |
| Deployment method | `tools\Deploy-TestCampaign.ps1`; exact allowlisted campaign tree with dry-run and exact-folder undeploy | Proven in Milestone A |

## Known compatibility warnings

- Sea Power is under active development; parser behavior, generated saves, point formula, and cache format may change.
- The game’s user data advertises Steam Cloud synchronization. Deployed content is disposable and never the source of truth.
- Build 0.8.2 discovers a newly deployed campaign after leaving and reopening the Campaigns list; a full application restart is not required. Campaign title changes hot-reload on the same refresh.
- A campaign-local `_info.ini` is not required for this tested linear Task Force Mode layout.
- English-only FreeEvent content renders under the tested English UI. Other UI-language fallback remains untested.
- Task Force Mode launch requires `CommanderSettingsFile` to resolve to a file containing at least one `CommanderNations` value and the corresponding `[OfficerRanks]` entry. Missing commander configuration produces a blocking “COMMANDER REQUIRED” dialog and an empty Service Record nation selector. Treat this as a mandatory preflight check for every future task-force campaign and laboratory.
- Formula 134 costs are historical and must be regenerated under formula 140 before current balancing. Build #366 also corrected optional-weapon, weapon-swap, manual-price-scaling, and stores pricing paths.
- Build #366 adds dynamic theater generation, year-based loadout progression, Air Operations editing, and campaign/save fixes. See `build-audits/0.8.2-build-366.md`; affected #363 runtime results remain labeled rather than assumed current.
- A node allowlist did not exclude an already-owned persistent ship from automatic deployment when the builder was disabled. Use it to curate builder choices, not as the sole owned-unit deployment restriction.
- Builder, repair, and rearm are independent controls. Repair is a paid per-ship action; rearm is automatic at an enabled node and displays a per-ship `Rearmed` badge.
- Multiple purchasable hulls of one class require distinct available variants in the tested builder; each owned variant's purchase row becomes unavailable.
- Restrict deployed surface-force size with `TaskForceModeRequiredUnitType=Vessel` and `TaskForceModeMaxUnits=<count>`; stock UI behavior is confirmed at limits of one and three. Do not substitute an allowlist for this quantity control.
- Cross-mission tactical consequences use persistent variables: later missions can reveal targets or suppress unit spawns based on earlier optional outcomes.
- Never deploy to or modify `Sea Power_Data\StreamingAssets\original`.

## Milestone A proven layout

```text
StreamingAssets/user/campaigns/falklands-infrastructure-test/
├── campaign.ini
├── commander_settings.ini
├── player_task_force_roster.ini
├── art/
│   └── infrastructure_test.xml
└── missions/
    └── 01 Infrastructure Smoke Test.ini
```

No campaign-local `_info.ini` or custom art was required.

## Task Force Mode preflight

Before every new task-force test campaign is deployed, verify:

- `[TaskForceMode] Enabled=True`;
- `RosterFile` exists and contains the mission's allowed units;
- `CommanderSettingsFile` exists;
- `[CommanderSettings] CommanderNations` contains at least one nation;
- the default commander nation is in that list;
- `[OfficerRanks]` contains an entry for every selectable nation;
- the initial points/cap can purchase the intended test force;
- every playable node explicitly defines builder, repair, rearm, generation, and included-force behavior.
