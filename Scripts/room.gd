class_name Room
extends StaticBody2D

func _process(delta: float) -> void:
	if visible == false:
		disable_all_shapes(self)
	else:
		enable_all_shapes(self)

func disable_all_shapes(target_node: Node) -> void:
	for child in target_node.find_children("*", "", true, false):
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.set_deferred("disabled", true)

func enable_all_shapes(target_node: Node) -> void:
	for child in target_node.find_children("*", "", true, false):
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.set_deferred("enabled", true)
