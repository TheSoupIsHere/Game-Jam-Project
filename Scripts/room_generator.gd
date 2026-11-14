class_name RoomGenerator
extends Node

@onready var player = $"../Player"

@export var map_size : int = 7;
@export var rooms_to_generate : int = 12;

var room_count : int = 0;
var map : Array[bool];
var exit : Array[int];
var rooms: Array[Room] = [$"../UDLR_Room",
						  $"../ULR_Room", $"../UDL_Room", $"../DLR_Room", $"../UDR_Room", 
						  $"../UL_Room", $"../DL_Room", $"../DR_Room", $"../UR_Room", 
						  $"../U_Room", $"../L_Room", $"../D_Room", $"../R_Room"]
var room_offset : float = 0;

var first_x : int = 3;
var first_y : int = 3;
var first_room : Room

func _ready():
	_generate()
	
	for x in range(map_size):
		var line : String
		for y in range(map_size):
			line += "[]" if _get_map(x, y) == true else "  "
		print(line)

func _generate():
	room_count = 0
	map.resize(map_size * map_size)
	rooms_to_generate = 12
	print(rooms_to_generate)
	
	_check_room(first_x, first_y, Vector2.ZERO, true)
	_instantiate_rooms()

func _check_room(x : int, y : int, direction : Vector2, is_first_room : bool = false):
	if room_count >= rooms_to_generate:
		return
	if x < 0 or x > map_size - 1 or y < 0 or y > map_size - 1:
		return
	
	if _get_map(x, y) == true:
		return
	
	room_count += 1
	_set_map(x, y, true)
	
	var go_north : bool = randf() > (0.2 if direction == Vector2.UP else 0.8)
	var go_south : bool = randf() > (0.2 if direction == Vector2.DOWN else 0.8)
	var go_west : bool = randf() > (0.2 if direction == Vector2.LEFT else 0.8)
	var go_east : bool = randf() > (0.2 if direction == Vector2.RIGHT else 0.8)
	
	if go_north or is_first_room:
		_check_room(x, y - 1, Vector2.UP if is_first_room else direction)
	if go_south or is_first_room:
		_check_room(x, y + 1, Vector2.DOWN if is_first_room else direction)
	if go_west or is_first_room:
		_check_room(x - 1, y, Vector2.UP if is_first_room else direction)
	if go_east or is_first_room:
		_check_room(x + 1, y, Vector2.UP if is_first_room else direction)
	
	if room_count == rooms_to_generate - 1:
		exit = [x, y]

func _instantiate_rooms():
	pass
	
func _get_map(x : int, y : int):
	return map[x + y * map_size]
	
func _set_map(x : int, y : int, value : bool):
	map[x + y * map_size] = value
