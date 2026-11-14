extends CharacterBody2D

var speed = 1000
var stamina = 100
var current_level = 1

func _physics_process(delta):
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_pressed("shift") and stamina > 0:
		speed = 2000
		stamina -= 1 / delta
	else:
		stamina += 2 / delta
	velocity = input_dir * speed
	
	
		
	
	move_and_slide()

func new_level():
	current_level += 1
	get_tree().reload_current_scene()
	
