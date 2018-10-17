extends Node2D

const MOVEMENT = 100.0

enum STATUS { IDLE, SHOOTING, MOVING }
enum ROGUE_STATUS { HONEST, ROGUE_HIDDEN, ROGUE }

onready var node2d = $Node2D
onready var registration = $Node2D/Registration
onready var body = $KinematicBody2D
onready var firing_position = $KinematicBody2D/FiringPosition

var running
var status
var rogue_status
var credits
var shields
var energy
var thrust
var target_rock
var target_position

func _ready():
	running = false
	status = IDLE
	rogue_status = HONEST
	credits = 0
	shields = 100
	energy = 100
	thrust = 0
	target_rock = null
	var angle = randf() * 360
	body.rotate(deg2rad(angle))
	
func _physics_process(delta):
	#
	# If rogue and cops far away 10000 units attack any mining ships nearby
	#
	# If hidden and cops nearby pick a fight, run or idle
	# If rogue and cops nearby attack
	var miner_position = body.position

	match status:
		IDLE:
			process_idle(delta, miner_position)
		MOVING:
			process_move(delta)
		SHOOTING:
			shoot(miner_position, target_position)
	
func process_idle(delta, miner_position):
	# Scan for rocks with 500 units, shoot them if found
	var rocks = get_tree().get_nodes_in_group("rocks")
	var closest_rock = null
	var closest_dist = 99999
	var closest_position
	for rock in rocks:
		var pos = rock.position
		var dist = miner_position.distance_to(pos)
		if dist < 500:
			if dist < closest_dist:
				closest_dist = dist
				closest_rock = rock
				closest_position = pos
	
	if closest_dist < 500:
		shoot(miner_position, closest_rock.position)
		
	# If no rocks near, scan for rocks with 10000 units, head towards
	# them if found
	if closest_dist < 10000:
		target_rock = closest_rock
		target_position = closest_position
		move_towards(delta, miner_position, closest_rock.position)

	# If no rocks found, and credits low, consider going rogue. Otherwise pick
	# a random direction and move
	if credits < 100 && randf() > 0.999:
		rogue_status = ROGUE_HIDDEN
		
	target_rock = null
	move_random(delta)

func set_registration(text):
	registration.text = text
	
func shoot(pos, body_pos):
	# print("miner shoot!")
	status = SHOOTING
	
func move_towards(delta, miner_position, pos):
	var angle = pos.angle_to(miner_position)
	rotate(angle - body.rotation)
	process_move(delta)
	status = MOVING
	
func move_random(delta):
	status = MOVING
	process_move(delta)
	
func process_move(delta):
	thrust = MOVEMENT * delta
	var rot = body.rotation_degrees - 90
	var direction = Vector2(thrust, 0).rotated(deg2rad(rot))
	var collide = body.move_and_collide(direction)
	node2d.position = body.position

	var miner_position = body.position
	if target_rock != null:
		if miner_position.distance_to(target_position) < 500:
			shoot(miner_position, target_position)
	else:
		var rocks = get_tree().get_nodes_in_group("rocks")
		for rock in rocks:
			var pos = rock.position
			var dist = miner_position.distance_to(pos)
			if dist < 500:
				target_rock = rock
				target_position = rock.position
				shoot(miner_position, target_position)
				break
