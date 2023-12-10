class_name GunBullet extends Area2D

@onready var visible_on_screen: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

# @export var resource: BulletResource

@export var SPEED = 400
@export var KNOCKBACK_POWER = 100.0
var direction = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("default")
	# if resource:
	# 	SPEED = resource.bullet_speed
	# 	KNOCKBACK_POWER = resource.knockback_power
	# 	$Sprite2D.texture = resource.texture 

	visible_on_screen.screen_exited.connect(_free_me)
	# self.body_entered.connect(_hit_register)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * SPEED * delta

# func _hit_register(body: Node2D):
# 	if body is Enemy:
# 		var knockback_direction := Vector2(direction.x * KNOCKBACK_POWER, direction.y * KNOCKBACK_POWER)
# 		body.take_damage(knockback_direction)
# 		self.queue_free()

func _free_me():
	self.queue_free()

