extends CharacterBody2D

const SPEED = 500.0

func _physics_process(delta):
	if Globle.global_player_position != null:
		global_position = position.move_toward(Globle.global_player_position, SPEED * delta)
