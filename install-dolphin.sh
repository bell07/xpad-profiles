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
	TARGET_FILE="$DOLPHIN_PATH"/Profiles/"$TYPE"/"$INI_FILE"
	echo "Process $TYPE/$INI_FILE"
	cp "$PROJ_DIR"/"$TYPE"/"$INI_FILE" "$TARGET_FILE"
	echo "Device = evdev/$XPAD_ID/$XPAD_NAME" >> "$TARGET_FILE"
	if [ -n "$MOUSE_NAME" ]; then
		sed -i s='%MOUSE%'="evdev/$MOUSE_ID/$MOUSE_NAME"=g "$TARGET_FILE"
	else
		# Remove all mouse entries
		sed -i s=' *| *`%MOUSE%:[^|]*`'=""=g "$TARGET_FILE"
		sed -i s=' *| *[a-z]*(`%MOUSE%:[^|]*`.*)'=""=g "$TARGET_FILE"
	fi
	if [ -n "$TOUCH_NAME" ]; then
		sed -i s='%TOUCH%'="evdev/$TOUCH_ID/$TOUCH_NAME"=g "$TARGET_FILE"
		## Disable generic pointer ???
		#sed -i s=' *| *`XInput2/0/Virtual core pointer:Cursor[^|]*`'=""=g "$TARGET_FILE"
	else
		# Remove all touchscreens
		sed -i s=' *| *`%TOUCH%:[^|]*`'=""=g "$TARGET_FILE"
		sed -i s=' *| *[a-z]*(`%TOUCH%:[^|]*`.*)'=""=g "$TARGET_FILE"
	fi
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
