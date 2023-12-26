class_name UI_Overlay extends CanvasLayer

@onready var health_ui: Control = $Player_Values/Health
@onready var shield_ui: Control = $Player_Values/Shield
@onready var ammo_ui: Control = $Player_Values/Ammo
@onready var battery_ui: Label = $TextureRect/Label

var starting_percentage = 100

signal update_health_ui(float)
signal update_shield_ui(float)
signal update_ammo_ui(float)
signal update_battery_ui(int)

# Called when the node enters the scene tree for the first time.
func _ready():
	health_ui.value = starting_percentage
	shield_ui.value = starting_percentage
	ammo_ui.value = starting_percentage
	battery_ui.text = "0"

	update_health_ui.connect(_update_health_ui)
	update_shield_ui.connect(_update_shield_ui)
	update_ammo_ui.connect(_update_ammo_ui)
	update_battery_ui.connect(_update_battery_ui)

func _update_health_ui(percentage: float):
	health_ui.value = percentage 

func _update_shield_ui(percentage: float):
	shield_ui.value = percentage 

func _update_ammo_ui(percentage: float):
	ammo_ui.value = percentage 

func _update_battery_ui(numb: int):
	battery_ui.text = str(numb)
