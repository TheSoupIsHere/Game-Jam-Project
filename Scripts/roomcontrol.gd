extends Node2D

var rooms: Array[Room] = [$"UDLR_Room",
						  $"ULR_Room", $"UDL_Room", $"DLR_Room", $"UDR_Room", 
						  $"UL_Room", $"DL_Room", $"DR_Room", $"UR_Room", 
						  $"U_Room", $"L_Room", $"D_Room", $"R_Room"]

@onready var player = $"../Player"

var showing_room = 0
var north: bool = false
var south: bool = false
var west: bool = false
var east: bool = false

func show_room(room_num: int):
	for num in range(len(rooms)):
		if num != room_num:
			rooms[num].visible = false
		else:
			rooms[num].visible = true

func _ready():
	print("ready")

func _process(delta: float) -> void:
	var next : bool = Input.is_action_just_pressed("Next Room")
	#if next:
		#print("next room triggered")
		#showing_room = (showing_room + 1) % len(rooms)
		#show_room(showing_room)
		#self.position

func _on_north_collider_area_entered(body) -> void:
	if body.is_in_group("Player"):
		north = true
		player.position = $"North Spawn".position

func _on_south_collider_area_entered(body) -> void:
	print("touched south")
	if body.is_in_group("Player"):
		south = true
		player.position = $"South Spawn".position

func _on_west_collider_area_entered(body) -> void:
	if body.is_in_group("Player"):
		west = true
		player.position = $"West Spawn".position

func _on_east_collider_area_entered(body) -> void:
	if body.is_in_group("Player"):
		east = true
		player.position = $"East Spawn".position
