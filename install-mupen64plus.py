#!/usr/bin/python3
import configparser, os

# Some defaults
mupen64plus_config_section_name = "Input-SDL-Control1"

# Read SETTINGS.env settings
xpad_device, xpad_name, conf_file = None, None, None
with open(os.path.dirname(__file__) + "/SETTINGS.env") as settingfile:
	for line in settingfile:
		key, val = line.partition("=")[::2]
		if key == "XPAD_ID":
			xpad_device = val.strip().replace('"','')
		elif key == "XPAD_NAME":
			xpad_name = val.strip().replace('"','')
		elif key == "MUPEN64PLUS_PATH":
			conf_file = os.path.expandvars(val.strip()).replace('"','') + "/mupen64plus.cfg"

settingfile.close()

if (xpad_device == None or xpad_name == None or conf_file == None):
	print(os.path.dirname(__file__) + "'/SETTINGS.env file not found")
	quit()

# The key mapping
KEY_MAPPING = {
	"version": "2",
	"mode": "0",
	"device": xpad_device,
	"name": '"' + xpad_name + '"',
	"plugged": "True",
	"plugin": "2",
	"mouse": "False",
	"MouseSensitivity": '"2,00,2,00"',
	"AnalogDeadzone": '"4096,4096"',
	"AnalogPeak": '"32768,32768"',
	"DPad R": '"hat(0 Right)"',
	"DPad L": '"hat(0 Left)"',
	"DPad D": '"hat(0 Down)"',
	"DPad U": '"hat(0 Up)"',
	"Start": '"button(7)"',
	"Z Trig": '"axis(2+)"',
	"B Button": '"button(3)"',
	"A Button": '"button(0)"',
	"C Button R": '"axis(3+)"',
	"C Button L": '"axis(3-)"',
	"C Button D": '"axis(4+)"',
	"C Button U": '"axis(4-)"',
	"R Trig": '"button(5)"',
	"L Trig": '"button(4)"',
	"Mempak switch": '"button(6)"',
	"Rumblepak switch": '"axis(5+)"',
	"X Axis": '"axis(0-,0+)"',
	"Y Axis": '"axis(1-,1+)"',
}

# Read current file, check the input section version
config = configparser.ConfigParser(allow_no_value=True)
config.optionxform = str
config.read(conf_file)

if not config.has_section(mupen64plus_config_section_name):
	config.add_section(mupen64plus_config_section_name)
else:
	if config[mupen64plus_config_section_name]["version"] != KEY_MAPPING["version"]:
		print( "version mismatch", config[mupen64plus_config_section_name]["version"], KEY_MAPPING["version"])
		quit()

section = config[mupen64plus_config_section_name]

# Update the mapping
for key in KEY_MAPPING:
	value = KEY_MAPPING[key]
	old_value = section.get(key)
	if old_value != value:
		print(key, " : ", old_value, " -> ", value)
		section[key] = value
	else:
		print(key, " : ", old_value, " already up to date")

# Save file
with open(conf_file, 'w') as configfile:
	config.write(configfile)
