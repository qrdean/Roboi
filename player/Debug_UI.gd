extends Control

@onready var shield_text: Label = $shield
@onready var ammo_text: Label = $ammo
@onready var debug_ui: Control = $Debug_UI

signal update_shield_text(String)
signal update_ammo_text(String)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_shield_text.connect(_update_shield_text)
	update_ammo_text.connect(_update_ammo_text)

func init(shield_value: String, ammo_value: String):
	shield_text.text = "Shield: " + shield_value + "%"
	ammo_text.text = "Ammo: " + ammo_value

func _update_shield_text(text: String):
	var basetext = "Shield: "
	shield_text.text = basetext + text + "%"

func _update_ammo_text(text: String):
	var basetext = "Ammo: "
	ammo_text.text = basetext + text

