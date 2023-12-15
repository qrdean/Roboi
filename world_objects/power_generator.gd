extends StaticBody2D

@export var power_generator_amount := 5000
@export var power_generator_recharge := 10.0

@onready var debug_ui: Control = $Debug_UI

var player_charging := false

func _ready():
	debug_ui.init(str(power_generator_amount))

func _process(delta):
	if player_charging:
		power_generator_recharge = 10.0
		power_generator_amount -= 1
		debug_ui.update_power_text.emit(str(power_generator_amount))
	else:
		power_generator_recharge -= delta
		if power_generator_recharge <= 0.0:
			power_generator_amount += 1
			debug_ui.update_power_text.emit(str(power_generator_amount))

func _on_area_2d_body_entered(player: RobPlayer):
	player.power_generation = true
	player.power_full.connect(_handle_power_full)
	player_charging = true

func _on_area_2d_body_exited(player: RobPlayer):
	player.power_generation = false
	player_charging = false
	player.power_full.disconnect(_handle_power_full)

func _handle_power_full(power_full: bool):
	player_charging = !power_full
