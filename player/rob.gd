class_name RobPlayer extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var movement_state_machine: Node = $movement_state_machine
@onready var player_move_component: Node = $movement_component

# Move into state machine or manager?
@onready var gun: Node2D = $Weapon
@onready var health: HealthComponent = $health_component
@onready var hurtbox: Hurtbox = $Hurtbox

func _ready():
	movement_state_machine.init(self, animated_sprite, player_move_component)
	hurtbox.take_damage.connect(_take_damage_bus)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func _process(delta) -> void:
	movement_state_machine.process_frame(delta)

func _physics_process(delta) -> void:
	shoot_gun()
	movement_state_machine.process_physics(delta)

func shoot_gun() -> void:
	if Input.is_action_just_pressed("attack"):
		gun.shoot()

func _take_damage_bus(damage: int):
	health.damaged.emit(damage)

