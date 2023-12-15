class_name PlayerShieldState extends State

@export var idle_state: State

func enter():
	super()	

func exit():
	pass

func process_input(_input_event: InputEvent) -> State:
	if parent.shield_charge > 0:
		if Input.is_action_pressed('shield'):
			return null

	return idle_state

func process_physics(_delta: float) -> State:
	if parent.shield_charge <= 0:
		return idle_state

	parent.shield_charge -= 1
	parent.debug_ui.update_shield_text.emit(str(parent.shield_charge))
	return null

