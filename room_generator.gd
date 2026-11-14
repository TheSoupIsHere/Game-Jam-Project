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
	pass

func _generate():
	pass

func _check_room(x : int, y : int, direction : Vector2, is_first_room : bool = false):
	pass

func _instantiate_rooms():
	pass
