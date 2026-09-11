# Campaign Design

## Document status

This is the authoritative Falklands creative and strategic design ledger. Reusable runtime mechanics are governed by [`README.md`](README.md) and its architecture/reference manuals; project runtime evidence remains in [`TEST_MATRIX.md`](TEST_MATRIX.md). The original staged reconnaissance is retained in [`FALKLANDS_CAMPAIGN_RESEARCH.md`](FALKLANDS_CAMPAIGN_RESEARCH.md).

## Campaign premise

- The campaign is an alternate history set during the 1982 Falklands War. The main-operation count, optional-operation count, playable-mission count, and total timeline-node count are all design-driven rather than fixed; optional/lettered missions and narrative events will be added where they create meaningful choices or consequences.
- The Soviet Union signs a mutual-defense pact with Argentina, pursues a strategic foothold in the Western Hemisphere, and begins deploying forces into South America.
- The United States is the primary playable faction because the current Sea Power database provides substantially stronger period US coverage than British or Argentine coverage.
- The player begins with a small US force. Points, force-cap increases, availability changes, and operationally plausible reinforcement opportunities expand it over time.
- NATO involvement escalates later. Article 5 is eventually invoked, but its triggering incident is not yet decided.
- A full carrier task force should be fieldable in the final campaign phase; it is not available at the beginning.

## Campaign design principles

- Prefer historical plausibility where the game database permits it.
- Gameplay takes precedence when unit-coverage limitations require a compromise.
- Document every British or Argentine substitution and its material capability differences.
- Escalate forces, stakes, and player options gradually.
- Make losses and ammunition expenditure consequential during no-resupply sequences.
- Tie major resupply events to believable operational pauses, bases, or reinforcement arrivals.
- Do not begin with a carrier task force; late carrier capability must feel earned.
- Use explicit 1982-valid variants, squadrons, and loadouts rather than class-wide assumptions.
- Preserve stable mission, unit, objective, trigger, and persistence IDs after real campaign saves begin.

## Campaign operation network

The campaign is a directed timeline, not a fixed list of ten sequential mission files. It may contain:

- mandatory main operations;
- optional/lettered operations that expire if bypassed;
- detached or force-limited operations;
- `FreeEvent`/`NewspaperEvent` narrative nodes;
- joins that require more than one prior node;
- later missions whose initial intelligence or enemy order of battle changes according to persistent outcomes.

The table below stays intentionally concise. Detailed force restrictions, logistics, rewards, variables, and downstream effects belong in the operation specification ledger that follows.

| Operation ID | Sequence role | Node type | Working title | Date/location | Strategic event and player role | Status |
| --- | --- | --- | --- | --- | --- | --- |
| M1 | Main | Tactical mission | TBD | 1982; approaches to Cuba, exact date/area TBD | A small US naval task force intercepts a Soviet strategic-missile convoy below the threshold of full US–Soviet war; no carrier is available | Concept approved; not implemented |
| Main arc remainder | Main | Tactical and narrative nodes | TBD | TBD | Campaign escalation toward the South Atlantic, later NATO involvement, Article 5, and an earned late carrier capability | Deliberately unassigned pending narrative review |
| Optional/lettered operations | Optional | Tactical mission | TBD | TBD | Reconnaissance, threat reduction, rescue, interdiction, reinforcement, or other meaningful opportunities may branch from the main route | Count and placement TBD |
| Narrative events | Main or conditional | `FreeEvent`/`NewspaperEvent` | TBD | TBD | Political, intelligence, logistics, and escalation transitions | Count and placement TBD |

### Operation archetype taxonomy

These are reusable design patterns, not mutually exclusive engine types. One operation may be optional, force-limited, no-logistics, and consequence-bearing at the same time.

