class_name PickableHolder
extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if not body is Character:
		return

	var character: Character = body as Character
	var bomb_range: int = character.get_bomb_range()
	character.set_bomb_range(bomb_range + 1)
	queue_free()
