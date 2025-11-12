extends CanvasLayer

signal resumed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		handle_pause()


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_resume_pressed():
	handle_pause()
	
func handle_pause():
	get_tree().paused = !get_tree().paused
	self.visible = !self.visible
	