| Archetype | Defining player experience | Typical mechanical ingredients | Proven reference/status |
| --- | --- | --- | --- |
| Mandatory main operation | Advances the required strategic route | Required result, main-route parent/child topology, explicit logistics and rewards | Project and stock runtime |
| Optional/lettered opportunity | Offers a time-limited choice outside the required route | Shared parent, `ExpiresAfterMissionComplete`, side-mission labels, bonus rewards or persistent flag | Stock runtime + source |
| Detached submarine operation | Commands an assigned/eligible submarine while the surface force stays out | Surface/air false, submarine true, builder usually false, special note | Stock runtime + source |
| Lone-ship challenge | Player selects exactly one owned vessel | Required type `Vessel`, maximum units 1, subset selection, often rearm and high reward | Stock runtime + source |
| Limited surface detachment | Player selects a capped group while the remainder stays in reserve | Required type `Vessel`, maximum units N, subset selection, special note | Stock runtime + source; cap 3 observed |
| Entire-force commitment | All applicable persistent units must deploy | Includes flags plus require-entire-force true | Source/code confirmed |
| Continuation under pressure | Carries damage and expended ammunition into another fight | Repair false, rearm false; builder either limited or disabled | Project runtime |
| Limited-reinforcement continuation | Preserves damage/stores but permits a curated purchase pool | Builder true, repair/rearm false, narrow node roster | Stock runtime + source |
| Full-logistics operation | Allows force changes, paid repairs, and automatic rearm | Builder, repair, and rearm true | Project runtime |
| Conditional-logistics operation | Earlier success determines later ammunition support | Persistent flag plus conditional rearm AND/OR | Source/code confirmed; custom runtime test required |
| Reconnaissance consequence mission | Makes later targets known from mission start | Tactical success flag; later reveal/identify trigger | Stock runtime + source |
| Threat-reduction mission | Removes a later enemy group or reinforcement | Tactical/completion flag; later conditional spawns | Stock runtime + source |
| Reward/unlock mission | Accelerates force growth or expands capability | Points, cap, granted units, loadout unlocks, rank/ribbon, debrief notice | Stock runtime + source; points/cap project runtime |
| Narrative/political event | Advances public, classified, diplomatic, or logistics context without tactical play | `FreeEvent`/`NewspaperEvent`, localized XML/XAML, parents/conditional unlocks | Project runtime for English `FreeEvent` |
| Terminal operation | Resolves the campaign and service record | Final-mission flag, ending/debrief narrative, no assumed successor builder | Source/code confirmed |

## Operation specification ledger

Every playable operation must receive one row before implementation. Narrative nodes may use the same ledger when they have prerequisites, expiry, persistent effects, or unlock consequences. Grouped columns keep related implementation decisions together rather than scattering them through prose.

| Operation ID | Route and availability | Player-force contract | Logistics and availability | Completion benefits | Persistent outcome and downstream use | Evidence/status |
| --- | --- | --- | --- | --- | --- | --- |
| M1 | Main entry operation; prerequisite/expiry TBD | Small persistent US surface force; exact owned, authored-attached, air, submarine, flagship, and deployment-limit rules TBD | Builder/repair/rearm and exact roster tier TBD; no carrier | Points/cap TBD; rewarded units/loadouts/rank/ribbons TBD | Establishes the Soviet Cuban diversion; exact flag names and later consumers TBD | Narrative concept approved; mechanics unassigned |
| Future main/optional nodes | Record main/optional/narrative role, parents, conditional unlocks, expiry, and bypass behavior | Record force source, included components, required type, entire/subset rule, maximum deployable units, authored attached forces, and required flagship | Record builder, repair, rearm/conditional rearm, mission allowlist, air tasking, airbase preparation, and reinforcement tier | Record spendable points, cap, granted units, loadout unlocks, rank, ribbons, and debrief notices | Record every persistent flag written, exact later node/trigger that reads it, player-facing benefit or threat change, and fallback when skipped | One row per designed node |

### Ledger writing rules

1. `Route and availability` must state whether a node is mandatory, optional, parallel, conditional, expiring, or narrative-only. “Optional” alone is insufficient: name its prerequisite and the main node that closes its opportunity window.
2. `Player-force contract` must distinguish persistent owned units from scenario-authored attached/supporting forces. It must state what categories are included and whether the player deploys the entire force, a selectable subset, a required unit type, or a capped quantity.
3. `Logistics and availability` must treat builder, repair, and rearm as three independent controls. A restricted purchase pool is not synonymous with no logistics.
4. `Completion benefits` must distinguish spendable points, force-cap growth, free unit grants, loadout unlocks, service-record progression, and purely narrative recognition.
5. `Persistent outcome and downstream use` must name both sides of every dependency: the operation/trigger that writes a flag and every later node, spawn, reveal, objective, briefing element, or unlock condition that reads it.
6. Every optional operation must provide a meaningful but nonmandatory benefit. Skipping it may preserve uncertainty or leave an enemy force intact, but must not make the required campaign route unwinnable.
7. Use stable IDs only after the node network is reviewed. Display labels such as `3A` may differ from internal numbered `[MissionN]` sections.

