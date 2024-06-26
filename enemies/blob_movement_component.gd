class_name BlobMovementComponent extends Node

var player_node: CharacterBody2D
var player_detection: Area2D

func _ready():
	pass

func init(p_player_node: CharacterBody2D, p_player_detection: Area2D):
	player_node = p_player_node
	player_detection = p_player_detection

func get_movement_direction() -> Vector2:
	if player_node:
		return (player_node.global_position - get_parent().global_position).normalized()

	return Vector2(0.0, 0.0)

