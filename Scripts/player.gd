class_name Player
extends CharacterBody2D

@onready var sprint_cd = $"sprint cd"
@onready var _animation_player = $ani
@onready var triggerbox = $PlayerTriggerbox

var speed = 1000
var stamina = 100
var current_level = 1
var sprint_disabled: bool = false

func _physics_process(delta):
	Global.global_player_position = global_position
	Global.input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Global.input_dir.x < 0:
		_animation_player.play("Left Walk")
	elif Global.input_dir.x > 0:
		_animation_player.play("Right Walk")
	elif Global.input_dir.y < 0:
		_animation_player.play("Up Walk")
	elif Global.input_dir.y > 0:
		_animation_player.play("Down Walk")
		
	
		
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
	velocity = Global.input_dir * speed

	move_and_slide()

func new_level():
	current_level += 1
	get_tree().reload_current_scene()

func _on_sprint_cd_timeout() -> void:
	sprint_disabled = false
	print("ENABLED")
