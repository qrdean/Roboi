class_name RobPlayer extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var movement_state_machine: Node = $movement_state_machine
@onready var player_move_component: Node = $movement_component

# Move into state machine or manager?
@onready var gun: Gun = $Weapon

@onready var health: HealthComponent = $health_component
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var debug_ui: Control = $Debug_UI
@onready var pickup_area: PlayerPickupArea = $pickup_area

@export var shield_charge: int = 400
@export var replacement_color_red: Color
@export var replacement_color_green: Color
@export var replacement_color_blue: Color

var time_to_shield: float = 2.0
var shield_charge_timer: float = 0.0
var power_generation := false
var power_generation_timer = 2.0
var batter_key_pickedup := false

signal power_full(bool)
signal charging(bool)

var current_shield_index: int = 0

enum SHIELD_COLORS{
	RED,
	BLUE,
	GREEN,
	LENGTH
}

var current_shield_type: SHIELD_COLORS
var shield_color_planes: Dictionary

func _ready():
	shield_color_planes = {
		SHIELD_COLORS.RED: replacement_color_red,
		SHIELD_COLORS.BLUE: replacement_color_blue,
		SHIELD_COLORS.GREEN: replacement_color_green
	}

	current_shield_type = SHIELD_COLORS.RED
	animated_sprite.material.set_shader_parameter("u_replacement_color", replacement_color_red)

	shield_charge_timer = time_to_shield

	movement_state_machine.init(self, animated_sprite, player_move_component)
	hurtbox.take_damage.connect(_take_damage_bus)
	hurtbox.take_damage_by_type.connect(_take_damage_bus_by_type)
	health.dead.connect(_handle_death)
	pickup_area.item_pickedup.connect(_item_pickup)
	debug_ui.init(str(shield_charge), str(gun.max_charge))

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func _process(delta) -> void:
	next_shield()
	process_power_generation(delta)
	shield_process(delta)
	movement_state_machine.process_frame(delta)

func _physics_process(delta) -> void:
	shoot_gun()
	movement_state_machine.process_physics(delta)

func shoot_gun() -> void:
	if Input.is_action_just_pressed("attack"):
		if !movement_state_machine.is_in_state('shield_state'):
			gun.shoot()

func next_shield() -> void:
	if Input.is_action_just_pressed('next_shield'):
		current_shield_type = (current_shield_type + 1) % SHIELD_COLORS.LENGTH as SHIELD_COLORS
		var replacement_color = shield_color_planes.get(current_shield_type)

		animated_sprite.material.set_shader_parameter("u_replacement_color", replacement_color)


func shield_process(delta: float) -> void:
	if movement_state_machine.is_in_state('shield_state'):
		shield_charge_timer = time_to_shield
		return

	if shield_charge < 400:
		shield_charge_timer -= delta
	else:
		shield_charge_timer = time_to_shield

	if shield_charge_timer <= 0:
		shield_charge += 1
		debug_ui.update_shield_text.emit(str(shield_charge))

func process_power_generation(delta) -> void:
	if power_generation:
		if gun.weapon_charge == gun.max_charge:
			power_full.emit(true)
			power_generation_timer = 2.0
		else:
			power_full.emit(false)
			power_generation_timer -= delta

		if power_generation_timer <= 0:
			gun.refill_charge.emit(1)
			power_generation_timer = 0.5

	else:
		power_generation_timer = 2.0

func _take_damage_bus_by_type(attack_damage_type: EnemyProjectileComponent.PROJECTILE_TYPE, attack_damage: int):
	if movement_state_machine.is_in_state('shield_state'):
		var shield_match = projectile_type_to_shield_type_enum(attack_damage_type)
		if shield_match == current_shield_type:
			gun.refill_charge.emit(attack_damage)
			return
		else:
			shield_charge -= attack_damage * 5
			debug_ui.update_shield_text.emit(str(shield_charge))
	
	health.damaged.emit(attack_damage)
	for i in 4:
		animated_sprite.self_modulate.a = 0.25
		await get_tree().process_frame
		await get_tree().process_frame
		animated_sprite.self_modulate.a = 1.0
		await get_tree().process_frame
		await get_tree().process_frame

func projectile_type_to_shield_type_enum(projectile_type: EnemyProjectileComponent.PROJECTILE_TYPE) -> SHIELD_COLORS:
	match projectile_type:
		EnemyProjectileComponent.PROJECTILE_TYPE.RED:
			return SHIELD_COLORS.RED
		EnemyProjectileComponent.PROJECTILE_TYPE.GREEN:
			return SHIELD_COLORS.GREEN
		EnemyProjectileComponent.PROJECTILE_TYPE.BLUE:
			return SHIELD_COLORS.BLUE

	return SHIELD_COLORS.LENGTH

func _take_damage_bus(damage: int):
	if movement_state_machine.is_in_state('shield_state'):
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

func set_power_generation(p_power_generation: bool) -> bool:
	power_generation = p_power_generation
	if power_generation:
		return gun.weapon_charge == gun.max_charge
	else:
		return false

func _handle_death():
	pass
	# hurtbox.take_damage.disconnect(_take_damage_bus)
	# health.dead.disconnect(_handle_death)
	# movement_state_machine.change_state(movement_state_machine.get_node('death_state'))


func _item_pickup(item_name: String):
	if item_name == 'battery_key':
		batter_key_pickedup = true
