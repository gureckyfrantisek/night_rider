extends RigidBody2D

var friction = 30
var is_on_water = false
var is_on_grass = false

func _physics_process(delta):
	if is_on_water:
		friction = -250
	elif is_on_grass:
		friction = -150
	else:
		friction = -100
	
	if linear_velocity.length() > 0.01:
		linear_velocity += linear_velocity.normalized() * friction * delta
	else:
		linear_velocity = Vector2.ZERO
	
	if angular_velocity > 0.01:
		angular_velocity += friction * delta
	else:
		angular_velocity = 0


func _on_grass_body_entered(body):
	is_on_grass = true


func _on_grass_body_exited(body):
	is_on_grass = false


func _on_water_body_entered(body):
	is_on_water = true


func _on_water_body_exited(body):
	is_on_water = false
