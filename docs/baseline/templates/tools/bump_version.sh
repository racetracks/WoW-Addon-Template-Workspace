#!/bin/sh
# Sets the next version in every TOC and adds its history.txt section on top.
#   sh tools/bump_version.sh stage "Title"          next stage:  1.4.0-dev003    -> 1.4.0-dev004
#                                                                1.4.0-dev003_02 -> 1.4.0-dev004
#   sh tools/bump_version.sh fix "Title"            a fix build: 1.4.0-dev003    -> 1.4.0-dev003_01
#                                                                1.4.0-dev003_01 -> 1.4.0-dev003_02
#   sh tools/bump_version.sh release "Title"        production:  1.4.0-dev006_02 -> 1.4.0
#   sh tools/bump_version.sh line X.Y.Z "Title"     a new line:  -> X.Y.Z-dev001
# Run from the repo root, then fill in the history bullets.
mode=$1
case "$mode" in
	line) line=$2; title=$3 ;;
	stage|fix|release) title=$2 ;;
	*) echo "usage: sh tools/bump_version.sh stage|fix|release \"Title\"  or  line X.Y.Z \"Title\""; exit 1 ;;
esac
if [ -z "$title" ]; then echo "a title is needed"; exit 1; fi

ver=$(sed -n 's/^## Version: *//p' MyAddon/MyAddon.toc | tr -d '\r')
base=${ver%%-*}
dev=$(echo "$ver" | sed -n 's/^[^-]*-dev\([0-9]\{3\}\).*$/\1/p' | sed 's/^0*//')
fixno=$(echo "$ver" | sed -n 's/^.*_\([0-9]\{2\}\)$/\1/p' | sed 's/^0*//')

case "$mode" in
	stage)
		if [ -z "$dev" ]; then echo "$ver is a production version: start a new line with 'line'"; exit 1; fi
		if [ "$dev" -ge 999 ]; then echo "dev999 is the last stage number"; exit 1; fi
		new=$(printf '%s-dev%03d' "$base" $((dev + 1)))
		;;
	fix)
		if [ -z "$dev" ]; then echo "$ver is a production version: fixes start a new line with 'line'"; exit 1; fi
		if [ "${fixno:-0}" -ge 99 ]; then echo "_99 is the last fix number"; exit 1; fi
		new=$(printf '%s-dev%03d_%02d' "$base" "$dev" $((${fixno:-0} + 1)))
		;;
	release)
		if [ -z "$dev" ]; then echo "$ver is already a production version"; exit 1; fi
		new=$base
		;;
	line)
		if ! echo "$line" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then echo "line must be X.Y.Z"; exit 1; fi
		new=$line-dev001
		;;
esac

for toc in MyAddon*/*.toc; do
	sed "s/^## Version: .*/## Version: $new/" "$toc" > "$toc.new" && mv "$toc.new" "$toc"
done
{
	printf '=> %s - %s\n- What changed, in plain words.\n- Version %s.\n\n' "$new" "$title" "$new"
	cat history.txt
} > history.txt.new && mv history.txt.new history.txt
echo "$ver -> $new"
