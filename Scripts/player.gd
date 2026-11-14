extends CharacterBody2D

@onready var sprint_cd = $"sprint cd"

var speed = 1000
var stamina = 100
var current_level = 1
var sprint_disabled: bool = false

func _physics_process(delta):
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var is_shift : bool = Input.is_action_pressed("Shift")
	
	if is_shift and stamina > 0 and not sprint_disabled:
		speed = 2000
		stamina -= 10 * delta
		
	else:
		if stamina < 0 and not sprint_disabled:
			sprint_disabled = true
			sprint_cd.start()
			print("DISABLED")

		speed = 1000
		if stamina < 100:
			stamina += 20 * delta
		else:
			stamina = 100
	velocity = input_dir * speed

	move_and_slide()

func new_level():
	current_level += 1
	get_tree().reload_current_scene()

func _on_sprint_cd_timeout() -> void:
	sprint_disabled = false
	print("ENABLED")
