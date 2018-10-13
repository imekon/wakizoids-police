extends KinematicBody2D

const MOVEMENT = 10.0

var thrust = 0.0

func _physics_process(delta):
	var angle = 0.0

	if Input.is_action_pressed("ui_forwards"):
		thrust = MOVEMENT
	if Input.is_action_pressed("ui_backwards"):
		thrust = -MOVEMENT
	if Input.is_action_pressed("ui_left"):
		angle = -2
	if Input.is_action_pressed("ui_right"):
		angle = 2
		
	var rot = rotation_degrees - 90
		
	var x = cos(deg2rad(-rot)) * thrust
	var y = -sin(deg2rad(-rot)) * thrust
	var direction = Vector2(x, y)

	move_and_collide(direction)
	rotate(deg2rad(angle))
	
	thrust *= 0.025 * delta
	
