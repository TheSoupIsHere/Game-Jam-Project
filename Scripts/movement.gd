extends CharacterBody2D

var base_speed : int = 1000
var shift : bool = false
var timer = 0
var cooldown = false

func _physics_process(delta):
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var speed : int = base_speed * (2 if shift == true and not cooldown else 1)
	if cooldown == true:
		timer += 1
		if timer > 2000:
			cooldown = false
			timer = 0
	
	velocity = input_dir * speed
	move_and_slide()
	
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_SHIFT:
			shift = true
			cooldown = true
		else:
			shift = false

	
