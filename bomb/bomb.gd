class_name Bomb
extends CharacterBody2D

@export var _speed: float = 200.0


func _ready() -> void:
	velocity.x = _speed


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()
