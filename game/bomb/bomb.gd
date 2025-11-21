class_name Bomb
extends CharacterBody2D

@export var _speed: float = 200.0
@export var _abilities: Array[Ability]


func _ready() -> void:
	velocity.x = _speed
	await get_tree().create_timer(3.0).timeout
	explode()


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()


func explode() -> void:
	for ability in _abilities:
		ability.execute(null, global_position)

	queue_free()
