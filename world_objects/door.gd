class_name Door extends Area2D

signal load_next_level

func _ready():
	body_entered.connect(_load_level)

func _load_level(body: Node2D):
	if body is RobPlayer:
		load_next_level.emit()
