class_name RoomGenerator
extends Node2D

@export var map_size : int = 7;
@export var rooms_to_generate : int = 12;

var room_count : int = 0;
var map : Array[bool];
var rooms : Array[Room];
var room_offset : float = 0;

var first_x : int = 3;
var first_y : int = 3;
var first_room : Room

@export var player : CharacterBody2D

func _ready():
	_generate()

func _generate():
	room_count = 0
	map.resize(map_size * map_size)
	
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

func _instantiate_rooms():
	pass
	
func _get_map(x : int, y : int):
	return map[x + y * map_size]
	
func _set_map(x : int, y : int, value : bool):
	map[x + y * map_size] = value