## Campaign-node mechanics catalog

This catalog is the design-facing index of special campaign controls. It is not a replacement for the technical reconnaissance document. Each future operation specification should cite the mechanisms it uses and avoid relying on unverified behavior.

### Evidence labels

| Label | Meaning |
| --- | --- |
| Project runtime | Directly observed in the disposable Falklands Milestone A/B campaign on build 0.8.2 #363 |
| Stock runtime + source | Observed by the user during stock-campaign play and corroborated in installed stock files |
| Source/code confirmed | Present in stock authoring and/or active inspected implementation, but not isolated in our runtime laboratory |
| Unverified | Plausible or present in incomplete/prototype content; must not drive campaign design without a focused test |

### Timeline, prerequisites, and opportunity windows

| Design capability | Authored control | Behavior and design use | Evidence | Important limits |
| --- | --- | --- | --- | --- |
| Initial availability | `IsUnlocked=True`; `IsComplete=False` | Seeds the entry node; later state is save-driven | Project runtime | Do not pre-complete real nodes |
| Simple prerequisite | `Parents=<node>` | Child becomes eligible after its parent completes | Project runtime | Parent refers to internal node number, not display label |
| Multiple prerequisites | `Parents=a,b` or `UnlockConditionsJSON.completedMissions` | Creates a join requiring all listed nodes | Source/code confirmed | Active semantics are AND, not “any parent” |
| Persistent-value prerequisite | `UnlockConditionsJSON.persistentEquals` | Gates a node on exact saved key/value pairs as well as completed nodes | Source/code confirmed | Comparisons are exact strings; a missing key fails |
| Optional/parallel branch | Multiple children share a parent | Presents concurrent main/side opportunities | Stock runtime + source | Must define how the main route proceeds and whether the side node expires |
| Expiring opportunity | `ExpiresAfterMissionComplete=<node>` | Removes an optional node after the named advance point | Stock runtime + source | Expiry ordering at the exact simultaneous boundary is not laboratory-tested |
| Result threshold | `RequiredResult=CostlyVictory` | Completes only when actual result is at or above the threshold | Project runtime | Stock design expects retry after a below-threshold result; no proven defeat-continuation branch |
| Completion-set campaign flag | `OnCompleteActionJSON` with `setPersistentOnComplete` | Writes strategic state when the node completes | Stock runtime + source | Use stable, namespaced keys and document every consumer |
| Tactical-outcome flag | Mission trigger `Action_VariableSet=<key>,<value>` plus `[CampaignVariables]` | Writes a result from a specific in-mission action rather than mere node completion | Stock runtime + source | Best for “target destroyed/scouted/survived”; ensure victory path actually sets it |
| Completion vignette | `OnCompleteEvent=True` and localized `OnCompletePath_*` | Opens authored completion content after a node | Source/code confirmed | Ordering relative to child unlocks remains untested |
| Force-open another node | `OnCompleteForceOpen=<node>` | Stock field intended to force/open a later timeline node | Source/code confirmed | Exact runtime semantics were not isolated; treat as test-required before use |
| Narrative timeline node | `Type=FreeEvent` or `NewspaperEvent` with localized asset paths | Interleaves reports, orders, newspapers, or political events with missions | Project runtime for English-only `FreeEvent` | `NumberOfMissions` counts narrative nodes as well as tactical nodes |

### Player-force source and deployment restrictions

