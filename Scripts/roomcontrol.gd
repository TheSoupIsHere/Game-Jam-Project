extends Node2D

var rooms: Array[Room] = [$"UDLR_Room",
						  $"ULR_Room", $"UDL_Room", $"DLR_Room", $"UDR_Room", 
						  $"UL_Room", $"DL_Room", $"DR_Room", $"UR_Room", 
						  $"U_Room", $"L_Room", $"D_Room", $"R_Room"]

var showing_room = 0

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
	if next:
		print("next room triggered")
		showing_room += 1
		show_room(showing_room)
		get_tree().reload_current_scene()
