#!/usr/bin/env bash

SOURCE_DIR="$(dirname $0)"
SCRIPTS_DIR="$SOURCE_DIR/tmp"
OUTPUT_FILE="$SOURCE_DIR/icons.py"

if [ -z "$1" ]; then
	BRANCH="trunk"
	VERSION="latest"
else
	BRANCH="branches/$1"
	VERSION="$1"
fi

URL="https://github.com/ryanoasis/nerd-fonts/$BRANCH/bin/scripts/lib"

rm -rf "$SCRIPTS_DIR"
svn checkout "$URL" "$SCRIPTS_DIR"

source "$SCRIPTS_DIR/i_all.sh"
rm -rf "$SCRIPTS_DIR"

echo "VERSION = \"$VERSION\"" >  "$OUTPUT_FILE"
echo ""                       >> "$OUTPUT_FILE"
echo "icons = {"              >> "$OUTPUT_FILE"

INDENT="    "
for var in "${!i_@}"; do
	name="$(echo $var | cut -c3-)"
	eval "icon=\$$var"
	echo "$INDENT\"$name\": \"$icon\"," >> "$OUTPUT_FILE"
done

truncate -s-2 "$OUTPUT_FILE"

echo ""  >> "$OUTPUT_FILE"
echo "}" >> "$OUTPUT_FILE"
