extends CharacterBody2D

var acceleration = 3
var brake_power = 5
var top_speed = 10
var deceleration = 2
var max_steer = 3
var steering_sens = 10
var current_speed = 0
var current_steer = 0
var movement_disabled = false

func get_steering(delta):
	if Input.is_action_pressed("steer_left") and current_speed != 0:
		if current_steer > 0:
			current_steer -= steering_sens * delta
		current_steer -= steering_sens * delta
		if abs(current_steer) >= max_steer:
			current_steer = -3
		# rotation_degrees -= current_speed / 10
	elif Input.is_action_pressed("steer_right") and current_speed != 0:
		if current_steer < 0:
			current_steer += steering_sens * delta
		current_steer += steering_sens * delta
		if current_steer >= max_steer:
			current_steer = 3
	else:
		if current_steer < -0.0000002:
			current_steer += 5 * delta
		elif current_steer > 0.0000002:
			current_steer -= 5 * delta
		else:
			current_steer = 0
			
func get_speed(delta):
	if Input.is_action_pressed("brake") and current_speed > 0:
		current_speed -= brake_power * delta
	elif Input.is_action_pressed("accelerate") and current_speed < top_speed:
		if current_speed < 1:
			current_speed += acceleration * (10) * delta
		else:
			current_speed += acceleration * (10/current_speed) * delta
	elif current_speed > 0:
		current_speed -= deceleration * delta
	
	if current_speed < 0:
		current_speed = 0
	
	var direction = Vector2.UP.rotated(rotation)
	velocity = direction * current_speed

func _physics_process(delta):
	if !movement_disabled:
		get_steering(delta)
	
	# Apply the steering
	rotation_degrees += current_steer
	
	if !movement_disabled:
		get_speed(delta)
	
	position += velocity
