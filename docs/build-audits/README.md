# Build Audits

One audit records the compatibility delta between the prior documented baseline and a new game build. Audits are append-only history; later audits supersede facts but do not erase what was true earlier.

Each audit should record:

- exact build identifiers and install paths inspected;
- changelog entries relevant to authoring;
- added, removed, and changed campaign/mission/unit files;
- new and removed INI keys in active examples;
- assembly type/method/constant changes where useful;
- point-formula and cache compatibility;
- documentation pages updated;
- runtime tests invalidated or newly required;
- unresolved questions.

Current audit: [0.8.2 Build #366](0.8.2-build-366.md).
