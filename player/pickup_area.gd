class_name PlayerPickupArea extends Area2D

signal item_pickedup(String)

func _ready():
	area_entered.connect(_item_entered)

func _item_entered(item: Area2D):
	if 'item_name' in item:
		item_pickedup.emit(item.item_name)
	else:
		item_pickedup.emit(item.name)

	item.queue_free()
