# Handover packs: read me when you're confused

The packs you attach to a **fresh Claude project** when a thread gets too long.

| Pack | What it's for | When to use it |
| --- | --- | --- |
| `wow-addon-baseline-<date>-vN.zip` | Rules, frameworks, preferences, references and the release pipeline for any WoW addon | Every addon project |
| `scratch-repo-usage-<date>-vN.zip` | How this repo is set up and used | Every addon project |
| `<addon>-handover-<date>-vN.zip` | One addon's purpose, repos, data, plans and status | Restarting that addon |

## Folders
```
latest/               newest zips, plus <pack>-files/ with every file unzipped
versions/<date>-vN/   the same, frozen per version
```

## How to restart an addon project
1. New Claude project; attach the addon repo and scratch.
2. Paste the project instructions from the addon pack (or the baseline's template, filled in).
3. Upload the baseline, the scratch pack and the addon pack, and ask Claude to read them and confirm the next step.

## Versions
| Pack | Version | Date | Notes |
| --- | --- | --- | --- |
