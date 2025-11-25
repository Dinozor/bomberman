class_name MaxBombxPickable
extends Area2D


func _on_body_entered(body: Node) -> void:
	if not body.is_in_group(&"character"):
		return

	# find required upgrade slot
	# upgrade/change the upgrade to attached one
