extends Node2D

enum STATE { IDLING, SEEKING, MINING }

const MOVEMENT = 100.0

onready var node2d = $Node2D
onready var registration = $Node2D/Registration
onready var body = $KinematicBody2D

var state
var running
var credits
var shields
var energy
var thrust

func _ready():
	state = SEEKING
	running = false
	credits = 0
	shields = 100
	energy = 100
	thrust = 0
	var angle = randf() * 360
	body.rotate(deg2rad(angle))
	
func _physics_process(delta):
	match state:
		IDLING:
			process_idle(delta)
		SEEKING:
			process_seeking(delta)
		MINING:
			process_mining(delta)

func set_registration(text):
	registration.text = text
	
func process_idle(delta):
	if running:
		pass
	else:
		pass
	
func process_seeking(delta):
	thrust = MOVEMENT * delta
	var rot = body.rotation_degrees - 90
	var direction = Vector2(thrust, 0).rotated(deg2rad(rot))
	var collide = body.move_and_collide(direction)
	node2d.position = body.position
	
func process_mining(delta):
	pass
	
	