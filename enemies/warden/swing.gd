class_name Swing extends State

@export var attack_idle: State
@export var time_to_wind := 1.5
@export var hitbox: Hitbox

enum SWING_STATES{
	WINDUP,
	SWING
}

@onready var wind_up := time_to_wind
@onready var inner_state: SWING_STATES = SWING_STATES.WINDUP

var player_detection

func enter() -> void:
	super()
	# animations.play('swing_wind_up')
	animations.animation_finished.connect(_animation_finished)

func exit() -> void:
	animations.animation_finished.disconnect(_animation_finished)
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	match inner_state:
		SWING_STATES.WINDUP:
			wind_up -= delta
			if wind_up <= 0.0:
				inner_state = SWING_STATES.SWING
				return null

		SWING_STATES.SWING:
			hitbox.set_active()
			# animations.play('swing_attack')
			if animations.get_animation():
				return null

			pass

	return null

func process_physics(_delta: float) -> State:
	return null

func get_movement_input() -> Vector2:
	return move_component.get_movement_direction()

func _animation_finished():
	# if inner_state = SWING_STATES.SWING:
	# 	animations.something
	pass
