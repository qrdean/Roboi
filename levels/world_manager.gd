class_name SceneManager extends Node2D

@export var levels: Array[PackedScene]
var current_scene: World
var next_scene_idx: int

# Called when the node enters the scene tree for the first time.
func _ready():
	if levels[0]:
		next_scene_idx = 0
		load_scene(levels[0])
	else:
		print_debug("ERROR: no levels set in scene manager")

func load_scene(level: PackedScene):
	# TODO: Add some kind of scene change animation
	var next_level: World = level.instantiate()
	next_scene_idx += 1

	if next_scene_idx < levels.size():
		next_level.next_level_scene = levels[next_scene_idx]

	call_deferred("add_child", next_level)
	if current_scene:
		current_scene.queue_free()

	current_scene = next_level
	current_scene.load_next_level.connect(load_scene)

