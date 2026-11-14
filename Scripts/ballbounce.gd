extends CharacterBody2D

var speed = 1000.0

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var playerpositionNMouse = global_position.direction_to(get_global_mouse_position())
		velocity = playerpositionNMouse * speed

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
