extends State

@export var attack_idle: State

var player_detection: Area2D

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

