extends Node2D

var lap_count = 3
var checkpoint_count = 0
var started = false

var finish_scene = load("res://scenes/finish_screen.tscn")

func level_done():
	Times.last_played = $UI/Timer.wait_time - $UI/Timer.time_left
	if Times.level3 == null or Times.level3 > Times.last_played:
		Times.level3 = Times.last_played
		Times.was_new_best = true
	
	# Call save data
	Times.save_data()
	
	$UI.stop_ui
	$UI.visible = false
	$Player.movement_disabled = true
	var finish_screen = finish_scene.instantiate()
	finish_screen.replay_scene = "res://scenes/level_3.tscn"
	add_child(finish_screen)
	

func _ready():
	Times.was_new_best = false
	$Finish.connect("passed", _on_finish_passed)
	$UI.update_ui(lap_count)
	
	_connect_checkpoints()
	_connect_level_changes()

func _connect_checkpoints():
	var checkpoints = $Parts/Checkpoints.get_children()
	checkpoint_count = checkpoints.size()
	
	for cp in checkpoints:
		cp.connect("passed", _on_checkpoint_passed)

func _connect_level_changes():
	var level_changes = $Parts/LevelChange.get_children()
	
	for lc in level_changes:
		lc.connect("passed", _on_level_change_passed)

func _physics_process(delta):
	if lap_count != 0:
		if Input.is_action_just_pressed("accelerate") and !started:
			$UI/Timer.start()
			started = true
		$UI.update_ui(lap_count)
	elif Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/level_3.tscn")

func _on_finish_passed():
	if $UI/Timer.is_stopped():
		return
	print(checkpoint_count)
	if checkpoint_count <= 0:
		lap_count -= 1
		print(lap_count)
		if lap_count == 0:
			level_done()
		checkpoint_count = $Parts/Checkpoints.get_child_count()

func _on_checkpoint_passed():
	print("Checkpoint passed")
	checkpoint_count -= 1

func _on_level_change_passed():
	$Player.z_index = ($Player.z_index % 2) + 1
