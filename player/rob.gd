class_name RobPlayer extends CharacterBody2D

# @export var SPEED: float = 150.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var movement_state_machine: Node = $movement_state_machine
@onready var player_move_component: Node = $movement_component

func _ready():
	# animated_sprite.play("default")
	movement_state_machine.init(self, animated_sprite, player_move_component)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func _process(delta) -> void:
	movement_state_machine.process_frame(delta)
	# var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	# handle_walk_anim(direction)

func _physics_process(delta) -> void:
	movement_state_machine.process_physics(delta)
	# var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	# if direction.x != 0 or direction.y != 0:
	# 	last_direction = direction

	# if direction:
	# 		velocity = direction * SPEED
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)
	# 	velocity.y = move_toward(velocity.y, 0, SPEED)

	# if cant_move:
	# 	velocity = Vector2.ZERO
	# move_and_slide()

func handle_walk_anim(direction: Vector2) -> void:
	if direction.x > 0:
		animated_sprite.flip_h = true
		animated_sprite.play("floatside")
	if direction.y > 0:
		animated_sprite.play("floatdown")
	if direction.x < 0:
		animated_sprite.flip_h = false
		animated_sprite.play("floatside")
	if direction.y < 0:
		animated_sprite.play("floatup")

	if direction.x == 0 and direction.y == 0:
		animated_sprite.play("default")

