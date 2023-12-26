class_name Hitbox extends Area2D

@export var attack_damage = 1

func _ready():
	monitorable = false

func set_active():
	monitorable = true

func set_inactive():
	monitorable = false
