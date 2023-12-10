extends CharacterBody2D

@onready var health: HealthComponent = $health_component
@onready var hurtbox: Hurtbox = $Hurtbox

const SPEED = 75.0

func _ready():
	hurtbox.take_damage.connect(_take_damage_bus)
	health.dead.connect(_handle_death)

func _physics_process(_delta):
	pass

func _take_damage_bus(damage: int):
	health.damaged.emit(damage)

func _handle_death():
	hurtbox.take_damage.disconnect(_take_damage_bus)
	health.dead.disconnect(_handle_death)

	# set the death state that will take care of the queue_free()
	self.queue_free()
