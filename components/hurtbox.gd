class_name Hurtbox extends Area2D

signal take_damage(int)

func _ready():
	self.area_entered.connect(_area_entered)

func _area_entered(_area: Area2D):
	if 'attack_damage' in _area:
	# if _area is GunBullet: dunno if better? Maybe more generic high level for damage type areas
		take_damage.emit(_area.attack_damage)
	else:
		take_damage.emit(1)
