class_name World extends Node2D

@onready var exit_door: Door = $Door

var next_level_scene: PackedScene

# Connected in the world manager to transition to the next level scene
signal load_next_level(PackedScene)

func _ready():
	if exit_door:
		exit_door.door_entered.connect(_load_next_level)

func _load_next_level():
	load_next_level.emit(next_level_scene)
