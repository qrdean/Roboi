extends BlobMoveState

var pursuing := true

func enter():
	super()
	direction = super.get_movement_input()

func exit():
	pass

func process_physics(_delta: float) -> State:
	parent.move_and_slide()
	return null

func process_frame(_delta: float) -> State:
	return null

func get_movement_input() -> Vector2:
	return direction

