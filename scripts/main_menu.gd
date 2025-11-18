extends CanvasLayer

var time_precission = 0.001

func _ready():
	get_tree().paused = false
	$Settings/Camera/Fixed.button_pressed = Settings.camera_fixed
	$Settings/Sounds/Music.button_pressed = Settings.music
	$Settings/Sounds/Sounds.button_pressed = Settings.sounds
	
	if Settings.music:
		$Music.play()

func _on_level_1_mouse_entered():
	if Times.level1 == null:
		$Levels/LevelsTop/Level1.text = 'Level 1\nNo time yet\nPlay'
	else:
		$Levels/LevelsTop/Level1.text = 'Level 1\nTime: ' + str(snappedf(Times.level1, time_precission)) + 's\nPlay'


func _on_level_1_mouse_exited():
	$Levels/LevelsTop/Level1.text = 'Level 1'


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_level_2_mouse_entered():
	if Times.level2 == null:
		$Levels/LevelsTop/Level2.text = 'Level 2\nNo time yet\nPlay'
	else:
		$Levels/LevelsTop/Level2.text = 'Level 2\nTime: ' + str(snappedf(Times.level2, time_precission)) + 's\nPlay'

func _on_level_2_mouse_exited():
	$Levels/LevelsTop/Level2.text = 'Level 2'


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")


func _on_level_3_mouse_entered() -> void:
	if Times.level3 == null:
		$Levels/LevelsTop/Level3.text = 'Level 3\nNo time yet\nPlay'
	else:
		$Levels/LevelsTop/Level3.text = 'Level 3\nTime: ' + str(snappedf(Times.level3, time_precission)) + 's\nPlay'


func _on_level_3_mouse_exited() -> void:
	$Levels/LevelsTop/Level3.text = 'Level 3'

func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")


func _on_level_4_mouse_entered() -> void:
	if Times.level4 == null:
		$Levels/LevelsTop/Level4.text = 'Level 4\nNo time yet\nPlay'
	else:
		$Levels/LevelsTop/Level4.text = 'Level 4\nTime: ' + str(snappedf(Times.level4, time_precission)) + 's\nPlay'


func _on_level_4_mouse_exited() -> void:
	$Levels/LevelsTop/Level4.text = 'Level 4'

func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://scenes/level_4.tscn")

func _on_level_5_mouse_entered() -> void:
	if Times.level5 == null:
		$Levels/LevelsTop/Level5.text = 'Level 5\nNo time yet\nPlay'
	else:
		$Levels/LevelsTop/Level5.text = 'Level 5\nTime: ' + str(snappedf(Times.level5, time_precission)) + 's\nPlay'


func _on_level_5_mouse_exited() -> void:
	$Levels/LevelsTop/Level5.text = 'Level 5'

func _on_level_5_pressed():
	get_tree().change_scene_to_file("res://scenes/level_5.tscn")

func _on_level_6_mouse_entered() -> void:
	if Times.level6 == null:
		$Levels/LevelsBot/Level6.text = 'Level 6\nNo time yet\nPlay'
	else:
		$Levels/LevelsBot/Level6.text = 'Level 6\nTime: ' + str(snappedf(Times.level6, time_precission)) + 's\nPlay'

func _on_level_6_mouse_exited() -> void:
	$Levels/LevelsBot/Level6.text = 'Level 6'

func _on_level_6_pressed():
	get_tree().change_scene_to_file("res://scenes/level_6.tscn")

func _on_level_7_mouse_entered() -> void:
	if Times.level7 == null:
		$Levels/LevelsBot/Level7.text = 'Level 7\nNo time yet\nPlay'
	else:
		$Levels/LevelsBot/Level7.text = 'Level 7\nTime: ' + str(snappedf(Times.level7, time_precission)) + 's\nPlay'

func _on_level_7_mouse_exited() -> void:
	$Levels/LevelsBot/Level7.text = 'Level 7'

func _on_level_7_pressed():
	get_tree().change_scene_to_file("res://scenes/level_7.tscn")

func _on_level_8_mouse_entered() -> void:
	if Times.level8 == null:
		$Levels/LevelsBot/Level8.text = 'Level 8\nNo time yet\nPlay'
	else:
		$Levels/LevelsBot/Level8.text = 'Level 8\nTime: ' + str(snappedf(Times.level8, time_precission)) + 's\nPlay'

func _on_level_8_mouse_exited() -> void:
	$Levels/LevelsBot/Level8.text = 'Level 8'

func _on_level_8_pressed():
	get_tree().change_scene_to_file("res://scenes/level_8.tscn")

func _on_level_9_mouse_entered() -> void:
	if Times.level9 == null:
		$Levels/LevelsBot/Level9.text = 'Level 9\nNo time yet\nPlay'
	else:
		$Levels/LevelsBot/Level9.text = 'Level 9\nTime: ' + str(snappedf(Times.level9, time_precission)) + 's\nPlay'

func _on_level_9_mouse_exited() -> void:
	$Levels/LevelsBot/Level9.text = 'Level 9'

func _on_level_9_pressed():
	get_tree().change_scene_to_file("res://scenes/level_9.tscn")

func _on_level_10_mouse_entered() -> void:
	if Times.level10 == null:
		$Levels/LevelsBot/Level10.text = 'Level 10\nNo time yet\nPlay'
	else:
		$Levels/LevelsBot/Level10.text = 'Level 10\nTime: ' + str(snappedf(Times.level10, time_precission)) + 's\nPlay'

func _on_level_10_mouse_exited() -> void:
	$Levels/LevelsBot/Level10.text = 'Level 10'

func _on_level_10_pressed():
	get_tree().change_scene_to_file("res://scenes/level_10.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_bonus_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_bonus.tscn")


func _on_bonus_mouse_entered() -> void:
	if Times.bonus == null:
		$Levels/BONUS/Bonus.text = 'BONUS\nNo time yet\nPlay'
	else:
		$Levels/BONUS/Bonus.text = 'BONUS\nTime: ' + str(snappedf(Times.bonus, time_precission)) + 's\nPlay'


func _on_bonus_mouse_exited() -> void:
	$Levels/BONUS/Bonus.text = 'BONUS'


func _on_fixed_toggled(toggled_on: bool) -> void:
	Settings.camera_fixed = $Settings/Camera/Fixed.button_pressed
	Settings.save_settings()


func _on_music_toggled(toggled_on: bool) -> void:
	Settings.music = $Settings/Sounds/Music.button_pressed
	Settings.save_settings()
	
	if $Music.playing and not Settings.music:
		$Music.stop()
	elif not $Music.playing and Settings.music:
		$Music.play()


func _on_sounds_toggled(toggled_on: bool) -> void:
	Settings.sounds = $Settings/Sounds/Sounds.button_pressed
	Settings.save_settings()
