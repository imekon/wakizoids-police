extends Node2D

const MOVEMENT = 100.0

enum STATUS { HONEST, ROGUE_HIDDEN, ROGUE }

onready var node2d = $Node2D
onready var registration = $Node2D/Registration
onready var body = $KinematicBody2D

var running
var status
var credits
var shields
var energy
var thrust

func _ready():
	running = false
	status = HONEST
	credits = 0
	shields = 100
	energy = 100
	thrust = 0
	var angle = randf() * 360
	body.rotate(deg2rad(angle))
	
func _physics_process(delta):
	pass

func set_registration(text):
	registration.text = text
	
func process_seeking(delta):
	thrust = MOVEMENT * delta
	var rot = body.rotation_degrees - 90
	var direction = Vector2(thrust, 0).rotated(deg2rad(rot))
	var collide = body.move_and_collide(direction)
	node2d.position = body.position
	
