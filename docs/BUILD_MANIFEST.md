# Build Manifest

| Item | Current value | Evidence/status |
| --- | --- | --- |
| Campaign project ID | TBD before real campaign implementation | Do not reuse disposable test ID |
| Disposable test campaign ID | `falklands-infrastructure-test` | Reserved for Milestones A and B only |
| Current game build/version | 0.8.2 Build #363 (23607), 2026-08-04 | Installed `changelog.txt` |
| Point formula version | 134 | Current research/decompiled implementation |
| Repository source path | `E:\Games\Sea_Power_BETA\Sea Power\sea-power-falklands-1982` | Git source of truth |
| Authored campaign source | `mod\campaigns\falklands-infrastructure-test` | Created during Milestone A |
| Deployment destination | `E:\Games\Sea_Power_BETA\Sea Power\Sea Power_Data\StreamingAssets\user\campaigns\falklands-infrastructure-test` | Exact disposable destination |
| Supported languages | English only | Additional languages are not declared |
| Primary stock reference | `pacific-strike-task-force` | Task-force persistence/economy/narrative structure |
| Secondary stock references | `linear-campaign-proto-1`; `strike-group-molniya-campaign` / Operation Shadow | Minimal XAML/topology and compact narrative/Article 5 patterns |
| Save path | `C:\Users\User\AppData\LocalLow\Triassic Games\Sea Power\saves\campaigns` | Confirm exact created filename during runtime test |
| Deployment method | Project-owned PowerShell deployment tool; exact copy only | To be implemented in Milestone A |

## Known compatibility warnings

- Sea Power is under active development; parser behavior, generated saves, point formula, and cache format may change.
- The game’s user data advertises Steam Cloud synchronization. Deployed content is disposable and never the source of truth.
- Campaign discovery, campaign-local `_info.ini`, restart requirements, metadata hot reload, English fallback, and save naming are not yet runtime-confirmed for this authored campaign.
- Formula 134 costs are build-dependent and must be regenerated after a build/formula change.
- Never deploy to or modify `Sea Power_Data\StreamingAssets\original`.

