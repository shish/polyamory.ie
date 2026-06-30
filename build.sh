#!/bin/sh

color='#dddddd'

for dotfile in $(find content -name "*.dot"); do
	svgfile=$(dirname "$dotfile")/$(basename "$dotfile" .dot).svg
	echo "Generating $svgfile"
	neato -Tsvg \
	    -Gbgcolor=transparent \
		-Ncolor="$color" \
		-Nfontcolor="$color" \
		-Ecolor="$color" \
		-Edir=none \
		"$dotfile" -o "$svgfile"
done
