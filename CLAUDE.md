# MyAddon project instructions

You are working on MyAddon (a placeholder name until the author picks one), racetracks' World of Warcraft addon: <one-line purpose>. Lua 5.1, WoW API only, no libraries. Clients: Retail (120007) and Classic (16001); three TOCs per addon folder.

Repos: racetracks/WoW-Addon-Template-Workspace (the addon), racetracks/WoW-Addon-Template (production releases are mirrored here) and racetracks/WoW-Addon-Template-Scratch (the scratch repo: test zips, saves, docs, handover packs; private). Read-only references: <suite repos, documented API only, copy nothing>; Gethe/wow-ui-source.

## Baseline pack
The WoW addon baseline (2026-10-07, v4) lives in `docs/baseline/`. These files are loaded automatically:

@docs/baseline/README.md
@docs/baseline/02_RULES.md
@docs/baseline/07_WORKING_WITH_THE_AUTHOR.md
@docs/baseline/10_FEATURE_DESIGN_AND_DELIVERY.md

Read the others when the task touches them:
- `docs/baseline/01_PURPOSE_AND_LANGUAGES.md`: what an addon can and cannot do, client flavours
- `docs/baseline/03_REPOS_AND_REFERENCES.md`: repo roles and references
- `docs/baseline/04_ARCHITECTURE.md`: core plus load-on-demand parts, the loader
- `docs/baseline/05_UI_SUITES_AND_KNOWN_FIXES.md`: UI suite integration and known fixes
- `docs/baseline/06_HARNESS.md`: offline harness, migrations, look-compares
- `docs/baseline/08_PROJECT_LIFECYCLE.md`: the phases of a fresh addon project
- `docs/baseline/09_RELEASE_PIPELINE.md`: tag and release pipeline setup
- `docs/baseline/HANDOVER_TEMPLATE.md`: addon pack layout for handovers
- `docs/baseline/templates/` and `docs/baseline/examples/`: CI, TOCs, rules check and harness tooling to copy and adapt (rename MyAddon)

Where an addon-specific pack differs, it wins for that addon; the baseline is the default for everything else.

## Scratch repo pack
The scratch repo usage pack (2026-10-07, v2) lives in `docs/scratch/`, its layout reconciled with the author's rules. Loaded automatically:

@docs/scratch/05_RULES.md
@docs/scratch/03_LAYOUT.md

Read `docs/scratch/04_USAGE.md` before hosting anything (links, pushing, saves, docs releases, handover packs), and `docs/scratch/02_SETUP.md` when the scratch repo needs setting up. In short:
- Test builds: commit, then `sh tools/host_build.sh <scratch checkout>`; it builds the zip from HEAD, stores `releases/MyAddon-<version>-<YYYY-MM-DD-hh-mm>.zip` and `latest/MyAddon-latest.zip`, pushes, and prints both links for the reply.
- Real saves: `savedvariables/<version>/MyAddon.lua` in scratch, never in this repo. Harness: `MYADDON_REAL_SAVES=<scratch checkout>/savedvariables sh tools/harness/validate_all.sh`.
- Docs: current markdown in `docs/latest/<project>/`; at a project or feature release, a history copy in `docs/<project>/` and a zip in `docs/`. Handover packs in `docs/handover-packs/`.
- Production release notes: `summary/MyAddon-<version>.md`.
- Links: `https://github.com/racetracks/WoW-Addon-Template-Scratch/raw/main/<path>` (download) or `/blob/main/<path>` (read). Never delete or rename a file someone was given a link to.

## Key rules
- Lua 5.1, ASCII only, tabs, match the surrounding code, one namespace table, no UI code in core logic.
- No application or service logic in any UI folder. Minimal functions in the always-loaded core (the always-on engine and the launchpad); anything not regularly active goes in the load-on-demand library folder, with a measured resident cost.
- Front ends are independent: a UI never reads another UI's folder; UI resources both need live in the library folder. One config table, assets in each UI's own folder.
- One step per PR, based on main. Every change bumps all TOCs, adds a history.txt section and ships a test zip.
- Non-production versions are X.Y.Z-devNNN (three digits, incrementing, never reused) and publish as GitHub pre-releases. Only production (the completed feature, when the author says so) has no suffix. Fix builds of a stage add a two-digit suffix: devNNN, then devNNN_01, devNNN_02 (never reused); the next stage is plain dev(NNN+1). The version names the TOCs, the tag, the release and the zip (MyAddon-X.Y.Z-devNNN_NN.zip). Bump with `sh tools/bump_version.sh stage|fix|release "Title"` (or `line X.Y.Z`); the rules check rejects any other shape.
- A production release is also published on racetracks/WoW-Addon-Template (job `mirror` in release.yml) with Claude-summarized notes covering every build since the previous production release; see docs/baseline/09_RELEASE_PIPELINE.md.
- Host test zips, handovers, docs and saves on the scratch repo (docs/scratch/); always reply with links, never only a path.
- Before pushing: the rules check, the harness against the author's real saves, the look-compare for any window that changes.
- SavedVariables must not grow; layout changes need a validated migration and the author's OK first.
- Zero cost unless enabled; new settings default OFF; low cost when enabled (event-driven, no OnUpdate polling, no timers as logic gates); zero taint risk. Localize everything, one global root table, localized API shortcuts. Lazy UI and lazy indexes, reuse frames, unregister unneeded events, batch and cache. SavedVariables minimal; database separate from runtime cache.
- Performance first; measure, don't estimate. Ask numbered questions with a recommendation; lead with the answer. The author tests in game and merges.
