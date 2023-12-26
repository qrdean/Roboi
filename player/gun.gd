class_name Gun extends Node2D

@export var bullet_scene: PackedScene
@export var max_charge: int = 10

const SCALE_DEGREE = 5

var weapon_charge: int

signal refill_charge(int)

func _ready():
	weapon_charge = max_charge
	refill_charge.connect(_refill_weapon_charge)

func _physics_process(_delta):
	orbit_around_parent()

func orbit_around_parent():
	var mouse_position: Vector2 = get_global_mouse_position()

	# Get the vector between the player and the mouse position and normalize it
	var direction: Vector2 = (mouse_position - get_parent().position).normalized() * SCALE_DEGREE
	self.position = direction

func shoot():
	if weapon_charge > 0:
		weapon_charge -= 1
		var percentage = get_parent().get_percentage(weapon_charge as float, max_charge as float)
		get_parent().ui_overlay_node.update_ammo_ui.emit(percentage)
		# get_parent().debug_ui.update_ammo_text.emit(str(weapon_charge))
		var bullet = bullet_scene.instantiate()
		bullet.position = self.global_position
		bullet.direction = (get_global_mouse_position() - get_parent().global_position).normalized()
		get_parent().call_deferred("add_sibling", bullet)
	

func _refill_weapon_charge(charge: int):
	weapon_charge += charge
	weapon_charge = clampi(weapon_charge, 0, max_charge)
	var percentage = get_parent().get_percentage(weapon_charge as float, max_charge as float)
	get_parent().ui_overlay_node.update_ammo_ui.emit(percentage)
	# get_parent().debug_ui.update_ammo_text.emit(str(weapon_charge))
