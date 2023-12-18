class_name WeaponComponent extends Node2D

@export var bullet_scene: PackedScene

# const SCALE_DEGREE = 15

func _ready():
	pass

func _physics_process(_delta):
	pass

func shoot(target: Node2D, projectile_type: EnemyProjectileComponent.PROJECTILE_TYPE):
	var bullet = bullet_scene.instantiate()

	if 'attack_damage_type' in bullet and projectile_type != null:
		bullet.attack_damage_type = projectile_type
	 
	bullet.position = self.global_position
	bullet.direction = (target.global_position - self.global_position).normalized()
	get_parent().call_deferred("add_sibling", bullet)
	
