extends CharacterBody2D

const SPEED = 100.0

func _physics_process(delta):
	position = position.move_toward(Globle.global_player_position, SPEED * delta)
