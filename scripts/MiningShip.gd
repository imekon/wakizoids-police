extends KinematicBody2D

onready var registration = $Registration

func set_registration(text):
	print("registration: " + text)
	# registration.text = text