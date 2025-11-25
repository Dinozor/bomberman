# class_name GameManager # autoload
extends Node

signal level_changed(level: Level)
signal level_started(level: Level)

@export var audio_stream_player: AudioStreamPlayer
@onready var end_screen: CanvasLayer = %EndScreen

@onready var green_won_label: Label = %GreenWonLabel
@onready var yellow_won_label: Label = %YellowWonLabel
@onready var restart_button: Button = %RestartButton

var _current_level: Level

var _audio_playback: AudioStreamPlaybackPolyphonic


func _ready() -> void:
	_audio_playback = audio_stream_player.get_stream_playback() as AudioStreamPlaybackPolyphonic
	restart_button.pressed.connect(_on_restart_button_pressed)


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


func character_died(character_name: String) -> void:
	if character_name == "YellowCharacter":
		yellow_won_label.show()
	else:
		green_won_label.show()
	end_screen.show()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
