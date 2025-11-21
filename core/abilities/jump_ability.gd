class_name JumpAbility
extends Ability

@export var jump_speed: float = 400.0
@export var _sfx: AudioStream


func execute(
	owner: Player = null,
	_target_position: Vector2 = Vector2.ZERO,
	_target_object: Node2D = null,
) -> void:
	if owner.is_on_floor():
		owner.velocity.y -= jump_speed
		owner.play_sfx(_sfx)
