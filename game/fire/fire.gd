class_name Fire
extends Area2D

@export var _timer: Timer


func _ready() -> void:
	_timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	queue_free()
