extends CharacterBody2D

const SPEED = 500.0

func _physics_process(delta: float):
	
	if Globle.global_player_position != null:
		var direction = global_position.direction_to(Globle.global_player_position)
		velocity = direction * SPEED
		move_and_slide()
		
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.is_in_group("Player"):
			print("DEAD")