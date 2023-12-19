class_name HealthComponent extends Node

@export var max_health: int

var current_health

# Incoming
signal damaged(int)
signal restore(int)

# Outgoing
signal dead
signal health_restored

func _ready():
	if max_health:
		current_health = max_health

	self.damaged.connect(_take_damage)
	self.restore.connect(_restore_health)

func _take_damage(damage: int) -> void:
	current_health -= damage
	if current_health <= 0:
		dead.emit()

func _restore_health(health: int) -> void:
	current_health += health
	current_health = clampi(current_health, 0, max_health)
	health_restored.emit()

func get_percentage_health() -> float:
	return (current_health as float/max_health as float) * 100
