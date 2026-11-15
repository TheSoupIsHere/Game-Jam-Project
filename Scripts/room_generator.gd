class_name RoomGenerator
extends Node

const ROOM_EXITS: Array[String] = [
	"UDLR", "ULR", "UDL", "DLR", "UDR",
	"UL", "DL", "DR", "UR", "UD", "LR",
	"U", "L", "D", "R"
]

@export var map_size : int = 7;
@export var rooms_to_generate : int = 12;

var room_count : int = 0;
var map : Array[bool];
var exit : Array[int];
@onready var rooms: Array[Room] = [$"../UDLR_Room",
						  $"../ULR_Room", $"../UDL_Room", $"../DLR_Room", $"../UDR_Room", 
						  $"../UL_Room", $"../DL_Room", $"../DR_Room", $"../UR_Room", 
						  $"../UD_Room", $"../LR_Room",
						  $"../U_Room", $"../L_Room", $"../D_Room", $"../R_Room"]
var room_offset : float = 0;

var first_x : int = 3;
var first_y : int = 3;
var first_room : Room
var current_room_x: int
var current_room_y: int
var showing_room: int = -1

func _ready():
	_generate()
	_print_map()

func _generate():
	room_count = 0
	map.resize(map_size * map_size)
	map.fill(false)
	exit.clear()
	
	_check_room(first_x, first_y, Vector2.ZERO, true)
	_instantiate_rooms(first_x, first_y)

func _check_room(x : int, y : int, direction : Vector2, is_first_room : bool = false):
	if room_count >= rooms_to_generate:
		return
	if x < 0 or x > map_size - 1 or y < 0 or y > map_size - 1:
		return
	
	if _get_map(x, y) == true:
		return
	
	room_count += 1
	_set_map(x, y, true)
	if room_count == rooms_to_generate:
		exit = [x, y]
	
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
	
func _instantiate_rooms(x: int, y: int):
	current_room_x = x
	current_room_y = y
	if not show_room_at(x, y):
		push_error("Could not find a room variant for the generated start room")

func show_room_at(x: int, y: int, required_exit: String = "") -> bool:
	if not has_room(x, y):
		return false

	var exits := get_room_exits(x, y)
	var room_index := _room_index_for_exits(exits, required_exit)
	if room_index == -1:
		push_error("No room variant matches exits '%s' at grid position (%d, %d)" % [exits, x, y])
		return false

	for index in range(rooms.size()):
		rooms[index].visible = index == room_index
	showing_room = room_index
	return true

func _room_index_for_exits(exits: String, required_exit: String = "") -> int:
	for index in range(ROOM_EXITS.size()):
		if ROOM_EXITS[index] == exits and (required_exit.is_empty() or exits.contains(required_exit)):
			return index
	return -1

func _print_map() -> void:
	print("Generated room map (rows = y, columns = x; room labels list open sides):")
	var column_header := "y\\x "
	for x in range(map_size):
		column_header += str(x).rpad(5)
	print(column_header)

	for y in range(map_size):
		var line := str(y).rpad(3) + ": "
		for x in range(map_size):
			var cell := "-----"
			if has_room(x, y):
				var exits := get_room_exits(x, y)
				if _room_index_for_exits(exits) == -1:
					push_error("No room variant matches printed map cell (%d, %d): '%s'" % [x, y, exits])
					cell = "?????"
				else:
					cell = exits
					if x == first_x and y == first_y:
						cell = "S" + cell
					elif exit.size() == 2 and x == exit[0] and y == exit[1]:
						cell = "E" + cell
			line += cell.rpad(5)
		print(line)

func get_room_exits(x: int, y: int) -> String:
	var exits := ""
	if has_room(x, y - 1):
		exits += "U"
	if has_room(x, y + 1):
		exits += "D"
	if has_room(x - 1, y):
		exits += "L"
	if has_room(x + 1, y):
		exits += "R"
	return exits

func current_room_has_exit(direction: String) -> bool:
	return showing_room >= 0 and showing_room < ROOM_EXITS.size() and ROOM_EXITS[showing_room].contains(direction)

func has_room(x: int, y: int) -> bool:
	if x < 0 or x >= map_size or y < 0 or y >= map_size:
		return false
	if map.size() != map_size * map_size:
		return false
	return map[x + y * map_size]
	
func _get_neighbors(x : int, y : int):
	var up = _get_map(x, y - 1)
	var down = _get_map(x, y + 1)
	var left = _get_map(x - 1, y)
	var right = _get_map(x + 1, y)
	return [up, down, left, right]

func _get_map(x : int, y : int):
	if x < 0 or x >= map_size or y < 0 or y >= map_size:
		return false
	return map[x + y * map_size]
	
func _set_map(x : int, y : int, value : bool):
	map[x + y * map_size] = value
