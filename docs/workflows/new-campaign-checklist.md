# New-Campaign Checklist

## 1. Freeze the target

- Record exact game build and point formula.
- Choose linear versus Task Force Mode features.
- Define supported languages and a unique campaign ID.
- Decide whether dynamic theater generation is required.

## 2. Create source safely

- Author in a separate repository directory.
- Deploy only to `StreamingAssets/user/campaigns/<id>`.
- Never modify `StreamingAssets/original`.
- Exclude stock assets, caches, saves, logs, and generated local inventories from version control.

## 3. Prove the skeleton

- Minimal `campaign.ini` and one trivial mission.
- Correct `[File] Base` paths.
- Valid counts and references.
- Commander settings and roster if Task Force Mode is enabled.
- Campaign discovery, selection, launch, result, return, and save/reload.

## 4. Build architecture before content

- Assign stable internal node IDs.
- Define prerequisites, joins, expiry, result thresholds, and endings.
- Register persistent variables with writers and readers.
- Specify every node's surface/air/submarine inclusion and selection limits.
- Specify builder, repair, and rearm independently.

## 5. Build economy from current prices

- Regenerate point data for the target build.
- Price exact variants, squadrons, loadouts, and stores.
- Define starting points and cap separately.
- Define mission point rewards and cap increases separately.
- Test mandatory-route viability without optional rewards.
- Test losses, dismissal/refunds, repair, granted units, and unlocks.

## 6. Implement missions vertically

- Environment and geometry.
- Sides, units, formations, and navigation.
- Detection and ROE assumptions.
- Objectives, triggers, messages, and terminal results.
- Reinforcements/Air Operations.
- Campaign-specific persistent consequences.
- Briefing and debrief narrative.

## 7. Validate

- Static counts, IDs, paths, and dangling references.
- Standalone tactical paths.
- Campaign transition and persistence.
- Save/load at critical state boundaries.
- All difficulty/economy settings.
- Every supported language.
- Upgrade audit before declaring compatibility with a later build.
