class_name Popsickle extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var movement_state_machine: Node = $movement_state_machine
@onready var movement_component = $movement_component

@onready var attack_state_machine: Node = $attack_state_machine

@onready var health: HealthComponent = $health_component
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var player_detection: Area2D = $player_detection
@onready var weapon_component: WeaponComponent = $weapon_component

@export var player_node_name: String
@export var fire_node_name: String

const SPEED = 75.0

func _ready():
	# Get the player from the parent tree. Set to the movement component for tracking
	var player_node: CharacterBody2D = get_parent().get_node(player_node_name)
	movement_component.init(player_node, player_detection)
 
	for child in movement_state_machine.get_children():
		child.player_detection = player_detection

	for child in attack_state_machine.get_children():
		child.player_detection = player_detection

	var attack_state = attack_state_machine.get_node_or_null(fire_node_name)
	if attack_state:
		attack_state.weapon_component = weapon_component
		attack_state.player_node = player_node
		pass

	movement_state_machine.init(self, animated_sprite, movement_component)
	attack_state_machine.init(self, animated_sprite, movement_component)
	hurtbox.take_damage.connect(_take_damage_bus)
	health.dead.connect(_handle_death)

func _unhandled_input(event):
	movement_state_machine.process_input(event)

func _physics_process(delta):
	movement_state_machine.process_physics(delta)
	attack_state_machine.process_physics(delta)

func _process(delta):
	movement_state_machine.process_frame(delta)
	attack_state_machine.process_frame(delta)

func _take_damage_bus(damage: int):
	health.damaged.emit(damage)
	for x in 4:
		animated_sprite.self_modulate.a = 0.5
		await get_tree().process_frame
		await get_tree().process_frame
		animated_sprite.self_modulate.a = 1.0
		await get_tree().process_frame
		await get_tree().process_frame

func _handle_death():
	hurtbox.take_damage.disconnect(_take_damage_bus)
	health.dead.disconnect(_handle_death)

	# set the death state that will take care of the queue_free()
	self.queue_free()
