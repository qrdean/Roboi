class_name Move extends State

@export var roll_state: State
@export var idle_state: State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('roll'):
		return roll_state

	return null

func process_physics(_delta: float) -> State:
	var movement_y = get_movement_input().y * move_speed
	var movement_x = get_movement_input().x * move_speed

	if movement_x == 0 && movement_y == 0:
		return idle_state

	animations.flip_h = movement_x < 0
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)
	# 	velocity.y = move_toward(velocity.y, 0, SPEED)
	# parent.velocity.x = movement_x
	# parent.velocity.y = movement_y
	parent.velocity = get_movement_input() * move_speed

	parent.move_and_slide()

	return null
