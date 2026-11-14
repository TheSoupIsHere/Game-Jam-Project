extends Sprite2D

const Tforward = preload("res://art folder/Woofly front.png")
const Tbackward = preload("res://art folder/Woofly back.png")
const Tleft = preload("res://art folder/Woofly left.png")
const Tright: = preload("res://art folder/Woofly right.png")

func _ready():
	texture = Tforward

func _process(delta):
	
	if Globle.input_dir.x < 0:
		texture = Tleft
	elif Globle.input_dir.x > 0:
		texture = Tright
	elif Globle.input_dir.y < 0:
		texture = Tbackward
	elif Globle.input_dir.y > 0:
		texture = Tforward
