extends State

@export var attack_idle: State

var player_detection: Area2D
var weapon_component: WeaponComponent
var player_node: CharacterBody2D

var frame_numbers := 0.5
var number_of_shots := 3.0

var current_shot_count := 0.0
var current_frame_count := 0.0

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

	current_shot_count = number_of_shots
	current_frame_count = frame_numbers

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	current_frame_count -= delta
	if current_frame_count <= 0.0:
		current_frame_count = frame_numbers
		current_shot_count -= 1.0
		weapon_component.shoot(player_node)

	if current_shot_count <= 0.0:
		return attack_idle

	return super(delta)
