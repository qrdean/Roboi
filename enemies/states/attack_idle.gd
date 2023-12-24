class_name AIAttackIdleState extends State

@export var attack_fire: State

var player_detection: Area2D

var firing := false

func enter() -> void:
	super()
	animations.play('default')
	player_detection.player_detected.connect(_activate_fire)

func exit() -> void:
	player_detection.player_detected.disconnect(_activate_fire)

func process_physics(_delta: float) -> State:
	return null

func process_frame(_delta: float) -> State:
	if firing:
		firing = false
		return attack_fire
	return null

func _activate_fire():
	firing = true
