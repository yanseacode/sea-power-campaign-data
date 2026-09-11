# Campaign Economy Ledger

## Status

Campaign-specific values remain TBD until the Mission 1 roster is reviewed. Runtime laboratory values will be recorded as evidence, not silently promoted into campaign balance decisions.

> Build warning: every listed numerical unit-price snapshot was captured under point formula 134 on Build #363. Build #366 uses formula 140 and corrected optional-weapon, weapon-swap, manual-price-scaling, and stores pricing. These snapshots are historical evidence only until recaptured; see [`build-audits/0.8.2-build-366.md`](build-audits/0.8.2-build-366.md).

## Global assumptions

| Item | Pacific Strike reference | Falklands campaign |
| --- | --- | --- |
| Starting points | Easy 650; Moderate 500; Difficult 400 | TBD |
| Starting force cap | Easy 650; Moderate 500; Difficult 400 | TBD |
| Completion point multiplier | Easy 1.75; Moderate 1.50; Difficult 1.25 | TBD |
| Repair multiplier | Easy 0.75; Moderate 1.00; Difficult 1.25 | TBD |
| Decommission refund | Easy 0.35; Moderate 0.25; Difficult 0.15 | TBD |
| Dismiss refund | Easy 0.65; Moderate 0.50; Difficult 0.35 | TBD |
| Repair eligibility/cost | Light 10%, Moderate 25%, Heavy disallowed before difficulty multiplier | TBD |
| Ship air wing included | Easy/Moderate true; Difficult false | TBD |
| Point formula/build | Formula 134; game 0.8.2 Build #363 (23607) | Re-measure on implementation build |

Reference mechanics: completion points are spendable currency and receive the difficulty multiplier; completion cap points increase deployment cap without that multiplier. Builder availability and mission allowlists are separate gates. Granted units may be zero-cost and may increase cap by their value; this requires a fresh-save runtime check.

## Operation economy table

The ledger will contain every playable main and optional operation. Narrative-only nodes receive rows only if they apply a mechanical change. The campaign is no longer constrained to exactly ten playable missions.

| Operation ID | Route role | Starting cap | Starting spendable points | Minimum viable force | Comfortable force | Aspirational force | Completion points | Cap increase | Other reward/unlock | Logistics state | Main-route balance note |
| --- | --- | ---: | ---: | --- | --- | --- | ---: | ---: | --- | --- | --- |
| M1 | Main | TBD | TBD | TBD after roster selection | TBD | TBD | TBD | TBD | TBD | TBD | No carrier |
| Future main operation | Main | TBD | TBD | TBD | TBD | TBD | TBD | TBD | TBD | TBD | Required-route economy must remain viable without optional rewards |
| Future optional operation | Optional/lettered | Inherited/TBD | Inherited/TBD | Force-limited package TBD | TBD | TBD | TBD | TBD | Persistent advantage and/or unlock TBD | TBD | Benefit adds flexibility but cannot be required for main-route viability |
| Final carrier-phase operation | Main | TBD | TBD | Complete carrier package TBD | TBD | TBD | TBD | TBD | Carrier roster/loadout tier already unlocked | TBD | Full carrier task force must be viable |

## Carrier target

Measure the complete package on each supported difficulty; hull cost alone is not an affordability target.

| Component | Selected reference | Quantity/loadout | Measured cost | Status |
| --- | --- | --- | ---: | --- |
| Carrier hull | TBD | TBD | TBD | Candidate fits: `usn_cv_america_79` or `usn_cv_forrestal_75` |
| Carrier air wing | TBD | TBD | TBD | Include fighter, strike, AEW, ASW, EW, and helicopter needs as selected |
| AAW escorts | TBD | TBD | TBD | |
| ASW escorts | TBD | TBD | TBD | |
| Submarine | TBD | TBD | TBD | |
| Support/logistics | TBD | TBD | TBD | |
| Desired optional margin | N/A | N/A | TBD | Optional content should add flexibility, not gate viability |

## Point-cost snapshot

- Game version: 0.8.2 Build #363 (23607), dated 2026-08-04 in the installed changelog.
- Point formula version: 134, as established by current research/decompiled implementation.
- Extraction date: 2026-08-25.
- Source: local generated point cache; cache itself is not committed.
- Scope: selected campaign candidates only. Values below are base-platform or specifically named loadout rows where stated; they are not complete task-force package prices.

| Relevant candidate | Cache resolution | Cost | Qualification |
| --- | --- | ---: | --- |
| Knox-class frigate | Base platform | 95 | Exact 1982 hull/loadout pending |
| Skipjack-class SSN | Base platform | 205 | Exact 1982 hull pending |
| Tarawa-class LHA | Base platform | 222 | Campaign-node logistics remain separate |
| Forrestal represented fit | Base platform | 284 | Air wing and escorts excluded |
| Kara-class cruiser | Base platform | 276 | Exact 1982 hull pending |
| F-14A | Base platform | 193 | Squadron/quantity/loadout pending |
| A-6E | `Combined@1982` | 90 | Exact squadron pending |
| S-3A | `Combined@1982` | 78 | Exact squadron pending |
| E-2C | Base platform | 148 | Exact squadron/loadout pending |
| Slava-class cruiser | Base platform | 857 | Only one represented reference begins in 1982 |
| Kirov-class battlecruiser | Base platform | 1108 | Late threat candidate only |

Regenerate this table after any game build or formula-version change.

## Milestone B runtime ledger

These values describe the disposable Moderate/default laboratory and are evidence, not campaign balance decisions.

| Event | Spendable points | Force cap | Evidence |
| --- | ---: | ---: | --- |
| Initial laboratory state | 100 | 500 | Fresh pre-A save |
| Mission A completion | 120 | 520 | +20 points, +20 cap |
| Mission B-1 completion | 125 | 525 | +5 points, +5 cap; no repair/rearm |
| Repair Knox Light damage | 115 | 525 | Explicit right-click repair, cost 10 |
| Repair Perry Light damage | 94 | 525 | Explicit right-click repair, cost 21 |
| Mission B-2 completion | 99 | 530 | +5 points, +5 cap; automatic rearm |

Observed purchase costs were Knox Variant1/Variant2 97 each and Perry Variant1 206. Multiple Knox purchases required exposing separate numbered variants; this is a roster-availability rule, not evidence that campaign balance should use these candidates or values.
