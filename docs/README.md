# Sea Power Campaign Authoring Manual

## Purpose

This manual describes the installed game's campaign, mission, unit, narrative, economy, and persistence systems without tying the findings to one campaign premise. It is designed to survive game updates: stable architecture lives in topic manuals, while build-sensitive facts live in dated audits.

## Validation baseline

| Item | Value |
| --- | --- |
| Current static baseline | 0.8.2 Build #366 (23810), dated 2026-09-06 |
| Previous runtime baseline | 0.8.2 Build #363 (23607), dated 2026-08-04 |
| Current point formula | 140, confirmed by reflection of `SeaPower.PointValueTuning` |
| Previous point formula | 134 |
| Primary task-force example | `pacific-strike-task-force` |
| Primary minimal/topology example | `linear-campaign-proto-1` |
| Current runtime status | #366 static inspection complete for documented deltas; targeted runtime regression tests remain |

## Evidence labels

Every behavioral assertion should carry one of these labels when its confidence is not obvious:

| Label | Meaning |
| --- | --- |
| **CF** — confirmed in files | Present in a shipped or project-authored file; proves syntax or usage, not necessarily every runtime edge case |
| **CC** — confirmed in code | Present in the active managed assembly through reflection/decompilation |
| **CR** — confirmed at runtime | Directly observed in the stated game build |
| **SI** — strong inference | Multiple sources agree, but the exact behavior has not been isolated at runtime |
| **U** — unknown | Requires a focused runtime test or clearer implementation evidence |

Build labels are part of the evidence. A #363 runtime result is not silently promoted to #366 when that subsystem changed.

## Manual map

### Architecture

- [Campaign system](architecture/campaign-system.md)
- [Mission system](architecture/mission-system.md)
- [Persistence and Task Force Mode](architecture/persistence-and-task-forces.md)
- [Scripting and triggers](architecture/scripting-and-triggers.md)
- [Narrative and localization](architecture/narrative-and-localization.md)
- [Units, loadouts, and costs](architecture/units-loadouts-and-costs.md)

### Reference

- [File-location map](reference/file-location-map.md)
- [Campaign fields](reference/campaign-fields.md)
- [Mission fields](reference/mission-fields.md)
- [Dynamic unit generation](reference/dynamic-generation.md)

### Examples and procedures

- [Pacific Strike task-force example](examples/pacific-strike-task-force.md)
- [Build audits](build-audits/README.md)
- [New-campaign checklist](workflows/new-campaign-checklist.md)
- [Build-update audit workflow](workflows/build-update-audit.md)
- [Runtime test matrix](workflows/runtime-test-matrix.md)

### Project-specific material

- [Falklands 1982 project notes](projects/falklands-1982-notes.md)
- [`CAMPAIGN_DESIGN.md`](CAMPAIGN_DESIGN.md), [`CAMPAIGN_ECONOMY.md`](CAMPAIGN_ECONOMY.md), [`UNIT_ROSTER.md`](UNIT_ROSTER.md), and [`TEST_MATRIX.md`](TEST_MATRIX.md) remain project ledgers.
- [`FALKLANDS_CAMPAIGN_RESEARCH.md`](FALKLANDS_CAMPAIGN_RESEARCH.md) is the detailed legacy reconnaissance record. Its general findings are being normalized into this manual; build-sensitive statements retain their original context.

## Maintenance rule

For each game update:

1. preserve the prior audit;
2. compare the new installation with the last baseline;
3. record changes in a new `build-audits/` document;
4. update stable manuals only where behavior or syntax actually changed;
5. regenerate local-only inventories and point caches;
6. rerun affected runtime tests;
7. never commit copied stock content or user saves.
