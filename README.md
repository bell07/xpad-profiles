# dolphin-emu-profiles
Input profiles for Dolphin emulator on Linux, Primary for GPD Win 2 and
other Xbox compatible controller

## Installation and Usage
Copy at least the "Wiimote" and "GCPad" folders to ~/.config/dolphin-emu/Profiles or ~/.dolphin-emu/Config/Profiles

After loading the profile you need to select your Xbox compatible joypad because the setting is not in profile file.

## Base profile
The Linux evdev driver "xpad" used for Xbox compatible controller send the next codes to the dolphin emulator:
![Xbox base profile](Xbox_Controller.svg)
Derivative work (added labels) of [Jishenaz / CC0](https://commons.wikimedia.org/wiki/File:Xbox_Controller.svg)

## Profile Wiimote/XB Horizontal.ini
This profile is optimized for WII Remote without attachments in horizontal mode.
<details>
  <summary>Show</summary>

![Wii Horizontal](WII_Horizontal.png)

is mapped to

![Wii Horizontal](XB_Horizontal.svg)

</details>


## Other profiles
Profile | Description
--- | ---
GCPad/XB\ default.ini | Xbox controller for Gamecube
