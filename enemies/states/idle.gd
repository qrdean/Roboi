extends State

@export var move_state: State
@export var charge_state: State
@export var time_to_move := 2.0

var player_detection: Area2D
var charging := false

var move_timer := 0.0
var direction := Vector2(1.0, 0.0)

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0
	move_timer = time_to_move
	player_detection.player_detected.connect(_activate_charge)

func exit() -> void:
	player_detection.player_detected.disconnect(_activate_charge)

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	parent.move_and_slide()
	return null

func process_frame(delta: float) -> State:
	move_timer -= delta
	if charging:
		charging = false
		return charge_state
	if move_timer <= 0.0:
		return move_state

	return null

func _activate_charge():
	charging = true