| Design capability | Authored control | Behavior and design use | Evidence | Important limits |
| --- | --- | --- | --- | --- |
| Persistent surface force | `TaskForceModeIncludesTaskForce=True` | Inserts the owned surface force into the mission | Project runtime | Does not itself define whether all or a subset deploys |
| Persistent air component | `TaskForceModeIncludesAirwing=True` | Includes eligible persistent/carried air units | Source/code confirmed | Carrier and land-air persistence still require later dedicated tests |
| Persistent submarine component | `TaskForceModeIncludesSubmarine=True` | Enables submarine deployment behavior | Stock runtime + source | Test our exact owned-submarine selection before implementation |
| Detached operation | Set unused component flags false and only the required component true | Leaves the main surface force out while a submarine or other subset operates | Stock runtime + source | Exact unchanged damage/store comparison for undeployed custom units remains untested |
| Entire-force deployment | `TaskForceModeRequireEntireTaskForce=True` | Requires the applicable persistent force to deploy | Source/code confirmed | Be explicit; do not infer from briefing prose |
| Selectable subset | `TaskForceModeRequireEntireTaskForce=False` | Allows the player to choose among eligible owned units | Stock runtime + source | Combine with category and quantity controls when selection must be narrow |
| Required category | `TaskForceModeRequiredUnitType=Vessel` | Restricts the selectable deployment category | Stock runtime + source | Only `Vessel` is confirmed in the inspected stock examples |
| Deployment quantity limit | `TaskForceModeMaxUnits=<count>` | Greys additional roster checkboxes after the limit is reached | Stock runtime + source | Confirmed by user at one and three ships; this—not the allowlist—is the proven quantity control |
| Mission purchase/eligibility pool | `TaskForceModeAllowedRosterUnits` | Curates which exact types, variants, and squadrons appear in that node's builder | Project runtime + source | Did not prevent an already-owned excluded Perry from deploying with builder disabled; never use as the sole deployment filter |
| Builder access | `TaskForceModeEnableTaskForceBuilder=True/False` | Enables purchases, dismissals, loadout changes, repair access, and visible points UI | Project runtime | Independent of repair and rearm; false can hide points display |
| Multiple hulls of one class | List multiple numbered variants in campaign and node rosters | Makes each distinct hull variant purchasable once | Project runtime | No generic “buy N of class” field was found; an owned variant's row greys out |
| Flagship requirement | Campaign-level `TaskForceRequireFlagship` plus commander/task-force state | Requires a valid flagship for launch where configured | Source/code confirmed | First purchased ship became flagship in project runtime; reassignment is via owned-ship right-click menu |
| Mission generation | `TaskForceModeMissionGenerationType=Generated` or `Replaced` | Chooses how persistent forces are integrated with authored mission slots | Source/code confirmed | Exact state differences across both modes remain a targeted runtime unknown |
| Deployment editing | `TaskForceModeDeploymentOptions=True`; `TaskForceModeDefaultDisposition=Formation/Dispersed` | Exposes pre-launch placement/disposition behavior on selected stock nodes | Source/code confirmed | Must be tested with our scenario geometry before relying on it |
| Scenario-authored attached forces | Fixed player-side units/groups authored in the tactical mission INI | Adds escorts, auxiliaries, aircraft, bases, or allied forces that are not purchased persistent roster entries | Source/code confirmed | Record ownership, controllability, survival consequence, and whether any unit joins persistence; there is no single campaign-node “attached forces” field |

### Logistics, readiness, and reinforcement access

| Design capability | Authored control | Behavior and design use | Evidence | Important limits |
| --- | --- | --- | --- | --- |
| Paid repair opportunity | `TaskForceModeRepair=True` | Adds a right-click repair action for eligible damaged owned ships | Project runtime | Light Knox cost 10 and Light Perry cost 21 in the laboratory; costs depend on unit, damage, difficulty, and build |
| No repair | `TaskForceModeRepair=False` | Carries surviving damage onward | Project runtime | Builder may still remain available |
| Automatic rearm | `TaskForceModeRearm=True` | Restores eligible ammunition automatically at mission launch and shows per-ship `Rearmed` detail badge | Project runtime | Not a selectable or purchasable menu action; badge is absent from compact roster cards |
| No rearm | `TaskForceModeRearm=False` | Carries expended stores onward | Project runtime | Builder may still offer limited reinforcements |
| Conditional rearm | `TaskForceModeRearmByVariableAND` / `TaskForceModeRearmByVariableOR` | Makes rearm depend on saved campaign variables | Source/code confirmed | No project runtime pass yet; document exact condition and fallback before use |
| Full logistics | Builder + repair + rearm all true | Provides reselection/reinforcement, paid repair, and automatic ammunition restoration | Project runtime | “Full” does not imply free repair |
| Limited reinforcement | Builder true; repair/rearm false; restricted node roster | Permits selected purchases while preserving damage and ammunition pressure | Stock runtime + source | Recommended pattern for low-logistics continuations |
| Total lockout | Builder + repair + rearm false | Preserves state and blocks purchases/repair; points UI may be hidden | Project runtime | Use only when the narrative warrants no force-management access |
| Air tasking | `TaskForceModeAirTaskingAvailable` and `TaskForceModeAirTaskingFlight1..3` | Enables stock pre-mission air-tasking facilities/flights | Source/code confirmed | Exact custom-campaign behavior and persistence remain untested |
| Airbase preparation | `TaskForceModeAirbasePrepAvailable`, ready slots, in-progress slots | Controls stock airbase-preparation capacity | Source/code confirmed | Requires a dedicated land-air runtime test before campaign dependence |

