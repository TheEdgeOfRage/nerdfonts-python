#!/usr/bin/env bash

set -e

SOURCE_DIR="$(dirname $0)"
SCRIPTS_DIR="$SOURCE_DIR/tmp"
OUTPUT_FILE="$SOURCE_DIR/icons.py"
URL="https://github.com/ryanoasis/nerd-fonts/raw/master/bin/scripts/lib/"
SCRIPTS=("i_fa.sh" "i_weather.sh" "i_all.sh" "i_pom.sh" "i_cod.sh" "i_oct.sh" "i_dev.sh" "i_seti.sh" "i_material.sh" "i_md.sh" "i_logos.sh" "i_ple.sh" "i_fae.sh" "i_iec.sh")

rm -rf "$SCRIPTS_DIR"
mkdir "$SCRIPTS_DIR"
for S in "${SCRIPTS[@]}"; do
    wget -q "$URL/$S" -P "$SCRIPTS_DIR"
done

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

