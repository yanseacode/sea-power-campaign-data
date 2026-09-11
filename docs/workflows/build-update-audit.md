# Build-Update Audit Workflow

## Inputs

- previous documented installation;
- new installation;
- both changelogs;
- documentation repository;
- local runtime saves/caches only when safe and necessary.

## Static pass

1. Record exact build identifiers and dates.
2. Read only changelog entries newer than the previous baseline.
3. Compare relative file lists for campaigns, missions, units, ammunition, systems, formations, scripts, templates, documentation, and localization.
4. Hash common files to identify actual content changes.
5. Compare active stock campaign INI key sets and representative field values.
6. Inspect new/removed unit references and renamed IDs.
7. Compare `Seapower-Scripts.dll` metadata and relevant classes/constants.
8. Record uncertainties rather than inferring serialized syntax from internal names.

## Documentation pass

1. Create `build-audits/<version>.md`.
2. Mark invalidated numerical snapshots and runtime evidence.
3. Update architecture only for confirmed semantic changes.
4. Update field references only for demonstrated authoring keys.
5. Update examples when stock campaigns change their implementation pattern.
6. Move scenario-specific implications to project notes.

## Runtime pass

Rerun the smallest tests covering each changed subsystem. Prefer disposable laboratories over a real campaign save. Capture build, inputs, expected behavior, actual behavior, and artifact paths. Do not overwrite useful saves.

## Completion gate

An update is documented only when:

- current and previous baselines are explicit;
- changed claims have evidence labels;
- stale prices are not presented as current;
- affected runtime tests are listed as passed or pending;
- links resolve;
- no copyrighted stock files or personal save data entered Git.
