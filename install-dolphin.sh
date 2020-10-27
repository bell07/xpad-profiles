#!/bin/sh

PROJ_DIR="$(dirname $0)"/dolphin/
source "$PROJ_DIR/../SETTINGS.env" || exit 1

function die(){
	echo "${@}"
	exit 1
}

function install_profile() {
	TYPE="$1"
	INI_FILE="$(basename "$2")"
	echo "Process $TYPE/$INI_FILE"
	cp "$PROJ_DIR"/"$TYPE"/"$INI_FILE" "$DOLPHIN_PATH"/Profiles/"$TYPE"/"$INI_FILE"
	echo "Device = evdev/$XPAD_ID/$XPAD_NAME" >> "$DOLPHIN_PATH"/Profiles/"$TYPE"/"$INI_FILE"
}

[[ -d "$DOLPHIN_PATH" ]] || die "DOLPHIN_PATH=$DOLPHIN_PATH is not valid path"

echo "Use $DOLPHIN_PATH"

## Copy WII configs
mkdir -p "$DOLPHIN_PATH"/Profiles/Wiimote/ || die "Cannot create $DOLPHIN_PATH/Profiles/Wiimote/"
find "$PROJ_DIR"/Wiimote/ -name '*.ini' | while read ini_file; do
	install_profile Wiimote "$ini_file"
done

if [[ -f "$DOLPHIN_WII_DEFAULT" ]]; then
	cp "$DOLPHIN_PATH"/Profiles/Wiimote/"$DOLPHIN_WII_DEFAULT" "$DOLPHIN_PATH"/GCPadNew.ini
	sed -i 's/\[Profile\]/\[GCPad1\]/g' "$DOLPHIN_PATH"/GCPadNew.ini
fi

## Copy Gamecube configuration - only 1 config ;-)
mkdir -p "$DOLPHIN_PATH"/Profiles/GCPad/   || die "Cannot create $DOLPHIN_PATH/Profiles/GCPad/"
install_profile GCPad "XB default.ini"

cp "$DOLPHIN_PATH"/Profiles/GCPad/"XB default.ini" "$DOLPHIN_PATH"/WiimoteNew.ini
sed -i 's/\[Profile\]/\[Wiimote1]/g' "$DOLPHIN_PATH"/WiimoteNew.ini

[[ -d "$DOLPHIN_GAMESETTINGS" ]] || die "DOLPHIN_GAMESETTINGS=$DOLPHIN_GAMESETTINGS invalid"
echo "Install game profiles"
cp -av "$PROJ_DIR"/GameSettings/*.ini "$DOLPHIN_GAMESETTINGS"
