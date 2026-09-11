# Sea Power Campaign Authoring Research

Reusable, evidence-led documentation for building and maintaining custom campaigns for *Sea Power*. The repository also contains a disposable runtime laboratory and separate design notes for an alternate-history Falklands project.

## Start here

- [`docs/README.md`](docs/README.md) — documentation map, evidence standard, and current build baseline
- [`docs/architecture/campaign-system.md`](docs/architecture/campaign-system.md) — campaign topology and progression
- [`docs/architecture/mission-system.md`](docs/architecture/mission-system.md) — tactical scenario structure
- [`docs/architecture/persistence-and-task-forces.md`](docs/architecture/persistence-and-task-forces.md) — force selection, economy, logistics, and carry-over
- [`docs/reference/campaign-fields.md`](docs/reference/campaign-fields.md) — campaign field reference
- [`docs/reference/mission-fields.md`](docs/reference/mission-fields.md) — mission field reference
- [`docs/build-audits/0.8.2-build-366.md`](docs/build-audits/0.8.2-build-366.md) — current #363 to #366 compatibility audit

## Repository areas

- `docs/architecture/` — reusable system explanations
- `docs/reference/` — field and filesystem references
- `docs/examples/` — annotated stock implementations; no stock files are redistributed
- `docs/build-audits/` — version-to-version change records
- `docs/workflows/` — authoring, testing, and update procedures
- `docs/projects/` and the older project ledgers — campaign-specific material
- `mod/` — original disposable campaign laboratory; not a production campaign
- `tools/` — project-authored deployment and validation utilities

## Repository policy

- Original game executables, assemblies, assets, campaigns, missions, unit definitions, localization, caches, and saves are not committed.
- Installed `StreamingAssets/original` content is a read-only reference.
- Small field excerpts may be quoted to explain a format; full shipped files and bulk extracted databases are excluded.
- Authored mods deploy only beneath `StreamingAssets/user`; the repository remains the source of truth.

## Current status

The reusable manual is validated statically against 0.8.2 Build #366 (23810). Runtime observations from Build #363 are retained with their original build label and require targeted revalidation where #364–#366 changed the relevant subsystem. No production campaign has been implemented.
