#!/bin/sh
# Prints the history.txt sections that make up a production release: the
# section of <version> and every section below it, down to (not including)
# the previous production version (one without a suffix). For the first
# production release that is every section in the file.
#   sh tools/collect_notes.sh 1.4.0 [history.txt]
ver=$1
file=${2:-history.txt}
if [ -z "$ver" ]; then echo "usage: sh tools/collect_notes.sh <version> [history.txt]" >&2; exit 1; fi

out=$(awk -v v="$ver" '
	/^=> / {
		split($0, a, " ")
		if (!on) { if (a[2] != v) next; on = 1 }
		else if (a[2] !~ /-/) exit
	}
	on { print }
' "$file")
if [ -z "$out" ]; then echo "no section '=> $ver ' in $file" >&2; exit 1; fi
printf '%s\n' "$out"
