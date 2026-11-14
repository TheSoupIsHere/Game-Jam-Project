extends CharacterBody2D

var base_speed : int = 1000
var shift : bool = false
var timer = 0
var boost_active : bool = false
var cooldown = false

func _physics_process(delta):
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var speed : int = base_speed * (2 if boost_active and not cooldown else 1)
	if boost_active == true:
		timer += 1
		if timer > 200:
			boost_active = false
			cooldown = true
			timer = 0
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
			if not cooldown:
				boost_active = true
		else:
			shift = false

	
