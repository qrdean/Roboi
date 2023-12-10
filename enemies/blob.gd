extends CharacterBody2D

@onready var health: HealthComponent = $health_component
@onready var hurtbox: Hurtbox = $Hurtbox

const SPEED = 75.0

func _ready():
	hurtbox.take_damage.connect(_take_damage_bus)
	health.dead.connect(_handle_death)

func _physics_process(_delta):
	pass

func _take_damage_bus():
	health.damaged.emit(1)

func _handle_death():
	print_debug("death of blob")
