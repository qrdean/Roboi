class_name PlayerDetection extends Area2D

@export var rotation_speed: float = 0.75

signal player_detected

func _ready():
	self.body_entered.connect(_player_body_detection)

func _process(delta):
	rotation += 1 * rotation_speed * delta

func _player_body_detection(body: Node2D):
	if body is RobPlayer:
		player_detected.emit()
