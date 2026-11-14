extends CharacterBody2D

var speed = 1000
var front
var left
var right
var back
var current_level = 1

func _physics_process(delta):
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_dir * speed
	move_and_slide()

func new_level():
	current_level += 1
	get_tree().reload_current_scene()
	