### Completion rewards and progression

| Benefit | Authored control | Behavior and design use | Evidence | Important limits |
| --- | --- | --- | --- | --- |
| Spendable points | `TaskForceModeCompletionPoints` | Adds purchase/repair currency after qualifying completion | Project runtime | Difficulty multiplier may affect awarded points |
| Force-cap growth | `TaskForceModeCompletionCapPoints` | Raises maximum deployable fleet value independently of spendable balance | Project runtime | Cap increase is not a unit grant and does not broaden availability |
| Reward idempotency | Save fields `CompletionRewardsApplied`, `CompletionPointRewardApplied`, `CompletionCapRewardApplied` | Prevents replay/reload from paying the same node repeatedly | Project runtime | Preserve stable node IDs after real saves begin |
| Granted units | `TaskForceModeCompletionRewardedUnits=type,variant/squadron,quantity` | Adds story-mandated units without a normal purchase | Source/code confirmed; stock saves show zero purchase cost | Fresh custom-save cap adjustment and refund behavior remain untested |
| Loadout-tier unlock | `TaskForceModeLoadoutsToUnlock` | Makes a named loadout category available after completion | Stock runtime + source | Both unit availability and sufficient points/cap still apply |
| Commander promotion | `TaskForceModeCommanderIncreaseRank` | Advances service-record rank at selected milestones | Source/code confirmed | Narrative significance and cadence must be designed deliberately |
| Ribbon/decoration | `TaskForceModeRibbonAwards` | Adds service-record recognition | Source/code confirmed | Presentation reward; do not substitute it for a mechanical consequence |
| Debrief notice | `TaskForceModeDebriefNoticeTitle_*` / `Text_*` | Announces rewards, unlocks, or consequences after completion | Source/code confirmed | Message timing versus usable unlocks remains to be runtime-checked |
| Final operation | `TaskForceModeFinalMission=True` | Marks the terminal task-force operation | Source/code confirmed | Ending event/order and post-campaign UI behavior require final-path validation |

### Mission planning, generated threat, and player communication

| Design capability | Authored control | Behavior and design use | Evidence | Important limits |
| --- | --- | --- | --- | --- |
| Generated-threat summary | `TaskForceModeThreatProfileShip/Air/Sub/Land` | Declares category presence and approximate threat rating for task-force planning UI | Source/code confirmed | Presentation aid, not a substitute for balancing the authored tactical order of battle |
| Air-tasking menu definitions | `TaskForceModeAirTaskingFlight1..3` | Defines labeled pre-mission flight roles, eligible aircraft-role groups, quantities, and accepted loadout categories | Source/code confirmed | Complex delimiter format; clone a proven stock pattern and validate with exact squadrons |
| Authored navigation preservation | `UseAuthoredNavigation=True` | Tells supported campaign presentation/generation paths to retain authored navigation behavior | Source/code confirmed | Exact effect varies with generation path; validate when mission geometry is built |
| Onboarding operation | `Onboarding=True` | Marks the stock opening task-force mission for tutorial/onboarding treatment | Source/code confirmed | Only use if the real campaign needs tutorial behavior; exact UI effects need confirmation |
| Sequence label | `MissionSequenceName_*` and `MapShortName_*` | Presents `MAIN MISSION`, `SIDE MISSION`, or lettered map labels independently of internal node number | Stock runtime + source | Cosmetic labels do not create optionality or branching by themselves |
| Special-mechanics notice | `MissionSpecialNote_*` and highlight color | Prominently explains detached force, one-ship/three-ship caps, future consequences, or unusual risk | Stock runtime + source | Must match actual deployment fields and persistent effects |
| Logistics notice | `MissionResupplyRules_*` and `TaskForceModeBuilderSituation_*` | Explains repair, rearm, builder, and reinforcement state before launch | Project runtime + source | Text is presentation only; booleans and allowlists control behavior |
| Deployment confirmation | `MissionWarningPopup_*` | Requires explicit player confirmation for a formation, force-selection, or readiness warning | Stock runtime + source | Pipe-delimited text; test formatting and cancellation path |
| Reward/consequence announcement | Debrief notice fields and/or a following narrative node | Makes mechanical rewards and persistent consequences visible after completion | Source/code confirmed | Never leave a material later consequence discoverable only by save inspection |

