extends Move

@export var move_state: State

@export var time_to_roll := 0.5

var roll_timer := 0.0
var direction := Vector2(1.0, 0.0)

func enter() -> void:
	super()
	roll_timer = time_to_roll

	direction = super.get_movement_input()

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	roll_timer -= delta
	if roll_timer <= 0.0:
		if super.get_movement_input().x != 0.0 || super.get_movement_input().y != 0.0:
			return move_state

		return idle_state

	return super(delta)

func get_movement_input() -> Vector2:
	return direction

