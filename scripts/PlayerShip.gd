extends KinematicBody2D

func _physics_process(delta):
	var thrust = 0.0
	var angle = 0.0

	if Input.is_action_pressed("ui_forwards"):
		thrust = 1
	elif Input.is_action_pressed("ui_backwards"):
		thrust = -1
	elif Input.is_action_pressed("ui_left"):
		angle = -1
	elif Input.is_action_pressed("ui_right"):
		angle = 1
		
	var rot = rotation_degrees - 90
		
	var x = cos(deg2rad(-rot)) * thrust
	var y = -sin(deg2rad(-rot)) * thrust
	var direction = Vector2(x, y)

	move_and_collide(direction)
	rotate(deg2rad(angle))
	
	thrust /= delta
	
