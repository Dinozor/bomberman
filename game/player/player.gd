class_name Player
extends CharacterBody2D

@export var _friction: float = 100.0

@export var _spawn_point: Node2D
@export var _audio_player: AudioStreamPlayer2D

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity", 980.0)
var _is_facing_left: bool = false
var _playback: AudioStreamPlaybackPolyphonic


func _ready() -> void:
	_playback = _audio_player.get_stream_playback() as AudioStreamPlaybackPolyphonic


func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta
	if is_on_floor():
		if velocity.x > 0.0:
			velocity.x = max(0.0, velocity.x - _friction * delta)
		else:
			velocity.x = min(0.0, velocity.x + _friction * delta)
	move_and_slide()


func get_spawn_point() -> Vector2:
	return _spawn_point.global_position


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
