extends State

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	parent.move_and_slide()
	return null


