class_name BlobMove extends State

@export var charge_state: State
@export var idle_state: State

var player_detection: PlayerDetection
var charging = false

func enter() -> void:
	super()
	player_detection.player_detected.connect(_activate_charge)

func exit() -> void:
	player_detection.player_detected.disconnect(_activate_charge)

func process_physics(_delta: float) -> State:
	var movement_y = get_movement_input().y * move_speed
	var movement_x = get_movement_input().x * move_speed
	var movement = Vector2(movement_x, movement_y)
	
	if movement.x == 0 && movement.y == 0:
		return idle_state

	parent.velocity = get_movement_input() * move_speed
	parent.move_and_slide() 

	return null

func process_frame(_delta: float) -> State:
	if charging:
		charging = false
		return charge_state
	return null

func _activate_charge() -> void:
	charging = true
