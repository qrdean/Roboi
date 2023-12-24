class_name Door extends Area2D

signal door_entered

func _ready():
	body_entered.connect(_load_level)

func _load_level(body: Node2D):
	if body is RobPlayer:
		door_entered.emit()