`MissionType=Main` appears in the first Pacific Strike task-force node, but its active design effect has not been isolated. Optionality in the stock campaign is actually established by topology, expiry, labels, and force/reward fields. Do not rely on `MissionType` to create a main/side distinction without a focused test.

## Persistent consequence ledger

Every strategic variable must be registered here before mission authoring. This prevents flags from becoming invisible implementation trivia and lets narrative, briefing, tactical, and economic consumers stay synchronized.

| Persistent key | Writer and success condition | Later consumer | Player-visible consequence if true | Fallback if false/skipped | Lifetime/reset | Evidence/status |
| --- | --- | --- | --- | --- | --- | --- |
| `08APalawanReconCompleted` (stock reference) | Pacific Strike 08A victory trigger after reconnaissance/exfiltration | Mission 09 variable-check trigger | Relevant missile sites are identified indefinitely at mission start | Player must detect/classify them conventionally | Campaign save | Stock runtime + source; reference pattern only |
| `07ASlavaDestroyed` (stock reference) | Pacific Strike 07A completion/tactical destruction outcome | Mission 10 unit `SpawnByVariableAND` checks and briefing binding | Previously destroyed Slava group is absent later | Group remains present in later order of battle | Campaign save | Stock runtime + source; reference pattern only |
| Falklands campaign keys | TBD | TBD | TBD | Required-route mission remains viable | Campaign save unless explicitly scoped | No keys approved yet |

### Approved consequence recipes

| Recipe | Writer | Reader | Suitable campaign use | Design safeguard |
| --- | --- | --- | --- | --- |
| Prior reconnaissance | Tactical `Action_VariableSet`; later `Condition_Type=VariableCheck` and `Action_UnitRevealToTaskforce=...|Identify` | Later mission start trigger | Optional submarine, aircraft, or surface scouting reveals fixed targets or a known contact | Skipping preserves fog of war; it must not remove required targeting information forever |
| Threat removed earlier | Completion/tactical flag; later units use `SpawnByVariableAND=<key>,IsFalse` | Later mission unit spawn | Optional interception prevents a task group, bomber package, submarine, or reinforcement from appearing later | Later mission must remain balanced and winnable with threat present |
| Conditional node unlock | `OnCompleteActionJSON` or tactical flag | `UnlockConditionsJSON.persistentEquals` | Opens a follow-on opportunity only after a qualifying outcome | Main route must not depend on an optional flag unless explicitly intended |
| Conditional logistics | Prior survival/objective flag | `TaskForceModeRearmByVariableAND/OR` | Preserved tanker/base/convoy enables later automatic rearm | False path must have explicit player-facing warning and viable stores assumptions |
| Economic acceleration | Optional node completion rewards | Persistent points/cap | Side operation increases choice margin or accelerates access | Main-route economy must remain viable without every optional reward |
| Story-mandated reinforcement | Node completion grant | Persistent roster and later allowlists | Adds an allied/story unit at a believable reinforcement event | Record cost/cap effects and exact variant; do not silently grant anachronistic capability |

## Optional-operation design contract

An optional operation is approved only when all of the following are answered:

1. What main node makes it available, and what later node causes it to expire?
2. What force may deploy: owned main force, selectable subset, one vessel, capped group, submarine, air detachment, or scenario-authored force?
3. What happens to undeployed persistent units?
4. Are builder, repair, rearm, and reinforcement availability each enabled or disabled?
5. What immediate points, cap, unit, loadout, rank, or ribbon rewards are granted?
6. What persistent flag is written, and which exact later content reads it?
7. What tangible later advantage does completion provide?
8. What remains different when the player skips or fails to complete it?
9. Is the mandatory campaign route still fair and winnable without it?
10. How is the consequence explained in the mission tile, special note, debrief notice, and later briefing?

