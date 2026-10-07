# Layout: easily human-readable folders

One scratch repo per addon repo, named after it with `-Scratch` (05 rules 4 to 8). For this project: **racetracks/WoW-Addon-Template-Scratch**.

```
README.md                               the index: one line per folder, newest file named
releases/                               every test zip built before the release workflow publishes it
  README.md                             what is here; read me when confused
  <Addon>-<version>-<YYYY-MM-DD-hh-mm>.zip   one per build, never overwritten
latest/
  README.md                             which version the latest zip is, and when it was built
  <Addon>-latest.zip                    always the newest build; the link never changes
savedvariables/
  README.md                             one line per version folder: what is in it, the size
  <version>/<Addon>.lua                 the author's WTF saves written by that addon version
docs/
  README.md                             which document set is which
  latest/<project>/                     the current markdown of each project or feature, in folders
  <project>/                            history: the files as they stood at each docs release
  <project>-<YYYY-MM-DD-hh-mm>.zip      every docs release, zipped
  handover-packs/                       handover packs (they are documentation zips, 05 rule 10):
    latest/<pack>-<date>-vN.zip, latest/<pack>-files/     newest zip plus every file unzipped
    versions/<date>-vN/                 the same, frozen per version
summary/
  README.md                             what is here
  <Addon>-<version>.md                  the release notes of each production release (the mirror job's summary)
```

## Naming
- Folder names are plain words, not codes.
- Timestamps are `YYYY-MM-DD-hh-mm` in UTC (05 rule 2); pack versions are `<date>-vN`.
- Zip names carry the version: `<Addon>-1.4.0-dev004_01-2026-10-07-21-30.zip`, `<pack>-2026-10-07-v2.zip`.
- Saves are filed by the version the author names ("this is a 1.2.0 save"), not by the date.

## Reconciled on 2026-10-07
The v2 pack's first layout (`<Addon>/test-builds/`, `<addon>-projects/`, `handover-packs/` at the root) predates the author's rules 4 to 10 in 05_RULES.md. This layout follows the rules: rule 6 asks for a "features" folder; features and projects are the child folders of `docs/`.
