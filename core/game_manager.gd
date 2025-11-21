# class_name GameManager # autoload
extends Node

signal level_changed(level: Level)
signal level_started(level: Level)

@export var audio_stream_player: AudioStreamPlayer
var _current_level: Level
var _audio_playback: AudioStreamPlaybackPolyphonic


func _ready() -> void:
	_audio_playback = audio_stream_player.get_stream_playback() as AudioStreamPlaybackPolyphonic


func start(level: Level) -> void:
	set_current_level(level)
	level_started.emit(_current_level)


func get_current_level() -> Level:
	return _current_level


func set_current_level(level: Level) -> void:
	_current_level = level
	level_changed.emit(_current_level)


func play_sfx(stream: AudioStream) -> void:
	_audio_playback.play_stream(stream)
