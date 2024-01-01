class_name BlobMoveState extends State

@export var charge_state: State
@export var idle_state: State
@export var time_to_idle := 1.0

var player_detection: PlayerDetection
var charging = false

var idle_timer := 0.0
var direction := Vector2(1.0, 0.0)

func enter() -> void:
	super()
	animations.play('default')
	idle_timer = time_to_idle
	player_detection.player_detected.connect(_activate_charge)
	# Picks a random direction every tick.
	var something = randi() % 2 as bool
	if something:
		direction = Vector2(pow(-1.0, randi() % 2), pow(-1.0, randi() % 2))
	else:
		direction = super.get_movement_input()
	# direction = Vector2(pow(-1.0, randi() % 2), pow(-1.0, randi() % 2))

func exit() -> void:
	player_detection.player_detected.disconnect(_activate_charge)

func process_physics(_delta: float) -> State:
	var movement_y = _get_movement_input().y * move_speed
	var movement_x = _get_movement_input().x * move_speed
	var movement = Vector2(movement_x, movement_y)
	
	if movement.x == 0 && movement.y == 0:
		return idle_state

	parent.velocity = _get_movement_input() * move_speed
	parent.move_and_slide() 

	return null

func process_frame(delta: float) -> State:
	idle_timer -= delta
	if charging:
		charging = false
		return charge_state
	if idle_timer <= 0.0:
		return idle_state

	return null

func _activate_charge() -> void:
	charging = true

func _get_movement_input() -> Vector2:
	return direction
