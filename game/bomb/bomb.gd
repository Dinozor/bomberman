class_name Bomb
extends CharacterBody2D

# @export var _speed: float = 200.0
@export var timer: float = 3.0
@export var _bomb_sprite: Sprite2D
@export var _active_bomb_sprite: Sprite2D
@export var _abilities: Array[Ability]
@export var auto_activate: bool = true
var _time_left: float = timer
var _time_to_blink: float = 1.0


func _ready() -> void:
	set_process(false)
	if auto_activate:
		await get_tree().create_timer(1.0).timeout
		activate()


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()


func _process(delta: float) -> void:
	_time_left -= delta
	_time_to_blink -= delta
	if _time_to_blink <= 0.0:
		_blink()
		_time_to_blink = _time_left / timer
	if _time_left <= 0.0:
		explode()


func _blink() -> void:
	_bomb_sprite.visible = !_bomb_sprite.visible
	_active_bomb_sprite.visible = !_active_bomb_sprite.visible


func activate() -> void:
	_time_left = timer
	_blink()
	set_process(true)


func explode() -> void:
	for ability in _abilities:
		ability.execute(global_position)

	queue_free()
