extends CharacterBody2D

@onready var _animation_player = $ani
var speed = 1000

func _physics_process(delta):
	Globle.input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Globle.input_dir.x < 0:
		_animation_player.play("Left Walk")
	elif Globle.input_dir.x > 0:
		_animation_player.play("Right Walk")
	elif Globle.input_dir.y < 0:
		_animation_player.play("Up Walk")
	elif Globle.input_dir.y > 0:
		_animation_player.play("Down Walk")
	
	velocity = Globle.input_dir * speed
	move_and_slide()
