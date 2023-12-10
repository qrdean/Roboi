class_name Hurtbox extends Area2D

signal take_damage

func _ready():
	self.area_entered.connect(_area_entered)

func _area_entered(_area: Area2D):
	take_damage.emit()
