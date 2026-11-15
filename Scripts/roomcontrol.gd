extends Node2D

@onready var room_generator: RoomGenerator = $room_generator

var north: bool = false
var south: bool = false
var west: bool = false
var east: bool = false

func _transition_through_exit(body: Node2D, exit_direction: String, spawn_name: String) -> bool:
	if not body.is_in_group("Player"):
		return false
	if not room_generator.current_room_has_exit(exit_direction):
		return false

	var entry_direction: String
	var target_x := room_generator.current_room_x
	var target_y := room_generator.current_room_y
	match exit_direction:
		"U":
			entry_direction = "D"
			target_y -= 1
		"D":
			entry_direction = "U"
			target_y += 1
		"L":
			entry_direction = "R"
			target_x -= 1
		"R":
			entry_direction = "L"
			target_x += 1

	if not room_generator.has_room(target_x, target_y):
		return false

	if not room_generator.show_room_at(target_x, target_y, entry_direction):
		return false

	room_generator.current_room_x = target_x
	room_generator.current_room_y = target_y
	body.global_position = get_node(spawn_name).global_position
	return true

func _on_north_collider_body_entered(body: Node2D) -> void:
	if _transition_through_exit(body, "U", "South Spawn"):
		north = true

func _on_south_collider_body_entered(body: Node2D) -> void:
	if _transition_through_exit(body, "D", "North Spawn"):
		south = true

func _on_west_collider_body_entered(body: Node2D) -> void:
	if _transition_through_exit(body, "L", "East Spawn"):
		west = true

func _on_east_collider_body_entered(body: Node2D) -> void:
	if _transition_through_exit(body, "R", "West Spawn"):
		east = true
