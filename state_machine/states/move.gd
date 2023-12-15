class_name MoveState extends State

@export var roll_state: State
@export var idle_state: State
@export var shield_state: State
@export var side_animation_name: String
@export var down_animation_name: String
@export var up_animation_name: String

func process_input(_event: InputEvent) -> State:
	if Input.is_action_pressed('shield'):
		return shield_state
	if Input.is_action_just_pressed('roll'):
		return roll_state

	return null

func process_physics(_delta: float) -> State:
	var movement_y = get_movement_input().y * move_speed
	var movement_x = get_movement_input().x * move_speed

	if movement_x == 0 && movement_y == 0:
		return idle_state

	animations.flip_h = movement_x < 0

	parent.velocity = get_movement_input() * move_speed

	parent.move_and_slide()

	return null

func process_frame(_delta: float) -> State:
	if get_movement_input().x > 0:
		animations.flip_h = true
		animations.play(side_animation_name)
		return null
	if get_movement_input().y > 0:
		animations.play(down_animation_name)
		return null
	if get_movement_input().x < 0:
		animations.flip_h = false
		animations.play(side_animation_name)
		return null
	if get_movement_input().y < 0:
		animations.play(up_animation_name)

	return null
