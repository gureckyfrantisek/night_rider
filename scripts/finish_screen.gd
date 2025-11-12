extends CanvasLayer

var replay_scene

func _ready():
	if Times.was_new_best:
		$VBoxContainer/ColorRect/Label.text = 'NEW RECORD!\nTime: ' + str(snappedf(Times.last_played, 0.001)) + 's'
	else:
		$VBoxContainer/ColorRect/Label.text = 'Level Fished!\nTime: ' + str(snappedf(Times.last_played, 0.001)) + 's'


func _on_restart_pressed():
	get_tree().change_scene_to_file(replay_scene)


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
