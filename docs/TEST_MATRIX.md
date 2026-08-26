# Runtime Test Matrix

## Evidence rules

- Use a fresh disposable save unless the test explicitly verifies reload behavior.
- Record the deployed Git commit, exact game build, difficulty, and save name.
- Copy observed values from UI/save/log evidence; do not record parser inference as an actual result.
- Use `Not run` until an in-game observation exists.

| Test ID | Milestone | Commit | Game build | Difficulty | Test purpose | Starting state | Action | Expected | Actual | Save name | Pass/Fail | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A-01 | A | TBD | 0.8.2 Build #363 (23607) | TBD | Discover deployed user campaign | Fresh disposable campaign deployment | Start/restart game and open campaign UI | Campaign title appears | Not run | TBD | Not run | Test `_info.ini` requirement and restart behavior separately |
| A-02 | A | TBD | 0.8.2 Build #363 (23607) | TBD | Metadata hot reload | Campaign visible | Change disposable title and return/reload/restart as controlled | Refresh requirement identified | Not run | TBD | Not run | |
| A-03 | A | TBD | 0.8.2 Build #363 (23607) | TBD | English-only FreeEvent | Fresh disposable save | Open first node | Unmistakable test text renders | Not run | TBD | Not run | |
| A-04 | A | TBD | 0.8.2 Build #363 (23607) | TBD | Trivial mission launch and explicit result | FreeEvent complete | Launch and satisfy victory trigger | Mission ends with recorded result | Not run | TBD | Not run | Also exercise defeat path in a separate save if practical |
| A-05 | A | TBD | 0.8.2 Build #363 (23607) | TBD | Progression and `RequiredResult=CostlyVictory` | Fresh save | Complete mission | Node completes/advances only at threshold | Not run | TBD | Not run | Record returned grade |
| A-06 | A | TBD | 0.8.2 Build #363 (23607) | TBD | Rewards, cap, and save creation | Known starting points/cap | Complete mission once | Points/cap change once and save exists | Not run | TBD | Not run | Record exact path and duplicate protection if observed |
| A-07 | A | TBD | 0.8.2 Build #363 (23607) | N/A | Deployment safety | Clean original tree baseline | Deploy authored campaign | Only exact user campaign destination changes | Not run | N/A | Not run | Compare manifest/hash evidence |
| B-01 | B | TBD | 0.8.2 Build #363 (23607) | TBD | Selected roster carry-over | Fresh laboratory save; two purchased vessels | Complete Mission A | Surviving roster and instance IDs persist | Not run | TBD | Not run | |
| B-02 | B | TBD | 0.8.2 Build #363 (23607) | TBD | Loss persistence | Fresh laboratory save | Lose one optional vessel and complete Mission A | Destroyed unit removed; loss recorded | Not run | TBD | Not run | |
| B-03 | B | TBD | 0.8.2 Build #363 (23607) | TBD | Ammunition/damage continuity | Rearm/repair false in Mission B | Fire weapons, take damage, continue | Expenditure and damage carry over | Not run | TBD | Not run | Record save sections/values |
| B-04 | B | TBD | 0.8.2 Build #363 (23607) | TBD | Repair/rearm behavior | Controlled duplicate pass | Set repair/rearm true and continue | Exact restoration/cost behavior observed | Not run | TBD | Not run | |
| B-05 | B | TBD | 0.8.2 Build #363 (23607) | TBD | Builder availability | Same owned roster | Compare builder true/false nodes | UI/access difference observed | Not run | TBD | Not run | |
| B-06 | B | TBD | 0.8.2 Build #363 (23607) | TBD | Save/reload persistence | Mission A completed and saved | Exit, restart, reload | Points/cap/roster/damage/ammo match | Not run | TBD | Not run | |
| B-07 | B | TBD | 0.8.2 Build #363 (23607) | TBD | Mission allowlist restriction | Own unit excluded from Mission B | Inspect availability, then restore later | Owned but unavailable, then available again | Not run | TBD | Not run | Expected remains inference until observed |
| B-08 | B | TBD | 0.8.2 Build #363 (23607) | TBD | Reward idempotency | Completed Mission A save | Revisit debrief/reload | Rewards do not reapply | Not run | TBD | Not run | |
| B-09 | B | TBD | 0.8.2 Build #363 (23607) | TBD | Granted unit | Known-cost candidate | Complete reward node | Zero purchase cost and cap/roster behavior recorded | Not run | TBD | Not run | Optional if inexpensive |
| B-10 | B | TBD | 0.8.2 Build #363 (23607) | TBD | Detached/subset isolation | Main force plus eligible subset | Complete detached node | Undeployed units unchanged | Not run | TBD | Not run | Optional; must not delay core exit gate |

