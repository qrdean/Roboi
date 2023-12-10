class_name Gun extends Node2D

@export var bullet_scene: PackedScene

const SCALE_DEGREE = 15

# var weapon_resource: WeaponResource
# var bullet_resource: BulletResource

func _ready():
	pass
	# if weapon_resource:
	# 	if weapon_resource.texture:
	# 		$Sprite2D.texture = weapon_resource.texture
	# 	if weapon_resource.bullet_scene:
	# 		bullet_scene = weapon_resource.bullet_scene
	# 	if weapon_resource.bullet_resource:
	# 		bullet_resource = weapon_resource.bullet_resource

func _physics_process(_delta):
	orbit_around_parent()

func orbit_around_parent():
	var mouse_position: Vector2 = get_global_mouse_position()
	# Get the vector between the player and the mouse position and normalize it
	var direction: Vector2 = (mouse_position - get_parent().position).normalized() * SCALE_DEGREE
	self.position = direction

func shoot():
	var bullet = bullet_scene.instantiate()
	# bullet.resource = bullet_resource
	bullet.position = self.global_position
	bullet.direction = (get_global_mouse_position() - self.global_position).normalized()
	get_parent().call_deferred("add_sibling", bullet)
	
# func set_stats(weapon_stats: WeaponResource):
# 	bullet_scene = weapon_stats.bullet_scene
# 	$Sprite2D.texture = weapon_stats.texture
#	  bullet_resource = weapon_stats.bullet_resource


