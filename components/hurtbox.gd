class_name Hurtbox extends Area2D

signal take_damage(int)
signal take_damage_by_type(Enum, int)

func _ready():
	self.area_entered.connect(_area_entered)

func _area_entered(_area: Area2D):
	if _area is EnemyProjectileComponent:
		take_damage_by_type.emit(_area.attack_damage_type, _area.attack_damage)
		return

	if 'attack_damage' in _area:
		take_damage.emit(_area.attack_damage)
	# else:
	# 	take_damage.emit(1)
