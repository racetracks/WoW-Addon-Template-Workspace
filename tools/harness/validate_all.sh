#!/bin/sh
# Runs every harness check against the addon in this repo and, when
# MYADDON_REAL_SAVES names a folder of real saves (<version>/MyAddon.lua),
# against each of those too. Ends with 0 FAIL or exits 1.
#   sh tools/harness/validate_all.sh   (from the repo root)
here=$(dirname "$0")
fail=0

run() {
	out=$(lua5.1 "$here/run.lua" . "$1" - "$2" 2>&1) || fail=1
	echo "$out"
	echo "$out" | grep -q '^FAIL\|^ERROR' && fail=1
}

for check in "$here"/check_*.lua; do
	echo "== $check (fresh install)"
	run - "$check"
	if [ -n "$MYADDON_REAL_SAVES" ]; then
		for sv in "$MYADDON_REAL_SAVES"/*/MyAddon.lua; do
			[ -f "$sv" ] || continue
			echo "== $check ($sv)"
			run "$sv" "$check"
		done
	fi
done

if [ $fail -eq 0 ]; then echo "0 FAIL"; else echo "FAILURES above"; fi
exit $fail
