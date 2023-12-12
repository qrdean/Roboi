extends BlobMove

@export var move_state: State

@export var time_to_charge := 0.5

var charge_timer := 0.0

func enter() -> void:
	super()
	charge_timer = time_to_charge

	direction = super.get_movement_input()

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	charge_timer -= delta
	if charge_timer <= 0.0:
		return idle_state

	return super(delta)

func get_movement_input() -> Vector2:
	return direction

