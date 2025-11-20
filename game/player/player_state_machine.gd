class_name PlayerStateMachine
extends Node

enum State {
	IDLE,
	MOVING,
	HIT,
	DUCKING,
	JUMPING,
}
@export var _player: Player
@export var _animated_sprite: AnimatedSprite2D
# @export var _audio_stream_player: AudioStreamPlayer
@export var _duck_collider: CollisionShape2D
@export var _stand_collider: CollisionShape2D

var _state: State = State.IDLE
var _is_facing_left: bool = false


func _ready() -> void:
	_stand_collider.disabled = false
	_duck_collider.disabled = true


func _process(_delta: float) -> void:
	match _state:
		State.IDLE:
			_state_idle()
		State.MOVING:
			_state_moving()
		State.DUCKING:
			_state_ducking()
		State.JUMPING:
			_state_jumping()


func _state_idle() -> void:
	if _player.velocity.x != 0.0:
		_state = State.MOVING
	elif not _player.is_on_floor():
		_state = State.JUMPING
	if Input.is_action_pressed(&"duck"):
		_state = State.DUCKING
	_animated_sprite.play(&"idle")
	_stand_collider.disabled = false
	_duck_collider.disabled = true


func _state_moving() -> void:
	if _player.velocity.x == 0.0:
		_state = State.IDLE

	if _player.velocity.x < 0.0:
		_is_facing_left = true
	else:
		_is_facing_left = false

	_animated_sprite.flip_h = _is_facing_left
	_animated_sprite.play(&"walk")


func _state_ducking() -> void:
	if not Input.is_action_pressed(&"duck"):
		_state = State.IDLE
	_animated_sprite.play(&"duck")
	_stand_collider.disabled = true
	_duck_collider.disabled = false


func _state_jumping() -> void:
	if _player.is_on_floor():
		_state = State.IDLE
	_animated_sprite.play(&"jump")
