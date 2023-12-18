class_name EnemyProjectileComponent extends Area2D

@onready var visible_on_screen: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

@export var SPEED = 400
@export var KNOCKBACK_POWER = 100.0
@export var attack_damage = 1
@export var attack_damage_type: PROJECTILE_TYPE  

@export var replacement_color_red: Color
@export var replacement_color_green: Color
@export var replacement_color_blue: Color

var direction = Vector2.RIGHT

enum PROJECTILE_TYPE {
	RED,
	BLUE,
	GREEN
}

var projectile_color_planes: Dictionary

func _ready():
	animation.play("default")
	projectile_color_planes = {
  	PROJECTILE_TYPE.RED: replacement_color_red,
		PROJECTILE_TYPE.BLUE: replacement_color_blue,
		PROJECTILE_TYPE.GREEN: replacement_color_green
	}
	
	var color_replacement = projectile_color_planes.get(attack_damage_type)
	animation.material.set_shader_parameter("u_replacement_color", color_replacement)

	visible_on_screen.screen_exited.connect(_free_me)

func _process(delta):
	position += direction * SPEED * delta

func _free_me():
	self.queue_free()
