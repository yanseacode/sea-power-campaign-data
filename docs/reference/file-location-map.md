# File-Location Map

Paths are relative to the game installation unless stated otherwise. `original` is read-only reference content; authored content belongs in `user`.

| Location | Contents and authoring relevance |
| --- | --- |
| `changelog.txt` | Authoritative human-readable build number and feature/fix history |
| `Sea Power_Data/Managed/Seapower-Scripts.dll` | Active managed implementation for campaign, mission, UI, point, save, and generator behavior |
| `Sea Power_Data/StreamingAssets/original/campaigns/` | Stock campaign definitions, campaign-local missions, rosters, narrative art, and localization |
| `.../campaigns/pacific-strike-task-force/` | Best current example for persistent task forces, economy, logistics, awards, air tasking, and #366 dynamic theater generation |
| `.../campaigns/linear-campaign-proto-1/` | Useful topology and external briefing examples; prototype status means fields must be cross-checked |
| `.../missions/` | Standalone scenarios, tutorial missions, and `Demo/MissionFileInformation.ini` field comments |
| `.../vessels/` | Ship and submarine class definitions plus companion variant files |
| `.../aircraft/` | Aircraft/helicopter definitions and squadron files |
| `.../land_units/` | Airbases, ports, radar/SAM sites, launchers, vehicles, buildings, and infrastructure |
| `.../ammunition/` | Missiles, bombs, torpedoes, shells, stores, tanks, pods, and decoys |
| `.../systems/` | Shared sensors, weapons, and combat-system data |
| `.../formations/` | Reusable formations and station geometry |
| `.../scripts/` | Shipped scripting support and examples |
| `.../documentation/` | Shipped author/developer reference material |
| `.../templates/` | Editor/content templates |
| `.../language_*/` | Global localized strings |
| `Sea Power_Data/StreamingAssets/user/campaigns/<id>/` | Safe deployment destination for an authored custom campaign |
| `%USERPROFILE%/AppData/LocalLow/Triassic Games/Sea Power/saves/campaigns/` | Runtime campaign saves; inspect copies and do not commit them |

## Search order

When investigating a field:

1. search current stock campaigns and missions for active examples;
2. check `MissionFileInformation.ini` and shipped documentation;
3. inspect the current managed assembly;
4. compare the previous build;
5. perform a minimal runtime test;
6. record both the evidence type and build.
