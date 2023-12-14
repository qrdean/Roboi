extends State

@export var idle_state: State

var debug_ui: Control
var shield_charge: int

func enter():
	super()	
	animations.self_modulate.a = 0.75

func exit():
	animations.self_modulate.a = 1.0

func process_input(_input_event: InputEvent) -> State:
	if parent.shield_charge > 0:
		if Input.is_action_pressed('shield'):
			return null

	return idle_state

func process_physics(_delta: float) -> State:
	parent.shield_charge -= 1
	parent.debug_ui.update_shield_text.emit(str(parent.shield_charge))
	return null

