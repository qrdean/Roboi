class_name BlobChargeState extends BlobMoveState

@export var move_state: State

@export var time_to_charge := 1.5
@export var time_to_wind := 0.5

var charge_timer := 0.0
var wind_up := 0.0

enum CHARGE_STATES{
	WINDUP,
	CHARGE
}

var inner_state: CHARGE_STATES

func enter() -> void:
	super()
	
	animations.play('charge_wind_up')
	charge_timer = time_to_charge
	wind_up = time_to_wind

	direction = super.get_movement_input()
	inner_state = CHARGE_STATES.WINDUP

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	match inner_state:
		CHARGE_STATES.WINDUP:
			wind_up -= delta
			if wind_up <= 0.0:
				inner_state = CHARGE_STATES.CHARGE
			return null

		CHARGE_STATES.CHARGE:
			charge_timer -= delta
			animations.play('charge')
			if charge_timer <= 0.0:
				return idle_state
			parent.velocity = direction * delta
			return super(delta)

	return null

func get_movement_input() -> Vector2:
	return direction

