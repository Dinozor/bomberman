class_name Level
extends Node

@export var map: StupidTilemap
@export var players: Array[Character]
@export var bomb_holder: Node
@export var object_holder: Node

var _game_manager: GameManager = GameManager


func _ready() -> void:
	_game_manager.start(self)
