extends CharacterBody2D

@onready var movement_state_machine: Node = $BaseStateMachine
@onready var attack_state_machine: Node = $attack_state_machine
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var movement_component = $MovementComponent

@onready var weapon_component: WeaponComponent = $weapon_component

@onready var player_detection: Area2D = $player_detection

@export var player_node_name: String

func _ready():
	# Get the player from the parent tree. Set to the movement component for tracking
	var player_node: CharacterBody2D = get_parent().get_node(player_node_name)
	movement_component.init(player_node, player_detection)

	for child in movement_state_machine.get_children():
		child.player_detection = player_detection

	for child in attack_state_machine.get_children():
		child.player_detection = player_detection
		if child is AIAttackFireState:
			child.weapon_component = weapon_component
			child.player_node = player_node

	# var attack_state = attack_state_machine.get_node_or_null(fire_node_name)
	# if attack_state:
	# 	attack_state.weapon_component = weapon_component
	# 	attack_state.player_node = player_node

	movement_state_machine.init(self, animated_sprite, movement_component)
	attack_state_machine.init(self, animated_sprite, movement_component)
	# hurtbox.take_damage.connect(_take_damage_bus)
	# health.dead.connect(_handle_death)

func _unhandled_input(event):
	movement_state_machine.process_input(event)

func _physics_process(delta):
	movement_state_machine.process_physics(delta)
	attack_state_machine.process_physics(delta)

func _process(delta):
	movement_state_machine.process_frame(delta)
	attack_state_machine.process_frame(delta)
