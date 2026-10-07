# Using scratch from a Claude session

## Links
| Purpose | Form |
| --- | --- |
| Download a file | `https://github.com/racetracks/WoW-Addon-Template-Scratch/raw/main/<path>` |
| Read a file in the browser | `https://github.com/racetracks/WoW-Addon-Template-Scratch/blob/main/<path>` |
| Browse a folder | `https://github.com/racetracks/WoW-Addon-Template-Scratch/tree/main/<path>` |

Every reply that delivers a file gives the link in the text.

## Pushing
```sh
cd <scratch checkout>                 # the attached checkout, or a fresh clone in a unique directory
git pull -q origin main               # always start from the latest
mkdir -p <folder> && cp <file> <folder>/
git add <folder> && git commit -m "<what, with version>" && git push origin HEAD:main
```
- Pull first; other threads push to scratch too.
- One commit per delivery, with a message that names the thing and its version.
- Build zips in a fresh, uniquely named directory; don't `rm -rf` globs (sandboxes block it).
- In a Claude.ai project, also copy each delivered zip into the project's shared files (for example `/mnt/project-files/builds/`). Claude Code sessions have no project files; scratch is the only copy.

## Test builds
`sh tools/host_build.sh <scratch checkout>` in the addon repo does all of this:
1. Build the zip from the committed branch (`git archive HEAD`), with every addon folder at the zip root (the same layout as release.yml).
2. Copy it to `releases/<Addon>-<version>-<YYYY-MM-DD-hh-mm>.zip` and to `latest/<Addon>-latest.zip`, update `latest/README.md`, commit, push.
3. Reply with both links and the in-game checks.
A bugfix is the stage's next fix build (`devNNN_01`, `devNNN_02`) and is hosted exactly the same way.

## SavedVariables
1. The author uploads the files from `WTF/Account/<account>/SavedVariables/` and names the version.
2. Commit them to `savedvariables/<version>/` with a line in `savedvariables/README.md` (what is in it, the size).
3. The harness reads them straight from the scratch checkout: `MYADDON_REAL_SAVES=<scratch checkout>/savedvariables sh tools/harness/validate_all.sh` loads every `<version>/<Addon>.lua`. In a Claude.ai project, also keep a copy in the project files (`/mnt/project-files/savedvariables/<version>/`).
4. Never commit real saves to an addon repo.

## Handover packs
1. Build the pack folder, zip it as `<pack>-<date>-vN.zip`.
2. Put the zip **and every file unzipped** (`<pack>-files/`) in both `docs/handover-packs/latest/` and `docs/handover-packs/versions/<date>-vN/`.
3. Update `docs/handover-packs/README.md`: what each pack is for, when to use it, the restart steps, a version line.
4. Reply with the zip link and a link to the folder of unzipped files.

## Plans, feature designs and issue notes (05 rule 10)
- A piece of work gets `docs/latest/<project>/` with its analysis, plan and feature design; update the files as decisions come in, with dates.
- At a project or feature release, copy the set to `docs/<project>/` (history) and zip it as `docs/<project>-<YYYY-MM-DD-hh-mm>.zip`.
- An issue that needs a long explanation gets `docs/latest/issues/<topic>.md`, linked from the issue.

## Release summaries
- After a production release, copy its notes (the mirror job's summary) to `summary/<Addon>-<version>.md` and add a line to `summary/README.md`.

## Keeping it readable
- Update the root README.md whenever a folder is added or the newest file in it changes.
- Never delete or rename a file someone was given a link to. Add the new one beside it; if something moved, leave the old path in place.
