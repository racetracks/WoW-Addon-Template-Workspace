# Setting up scratch (once)

1. GitHub > New repository > name it after the addon repo with `-Scratch` (this project: `racetracks/WoW-Addon-Template-Scratch`), **Private**, initialise with a README.
2. Install the Claude GitHub App on it so Claude sessions can push: https://github.com/apps/claude/installations/select_target
3. Attach `scratch` to every Claude addon project, next to the addon repo.
4. Copy `templates/README.md` to the repo root as the index, and `templates/handover-packs-README.md` to `docs/handover-packs/README.md`. Create the mandatory folders, each with a README (05 rules 4 to 8 and 11): `releases/`, `latest/`, `savedvariables/`, `docs/`, `summary/`.
5. In a Claude session, check access with `git ls-remote https://github.com/racetracks/WoW-Addon-Template-Scratch` (or the attached checkout) before relying on it.

Links work for the author while signed in to GitHub, because the repo is private.
