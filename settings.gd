extends Node

# Variables
var music = true
var sounds = true
var camera_fixed = true

# File saving
const SAVE_FILE_PATH := "user://settings.json"

# Called when the game starts
func _ready():
	load_data()

func save_settings():
	var data = {
		"music": music,
		"sounds": sounds,
		"camera_fixed": camera_fixed
	}

	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func load_data():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return

	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()
		var result = JSON.parse_string(content)
		if typeof(result) == TYPE_DICTIONARY:
			music = result.get("music", true)
			sounds = result.get("sounds", true)
			camera_fixed = result.get("camera_fixed", true)
