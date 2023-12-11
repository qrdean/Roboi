extends BlobMove

@export var move_state: State

@export var time_to_charge := 0.5

var charge_timer := 0.0
var direction := Vector2(1.0, 0.0)
# var player_detection: Area2D

func enter() -> void:
	super()
	charge_timer = time_to_charge

	print_debug("enter charge state")

	direction = super.get_movement_input()

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	print_debug("process charge physics")
	charge_timer -= delta
	if charge_timer <= 0.0:
		return idle_state
		# if super.get_movement_input().x != 0.0 || super.get_movement_input().y != 0.0:
		# 	return move_state

		# return idle_state

	return super(delta)

func get_movement_input() -> Vector2:
	return direction

