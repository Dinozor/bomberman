class_name JetpackAbility
extends Ability

@export var _power: float = 100.0


func execute(
	owner: Character = null,
	_target_position: Vector2 = Vector2.ZERO,
	_target_object: Node2D = null,
) -> void:
	owner.velocity.y -= _power
