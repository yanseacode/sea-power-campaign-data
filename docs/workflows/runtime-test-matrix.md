# Reusable Runtime Test Matrix

Project-specific results remain in [`../TEST_MATRIX.md`](../TEST_MATRIX.md). This page defines the reusable minimum matrix.

| Laboratory | Proves | Repeat after |
| --- | --- | --- |
| Discovery smoke test | user-path discovery, title, tile, language fallback | content-loader or mod-manager changes |
| One-node campaign | launch, tactical result, completion, return, save | campaign/save changes |
| Two-node persistence | damage, stores, losses, selected subset, undeployed force | Task Force/save/logistics changes |
| Economy test | formula price, authored overrides, rewards, cap, repair/refund | formula, unit, stores, or difficulty changes |
| Loadout-gate test | named unlock, date ceiling, unit/loadout-year reward | loadout/year-rule changes |
| Branch test | parents, joins, expiry, retry, forced open | campaign topology changes |
| Variable test | mission write, later node/mission read, false fallback | trigger/save changes |
| Narrative test | briefing, FreeEvent, newspaper, debrief, language | UI/localization changes |
| Carrier/airbase test | air group, deck losses, recovery, rearm, persistence | aviation/save changes |
| Air Operation test | schedule, advanced waypoints, trigger control, save/load | route/editor changes |
| Dynamic-theater test | selection, persistent kills, encounters, formation scale, seed | generator changes |
| Doctrine/EMCON test | global/formation/unit overrides and save/load | Standing Orders changes |

For each test record the exact build, campaign source commit, save name, expected result, observed result, and whether the observation confirms files, code, or runtime behavior.
