class_name Fire
extends Area2D

@export var _timer: Timer


func _ready() -> void:
	_timer.timeout.connect(_on_timer_timeout)
	body_entered.connect(_on_body_entered)


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	print_debug(body)
