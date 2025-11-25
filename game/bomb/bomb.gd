class_name Bomb
extends RigidBody2D

@export var timer: float = 3.0
@export var _bomb_sprite: Sprite2D
@export var _active_bomb_sprite: Sprite2D
@export var _abilities: Array[Ability]
@export var auto_activate: bool = true
@export var _explode_sound: AudioStream

var _time_left: float = timer
var _time_to_blink: float = 1.0
var _character: Character


func _ready() -> void:
	set_process(false)
	if auto_activate:
		await get_tree().create_timer(1.0).timeout
		activate()


func _process(delta: float) -> void:
	_time_left -= delta
	_time_to_blink -= delta
	if _time_to_blink <= 0.0:
		_time_to_blink = _time_left / timer
		_blink()
	if _time_left <= 0.0:
		explode()


func set_character(character: Character) -> void:
	_character = character


func activate() -> void:
	_time_left = timer
	_time_to_blink = _time_left / timer
	_blink()
	set_process(true)


func explode() -> void:
	if _character:
		_character.play_sfx(_explode_sound)
		for ability in _abilities:
			ability.execute(global_position, _character)

	queue_free()


func _blink() -> void:
	_bomb_sprite.visible = !_bomb_sprite.visible
	_active_bomb_sprite.visible = !_active_bomb_sprite.visible
