class_name World extends Node2D

@onready var exit_door: Door = $Door

var next_level_scene: PackedScene

signal load_next_level(PackedScene)

func _ready():
	if exit_door:
		exit_door.load_next_level.connect(_load_next_level)

func _load_next_level():
	load_next_level.emit(next_level_scene)
