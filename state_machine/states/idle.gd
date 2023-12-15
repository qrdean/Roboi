class_name IdleState extends State

@export var move_state: State
@export var roll_state: State
@export var shield_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

func process_input(_event: InputEvent) -> State:
	if Input.is_action_pressed('shield'):
		return shield_state
	if get_movement_input().x != 0.0 || get_movement_input().y != 0.0:
		return move_state
	if Input.is_action_just_pressed('roll'):
		return roll_state

	return null

func process_physics(_delta: float) -> State:
	parent.move_and_slide()
	return null
