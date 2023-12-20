class_name GunBullet extends Area2D

@onready var visible_on_screen: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

@export var SPEED = 400
@export var KNOCKBACK_POWER = 100.0
@export var attack_damage = 1
var direction = Vector2.RIGHT

func _ready():
	animation.play("default")

	visible_on_screen.screen_exited.connect(_free_me)
	body_entered.connect(_free_me_body)

func _process(delta):
	position += direction * SPEED * delta

func _free_me():
	self.queue_free()

func _free_me_body(_body):
	self.queue_free()

