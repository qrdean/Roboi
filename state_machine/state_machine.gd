class_name BaseStateMachine extends Node

@export var starting_state: State

var current_state: State

func init(parent: CharacterBody2D, animations: AnimatedSprite2D, move_component) -> void:
	for child: State in get_children():
		child.parent = parent
		child.animations = animations
		child.move_component = move_component
	
	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

# Helper functions
func is_in_state(state_node_name: String) -> bool:
	return self.current_state == self.get_node_or_null(state_node_name)

func get_state_node(state_node_name: String) -> State:
	return self.get_node(state_node_name)
