extends State

@export var move_state: State
@export var charge_state: State

var player_detection: Area2D
var charging := false

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0
	player_detection.player_detected.connect(_activate_charge)

func exit() -> void:
	player_detection.player_detected.disconnect(_activate_charge)

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	parent.move_and_slide()
	return null

func process_frame(_delta: float) -> State:
	if charging:
		charging = false
		return charge_state
	return null

func _activate_charge():
	charging = true