## Mechanics not approved as design dependencies

| Assumption to avoid | Current evidence | Required response |
| --- | --- | --- |
| Defeat automatically branches to a different successor | No stock `OnDefeat` node action or result-grade child condition was found | Design required missions for retry after below-threshold results unless a disposable test proves another route |
| `CompletedParentsRequired` provides “N of M” parent logic | Active parser does not read the prototype field | Use explicit `Parents`/`UnlockConditionsJSON`; test any desired OR/N-of-M topology separately |
| `MissionType=Main` makes other nodes optional | Active effect not isolated | Establish optionality through topology, expiry, labels, and bypass-safe main-route design |
| A node allowlist prevents excluded owned ships from deploying | Project B-1 contradicted this | Use include/subset/required-type/maximum-unit controls; test any stronger exclusion need |
| Builder disabled means repair/rearm disabled, or vice versa | Project runtime proved all three controls are independent | Specify each boolean independently for every playable node |
| Narrative logistics text changes mechanical state | Text is presentation only | Generate text from the reviewed mechanical ledger and validate both |
| One class roster entry permits arbitrary duplicate purchases | Project runtime required separate numbered variants | Allocate one explicit valid variant per purchasable hull |
| A single campaign-node field defines “attached forces” | No such general field was found | Author fixed support units in the tactical mission and document their ownership/survival rules in the operation ledger |
| A granted unit's cap/refund behavior is fully known | Stock evidence shows zero-cost grants, but fresh custom accounting remains untested | Run the focused grant laboratory before basing economy on a mandatory grant |
| Undeployed custom units are proven byte-for-byte unchanged after detached missions | Strong stock behavior, but no controlled project comparison | Test exact damage/magazines before using detached operations with critical continuity |

## Political and narrative state tracker

| Mission | Public understanding | US classified understanding | Soviet objective | Argentine situation | British situation | NATO political state | Player knowledge |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | TBD | Soviet missile-system convoy toward Cuba is understood as an attempt to distract and delay US South Atlantic intervention | Establish the Cuban diversion while remaining below full-war threshold at mission start | Mutual-defense pact with the USSR; further details TBD | Falklands crisis underway; further details TBD | No Article 5 invocation | Receives the operational facts needed for the convoy interception; exact disclosure TBD |
| Remaining main and optional operations | TBD | TBD | TBD | TBD | TBD | TBD | TBD |

## Article 5 escalation

- Foreshadowing: TBD.
- Triggering incident: TBD; do not invent before campaign-design review.
- Political decision: TBD.
- Player-facing announcement: TBD.
- Mechanical NATO unlock: later allowlist/cap/reward expansion; exact implementation TBD.
- Soviet response: TBD.

## Resupply cadence

| Transition type | Definition | Mission assignment |
| --- | --- | --- |
| Full reset/resupply | Builder, repair, and rearm available at a believable operational pause or reinforcement point | TBD |
| Partial reinforcement | Limited builder or reinforcement access without necessarily clearing prior damage/stores | TBD |
| No-resupply continuation | Prior losses, damage, and ammunition expenditure remain consequential | TBD |
| Conditional logistics | Rearm depends on a persistent objective such as a surviving tanker, base, or convoy | TBD |

Detached and force-limited operations are deployment contracts rather than resupply states. They may independently use any of the logistics patterns above.

## Optional-mission consequence patterns

Optional missions may provide more than points and cap. Pacific Strike demonstrates useful player-observed patterns that the Falklands campaign may adopt after its operation network is reviewed:

- a detached reconnaissance mission can set a persistent intelligence flag that reveals or identifies specified targets at the start of a later mission;
- destroying an enemy group in an earlier mission can set a persistent flag that prevents that group from spawning later;
- optional operations can expire when the player advances past their decision window;
- restricted operations can limit deployment to a single vessel or another explicit maximum without removing the rest of the owned roster.

These consequences should reward preparation without making the mandatory route unwinnable. The detailed persistent-consequence ledger and optional-operation contract above govern their design. No Falklands mission assignment or specific consequence has been selected yet.
