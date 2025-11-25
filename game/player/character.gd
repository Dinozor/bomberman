class_name Character
extends CharacterBody2D

@export var _friction: float = 1000.0
@export var _air_friction: float = 100.0
@export var _acceleration: float = 800.0
@export var _speed: float = 200.0

@export var _spawn_point: Node2D
@export var _audio_player: AudioStreamPlayer2D
@export var _bomb_range: int = 2

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity", 980.0)
var _is_facing_left: bool = false
var _playback: AudioStreamPlaybackPolyphonic
var _direction: float = 0.0


func _ready() -> void:
	_playback = _audio_player.get_stream_playback() as AudioStreamPlaybackPolyphonic


func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta
	if _direction != 0.0:
		velocity.x = move_toward(velocity.x, _direction * _speed, _acceleration * delta)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0.0, _friction * delta)
		else:
			velocity.x = move_toward(velocity.x, 0.0, _air_friction * delta)
	move_and_slide()


func get_spawn_point() -> Vector2:
	return _spawn_point.global_position


func get_bomb_range() -> int:
	return _bomb_range


func set_bomb_range(bomb_range: int) -> void:
	_bomb_range = bomb_range


func set_direction(direction: float) -> void:
	_direction = direction


func get_direction() -> float:
	return _direction


func look_left() -> void:
	if _is_facing_left:
		return
	scale.x = -scale.x
	_is_facing_left = true


func look_right() -> void:
	if _is_facing_left:
		scale.x = -scale.x
		_is_facing_left = false


func play_sfx(stream: AudioStream) -> void:
	_playback.play_stream(stream)
