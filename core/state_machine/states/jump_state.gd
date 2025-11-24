class_name JumpState
extends State

@export var _player: Player
@export var _animated_sprite: AnimatedSprite2D
@export var _idle_state: State
@export var _body: CharacterBody2D

var _state_machine: StateMachine


func _ready() -> void:
	var parent: Node = get_parent()
	assert(parent is StateMachine, "Must be child of StateMachine")
	_state_machine = parent
	set_physics_process(false)


func _physics_process(_delta: float) -> void:
	if _body.is_on_floor():
		_state_machine.transition_to(_idle_state)


func enter() -> void:
	_player.execute_jump_ability()
	_animated_sprite.play(&"jump")
	set_physics_process(true)


func exit() -> void:
	set_physics_process(false)
