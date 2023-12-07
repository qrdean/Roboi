class_name PlayerCamera extends Camera2D


@export var node_to_follow: Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	position = lerp(position, node_to_follow.position, 0.60)

