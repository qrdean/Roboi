extends Control

@onready var power_text: Label = $power

signal update_power_text(String)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_power_text.connect(_update_power_text)

func init(power_value: String):
	power_text.text = "Power: " + power_value

func _update_power_text(text: String):
	var basetext = "Power: "
	power_text.text = basetext + text


