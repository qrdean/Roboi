class_name RoomDoor extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_detection: Area2D = $player_detection

func _ready():
	player_detection.body_entered.connect(_open_door)
	animation_player.animation_finished.connect(_remove_door)

func _open_door(body: Node2D):
	if body is RobPlayer and body.battery_key_pickedup:
		body.battery_key_pickedup = false
		body.ui_overlay_node.update_battery_ui.emit(0)
		open_door()

func _remove_door(anim_name: String):
	if anim_name == 'open':
		self.queue_free()

func open_door():
	animation_player.play('open')
