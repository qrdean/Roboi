class_name RobPlayer extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var movement_state_machine: Node = $movement_state_machine
@onready var player_move_component: Node = $movement_component

# Move into state machine or manager?
@onready var gun: Gun = $Weapon
@onready var health: HealthComponent = $health_component
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var debug_ui: Control = $Debug_UI

@export var shield_charge: int = 400

var time_to_shield: float = 2.0
var shield_charge_timer: float = 0.0

func _ready():
	shield_charge_timer = time_to_shield

	movement_state_machine.init(self, animated_sprite, player_move_component)
	hurtbox.take_damage.connect(_take_damage_bus)
	health.dead.connect(_handle_death)
	debug_ui.init(str(shield_charge), str(gun.max_charge))

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func _process(delta) -> void:
	shield_process(delta)
	movement_state_machine.process_frame(delta)

func _physics_process(delta) -> void:
	shoot_gun()
	movement_state_machine.process_physics(delta)

func shoot_gun() -> void:
	if Input.is_action_just_pressed("attack"):
		gun.shoot()

func shield_process(delta: float) -> void:
	if is_in_state('shield_state'):
		shield_charge_timer = time_to_shield
		return

	if shield_charge < 400:
		shield_charge_timer -= delta
	else:
		shield_charge_timer = time_to_shield

	if shield_charge_timer <= 0:
		shield_charge += 1
		debug_ui.update_shield_text.emit(str(shield_charge))

func _take_damage_bus(damage: int):
	if is_in_state('shield_state'):
		gun.refill_charge.emit(damage)
		return

	health.damaged.emit(damage)
	for i in 4:
		animated_sprite.self_modulate.a = 0.25
		await get_tree().process_frame
		await get_tree().process_frame
		animated_sprite.self_modulate.a = 1.0
		await get_tree().process_frame
		await get_tree().process_frame

func _handle_death():
	pass
	hurtbox.take_damage.disconnect(_take_damage_bus)
	health.dead.disconnect(_handle_death)
	movement_state_machine.change_state(movement_state_machine.get_node('death_state'))


func is_in_state(state_node_name: String) -> bool:
	return movement_state_machine.current_state == movement_state_machine.get_node_or_null(state_node_name)
