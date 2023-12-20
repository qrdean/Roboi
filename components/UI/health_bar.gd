extends Control

@onready var progress_bar_ui: ProgressBar = $ProgressBar
var starting_health_percentage = 100
signal update_ui_percentage(float)

# Called when the node enters the scene tree for the first time.
func _ready():
	progress_bar_ui.value = 100.0
	self.update_ui_percentage.connect(_set_bar)

func _set_bar(percentage: float) -> void:
	progress_bar_ui.value = percentage

