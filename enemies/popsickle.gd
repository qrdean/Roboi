extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var movement_state_machine: Node = $movement_state_machine
@onready var movement_component = $movement_component

@onready var health: HealthComponent = $health_component
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var player_detection: Area2D = $player_detection

@export var player_node_name: String

const SPEED = 75.0

func _ready():
	# Get the player from the parent tree. Set to the movement component for tracking
	var player_node: CharacterBody2D = get_parent().get_node(player_node_name)
	movement_component.init(player_node, player_detection)
 
	for child in movement_state_machine.get_children():
		child.player_detection = player_detection

	movement_state_machine.init(self, animated_sprite, movement_component)
	hurtbox.take_damage.connect(_take_damage_bus)
	health.dead.connect(_handle_death)

func _unhandled_input(event):
	movement_state_machine.process_input(event)

func _physics_process(delta):
	movement_state_machine.process_physics(delta)

func _process(delta):
	movement_state_machine.process_frame(delta)

func _take_damage_bus(damage: int):
	health.damaged.emit(damage)

func _handle_death():
	hurtbox.take_damage.disconnect(_take_damage_bus)
	health.dead.disconnect(_handle_death)

	# set the death state that will take care of the queue_free()
	self.queue_free()
