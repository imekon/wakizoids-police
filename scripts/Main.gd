extends Node2D

onready var rock1 = load("res://scenes/Rock1.tscn")
onready var rock2 = load("res://scenes/Rock2.tscn")
onready var rock3 = load("res://scenes/Rock3.tscn")
onready var rock4 = load("res://scenes/Rock4.tscn")
onready var rock5 = load("res://scenes/Rock5.tscn")
onready var rock6 = load("res://scenes/Rock6.tscn")

onready var scanner = $HUD/Scanner

func _ready():
	generate_rocks()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_long_range_scanner"):
		scanner.set_long_range_scanner()
	elif Input.is_action_just_pressed("ui_short_range_scanner"):
		scanner.set_short_range_scanner()
	
func random_range(value):
	return randi() % value - value / 2
	
func generate_rocks():
	for i in range(20):
		generate_rock(rock1, random_range(65536), random_range(65536))
		generate_rock(rock2, random_range(65536), random_range(65536))
		generate_rock(rock3, random_range(65536), random_range(65536))
		generate_rock(rock4, random_range(65536), random_range(65536))
		generate_rock(rock5, random_range(65536), random_range(65536))
		generate_rock(rock6, random_range(65536), random_range(65536))
	
func generate_rock(resource, x, y):
	var rock = resource.instance()
	rock.position = Vector2(x, y)
	add_child(rock)
	
