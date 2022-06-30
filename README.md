Archived: xpad-profiles is ported into python in https://github.com/bell07/joypad-profiles


# xpad-profiles

Profiles for Xbox compatible controller with Linux evdev driver "xpad". 
The repo contains collection my configurations collection for misc games and emulators.

All xbox controller pictures are derivative work (added labels) of [Jishenaz / CC0](https://commons.wikimedia.org/wiki/File:Xbox_Controller.svg)

## Installation

 - Copy `SETTINGS.env.example` to `SETTINGS.env`. 
 - Adjust the settings file matching your joypad
 - run the installation scripts you need

## Installation scripts

Install Script | Description
--- | ---
install-all.sh | Call all scripts bellow if corresponding settings path exists
install-dolphin.sh | Install Wiimote and GCPad profiles for Dolphin emulator
install-mupen64plus.py | Install the config for mupen64plus - N64 emulator

## Usage
Just play the games ;-)

# Base profile
The Linux evdev driver "xpad" used for Xbox compatible controller send the next codes. The configurations works only if your controller sends the same data.
<details><summary>Show base profile configuration</summary>

![Xbox base profile](Xbox_Controller.svg)

`evtest /dev/input/by-id/usb-*event-joystick`

```
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 304 (BTN_SOUTH)
    Event code 305 (BTN_EAST)
    Event code 307 (BTN_NORTH)
    Event code 308 (BTN_WEST)
    Event code 310 (BTN_TL)
    Event code 311 (BTN_TR)
    Event code 314 (BTN_SELECT)
    Event code 315 (BTN_START)
    Event code 316 (BTN_MODE)
    Event code 317 (BTN_THUMBL)
    Event code 318 (BTN_THUMBR)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value      0
      Min   -32768
      Max    32767
      Fuzz      16
      Flat     128
    Event code 1 (ABS_Y)
      Value      0
      Min   -32768
      Max    32767
      Fuzz      16
      Flat     128
    Event code 2 (ABS_Z)
      Value      0
      Min        0
      Max      255
    Event code 3 (ABS_RX)
      Value      0
      Min   -32768
      Max    32767
      Fuzz      16
      Flat     128
    Event code 4 (ABS_RY)
      Value      0
      Min   -32768
      Max    32767
      Fuzz      16
      Flat     128
    Event code 5 (ABS_RZ)
      Value      0
      Min        0
      Max      255
    Event code 16 (ABS_HAT0X)
      Value      0
      Min       -1
      Max        1
    Event code 17 (ABS_HAT0Y)
      Value      0
      Min       -1
      Max        1
```

</details>

# Mupen64plus emulator for Nintendo 64

<details><summary>Nintendo 64</summary>

![Nintendo 64](XB%20mupen64plus.svg)
 
</details>

# Dolphin emulator for Nintendo GameCube

<details><summary>Gamecube</summary>

![Gamecube](dolphin/GCPad/XB%20default.svg)
 
</details>

# Dolphin emulator for Nintendo WII
In addition to the gamepad the pointer device is configured for WII.
The XInput2 virtual core pointer cursor is allways enables, so mouse movements are used for pointr.

If touchscreen is configured in SETTINGS.env
 - the touch is configured for pointer move
 - the double-tap is configured for A-Key

If mouse is configured in SETTINGS.env
 - the left mouse button is configured for A-Key
 - the right mouse button is configured for B-Key

For some games the GameSettings ini file is included that enables the right profile for the game.

<details><summary>WII Horizontal</summary>

- SMN - New Super Mario Bros. Wii
- MRR - New Super Mario Bros.  Retro edition
- NSS - New Super Mario Bros. Summer Sun Special
- R8P - Super Paper Mario
 
![WI Horizontal](dolphin/Wiimote/XB%20Horizontal.svg)
 
</details>

<details><summary>WII with Nunchuk</summary>

- RMG - Super Mario Galaxy
- SB4 - Super Mario Galaxy 2
 
![WI with Nunchuk](dolphin/Wiimote/XB%20with%20Nunchuk.svg)
 
</details>
