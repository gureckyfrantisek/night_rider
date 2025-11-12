extends Node2D

var lap_count = 3
var started = false

var finish_scene = load("res://scenes/finish_screen.tscn")

func level_done():
	Times.last_played = $UI/Timer.wait_time - $UI/Timer.time_left
	if Times.level9 == null or Times.level9 > Times.last_played:
		Times.level9 = Times.last_played
		Times.was_new_best = true
	
	# Call save data
	Times.save_data()
	
	$UI.stop_ui
	$UI.visible = false
	$Player.movement_disabled = true
	var finish_screen = finish_scene.instantiate()
	finish_screen.replay_scene = "res://scenes/level_9.tscn"
	add_child(finish_screen)
	

func _ready():
	Times.was_new_best = false
	$Finish.connect("passed", _on_finish_passed)
	$UI.update_ui(lap_count)

func _physics_process(delta):
	if lap_count != 0:
		if Input.is_action_just_pressed("accelerate") and !started:
			$UI/Timer.start()
			started = true
		$UI.update_ui(lap_count)
	elif Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/level_9.tscn")

func _on_finish_passed():
	if $UI/Timer.is_stopped():
		return
	lap_count -= 1
	print(lap_count)
	if lap_count == 0:
		level_done()
