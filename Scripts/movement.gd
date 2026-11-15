extends CharacterBody2D

@onready var _animation_player = $ani
var speed = 1000

func _process(delta):
	Global.global_player_position = global_position

func _physics_process(delta):
	
	
	Global.input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Global.input_dir.x < 0:
		_animation_player.play("Left Walk")
	elif Global.input_dir.x > 0:
		_animation_player.play("Right Walk")
	elif Global.input_dir.y < 0:
		_animation_player.play("Up Walk")
	elif Global.input_dir.y > 0:
		_animation_player.play("Down Walk")
	
	velocity = Global.input_dir * speed
	move_and_slide()
