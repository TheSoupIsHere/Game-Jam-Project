extends Node2D

const ROOMS = preload("res://Scenes/room_template.tscn")

func _ready():
	print("triggered map loader")
	
	var room_instance = ROOMS.instantiate()
