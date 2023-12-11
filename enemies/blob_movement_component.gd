extends Node

var direction := Vector2(0.0, 0.0)
var player_node: CharacterBody2D

func init(set_player_node: CharacterBody2D):
	player_node = set_player_node

func get_movement_direction() -> Vector2:
	if player_node:
		return (player_node.global_position - get_parent().global_position).normalized()

	return direction
