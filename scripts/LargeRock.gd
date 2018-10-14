extends RigidBody2D

const ACCELERATION = 150

func _ready():
	var angle = randf() * 360.0
	apply_impulse(Vector2(), Vector2(0, -ACCELERATION).rotated(deg2rad(angle)))

func on_body_entered(body):
	print("somebody hit us (rock)")
