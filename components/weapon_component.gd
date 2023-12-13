class_name WeaponComponent extends Node2D

@export var bullet_scene: PackedScene

# const SCALE_DEGREE = 15

func _ready():
	pass

func _physics_process(_delta):
	pass

func shoot(target: Node2D):
	var bullet = bullet_scene.instantiate()
	bullet.position = self.global_position
	bullet.direction = (target.global_position - self.global_position).normalized()
	get_parent().call_deferred("add_sibling", bullet)
	
