Copy into the new repo: .github/workflows/*, tools/check_rules.sh,
tools/bump_version.sh, and the TOC set
into the main addon folder (MyAddon/). Rename MyAddon everywhere. Add
tools/check_style.lua and tools/check_layers.lua from ../examples (adapt names)
or drop their lines from check_rules.sh. history.txt and readme.txt sit at the
repo root; release.yml copies them into the main folder of the zip.
