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
	
func shoot_at_point(target: Vector2, projectile_type: EnemyProjectileComponent.PROJECTILE_TYPE):
	var bullet = bullet_scene.instantiate()

	if 'attack_damage_type' in bullet and projectile_type != null:
		bullet.attack_damage_type = projectile_type
	 
	bullet.position = self.global_position
	bullet.direction = (target - self.global_position).normalized()
	get_parent().call_deferred("add_sibling", bullet)
	
func shoot_pattern(target: Array[Vector2], projectile_type: EnemyProjectileComponent.PROJECTILE_TYPE):
	var bullets: Array[Area2D] = []
	for target_pos in target:
		var bullet = bullet_scene.instantiate()

		if 'attack_damage_type' in bullet and projectile_type != null:
			bullet.attack_damage_type = projectile_type

		bullet.position = self.global_position
		# print_debug((target_pos - self.global_position).normalized())
		# bullet.direction = (target_pos - self.global_position).normalized()
		bullet.direction = target_pos
		bullets.append(bullet)
	
	for bullet in bullets:
		get_parent().call_deferred('add_sibling', bullet)

