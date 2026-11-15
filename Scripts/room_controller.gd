extends Node2D

var rooms: Array[Room] = [$"UDLR_Room",
						  $"ULR_Room", $"UDL_Room", $"DLR_Room", $"UDR_Room", 
						  $"UL_Room", $"DL_Room", $"DR_Room", $"UR_Room", 
						  $"U_Room", $"L_Room", $"D_Room", $"R_Room"]

func show_room(room_num: int):
	for num in range(len(rooms)):
		if num != room_num:
			rooms[num].visible = false
		else:
			rooms[num].visible = true
