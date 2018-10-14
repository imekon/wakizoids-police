extends Node2D

enum STATE { IDLING, SEEKING, MINING }

onready var registration = $Registration
onready var body = $KinematicBody2D

var state
var running

func _ready():
	state = IDLING
	running = false
	var angle = randf() * 30
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
	pass
	
func process_mining(delta):
	pass
	
	