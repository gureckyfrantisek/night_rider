extends Node

var was_new_best = false
var last_played = null

var level1 = null
var level2 = null
var level3 = null
var level4 = null
var level5 = null
var level6 = null
var level7 = null
var level8 = null
var level9 = null
var level10 = null


# File saving
const SAVE_FILE_PATH := "user://save_data.json"

# Called when the game starts
func _ready():
	load_data()

func save_data():
	var data = {
		"level1": level1,
		"level2": level2,
		"level3": level3,
		"level4": level4,
		"level5": level5,
		"level6": level6,
		"level7": level7,
		"level8": level8,
		"level9": level9,
		"level10": level10
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
			level1 = result.get("level1", null)
			level2 = result.get("level2", null)
			level3 = result.get("level3", null)
			level4 = result.get("level4", null)
			level5 = result.get("level5", null)
			level6 = result.get("level6", null)
			level7 = result.get("level7", null)
			level8 = result.get("level8", null)
			level9 = result.get("level9", null)
			level10 = result.get("level10", null)
