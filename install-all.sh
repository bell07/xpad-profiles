#!/bin/sh

PROJ_DIR="$(dirname $0)"
source "$PROJ_DIR/SETTINGS.env" || exit 1

if [ -n "$DOLPHIN_PATH" ] && [ -d "$DOLPHIN_PATH" ]; then
	echo "*** Install Dolphin profiles"
	"$PROJ_DIR"/install-dolphin.sh
else
	echo "*** $DOLPHIN_PATH not found"
fi

if [ -n "$MUPEN64PLUS_PATH" ] && [ -d "$MUPEN64PLUS_PATH" ]; then
	echo "*** Install Mupen64plus profile"
	"$PROJ_DIR"/install-mupen64plus.py
else
	echo "*** $MUPEN64PLUS_PATH not found"
fi
