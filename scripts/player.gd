extends CharacterBody2D

var movement_disabled = false
var is_on_grass = false
var is_on_water = false

# Steering
var base = 30
var steering_increment = 0.5
var steering_angle = 15
var steer_direction = 0
var steer_speed = 2.0

# Acceleration
var engine_power = 575
var acceleration = Vector2.ZERO

# Other forces
var friction = -30
var drag = -0.06
var boost_power = 500

# Braking and reverse
var brake_power = -300
var max_speed_reverse = 250

# Drift
var slip_speed = 200
var traction_slow = 2.5
var traction_fast = 1.25

# OLD SETTINGS
#var base = 30
#var steering_increment = 0.5
#var steering_angle = 15
#var steer_direction = 0
#
## Acceleration
#var engine_power = 750
#var acceleration = Vector2.ZERO
#
## Other forces
#var friction = -30
#var drag = -0.06
#var boost_power = 450
#
## Braking and reverse
#var brake_power = -450
#var max_speed_reverse = 250
#
## Drift
#var slip_speed = 200
#var traction_slow = 2.5
#var traction_fast = 1.25

func _ready():
	setup_camera()
	setup_sounds()

func get_input(delta):
	var turn = Input.get_axis("steer_left", "steer_right")
	
	var target_steer = turn * deg_to_rad(steering_angle)
	
	steer_direction = move_toward(steer_direction, target_steer, steer_speed * delta)
	
	if Input.is_action_pressed("accelerate"):
		var strength = Input.get_action_strength("accelerate")
		acceleration = transform.x * engine_power * strength
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * brake_power

func calculate_steering(delta):
	var rear_wheel = position - transform.x * base / 2.0
	var front_wheel = position + transform.x * base / 2.0
	
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	
	if velocity.length() > slip_speed:
		traction = traction_fast
		if abs(steer_direction) >= 0.01 and !$Sounds/Drift.playing:
			$Sounds/Drift.playing = true
		if abs(steer_direction) < 0.01:
			$Sounds/Drift.playing = false
	
	
	if Input.is_action_pressed("accelerate") and !$Sounds/Acceleration.playing:
		$Sounds/Acceleration.playing = true
		$Sounds/Motor.playing = false
	elif !Input.is_action_pressed("accelerate"):
		$Sounds/Acceleration.playing = false
		if !$Sounds/Motor.playing:
			$Sounds/Motor.playing = true
		
	if Input.is_action_pressed("brake") and !$Sounds/Reverse.playing:
		$Sounds/Reverse.playing = true
	elif !Input.is_action_pressed("brake"):
		$Sounds/Reverse.playing = false
		
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()

func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force

func _physics_process(delta):
	acceleration = Vector2.ZERO
	if !movement_disabled:
		get_input(delta)
	if is_on_water:
		friction = -250
	elif is_on_grass:
		friction = -150
	else:
		friction = -30
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	# Save the velocity before impact to calculate the force applied
	var last_velo = velocity
	move_and_slide()
	
	# Check for collisions with RigidBody2D
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * last_velo.length()/10)
	
func setup_camera():
	if Settings.camera_fixed:
		$Camera2D.ignore_rotation = true
		$Camera2D.position_smoothing_enabled = false
		$Camera2D.rotation_smoothing_enabled = false
	else:
		$Camera2D.ignore_rotation = false
		$Camera2D.position_smoothing_enabled = true
		$Camera2D.position_smoothing_speed = 15.0
		$Camera2D.rotation_smoothing_enabled = true
		$Camera2D.rotation_smoothing_speed = 3.5

func setup_sounds():
	var sounds = $Sounds.get_children()
	
	if Settings.sounds:
		for sound in sounds:
			sound.volume_db = 0
	else:
		for sound in sounds:
			sound.volume_linear = 0

func _on_grass_body_entered(body):
	is_on_grass = true


func _on_grass_body_exited(body):
	is_on_grass = false


func _on_water_body_entered(body):
	is_on_water = true


func _on_water_body_exited(body):
	is_on_water = false


func _on_boost_area_entered(area):
		# Get current direction and add to the acceleration in that direction
	var vel_directiion = velocity.normalized()
	velocity += vel_directiion * boost_power
