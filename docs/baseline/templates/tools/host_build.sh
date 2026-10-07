#!/bin/sh
# Builds the test zip from the committed HEAD and hosts it on the scratch
# repo (docs/scratch/04_USAGE.md): releases/<Addon>-<version>-<stamp>.zip,
# latest/<Addon>-latest.zip and latest/README.md, one commit, pushed to main.
# Prints the links. Run from the addon repo root.
#   sh tools/host_build.sh <scratch checkout> [--no-push]
ADDON=MyAddon
SCRATCH_URL=https://github.com/racetracks/WoW-Addon-Template-Scratch
scratch=$1
push=yes
[ "$2" = "--no-push" ] && push=no
if [ -z "$scratch" ] || [ ! -d "$scratch/.git" ]; then
	echo "usage: sh tools/host_build.sh <scratch checkout> [--no-push]"
	exit 1
fi
if [ -n "$(git status --porcelain -- "$ADDON" "$ADDON"_* readme.txt history.txt 2>/dev/null)" ]; then
	echo "Commit the addon changes first: the zip is built from HEAD"
	exit 1
fi

ver=$(sed -n 's/^## Version: *//p' "$ADDON/$ADDON.toc" | tr -d '\r')
stamp=$(date -u +%Y-%m-%d-%H-%M)
commit=$(git rev-parse --short HEAD)
name=$ADDON-$ver-$stamp.zip

work=$(mktemp -d)
git archive HEAD | tar -x -C "$work" || exit 1
mkdir "$work/zip"
for d in "$work/$ADDON" "$work/$ADDON"_*/; do
	if [ -d "$d" ]; then cp -r "${d%/}" "$work/zip/"; fi
done
cp "$work/readme.txt" "$work/history.txt" "$work/zip/$ADDON/"
(cd "$work/zip" && zip -qr "../$name" .) || exit 1

cd "$scratch" || exit 1
if git rev-parse -q --verify origin/main >/dev/null 2>&1 || git ls-remote --exit-code origin main >/dev/null 2>&1; then
	git pull -q origin main || exit 1
fi
mkdir -p releases latest
cp "$work/$name" "releases/$name"
cp "$work/$name" "latest/$ADDON-latest.zip"
cat > latest/README.md <<EOF
# Latest test build

\`$ADDON-latest.zip\` is always the newest build. It is currently **$ver**, built $stamp UTC
from commit $commit; the same zip is kept as \`releases/$name\`.

Install: extract the zip into \`World of Warcraft/_retail_/Interface/AddOns/\`.
EOF
if [ ! -f releases/README.md ]; then
	cat > releases/README.md <<EOF
# Releases: every test build

One zip per test build, named \`<Addon>-<version>-<YYYY-MM-DD-hh-mm>.zip\` (UTC), never
overwritten. The newest is also in \`latest/\`. Published releases live on the addon repo's
GitHub Releases page.
EOF
fi
rm -rf "$work"

git add releases latest
git commit -q -m "$ADDON $ver test build ($stamp)" || exit 1
if [ $push = yes ]; then
	git push -q origin HEAD:main || exit 1
fi
echo "$SCRATCH_URL/raw/main/releases/$name"
echo "$SCRATCH_URL/raw/main/latest/$ADDON-latest.zip"
