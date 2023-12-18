class_name AIAttackFireState extends State

@export var attack_idle: State
@export var number_of_shots: float = 3.0
@export var fire_rate: float = 0.5
@export var projectile_type: EnemyProjectileComponent.PROJECTILE_TYPE

var player_detection: Area2D
var weapon_component: WeaponComponent
var player_node: CharacterBody2D

var current_shot_count := 0.0
var current_frame_count := 0.0

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

	current_shot_count = number_of_shots
	current_frame_count = fire_rate

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	current_frame_count -= delta
	if current_frame_count <= 0.0:
		current_frame_count = fire_rate
		current_shot_count -= 1.0
		weapon_component.shoot(player_node, projectile_type)

	if current_shot_count <= 0.0:
		return attack_idle

	return super(delta)
