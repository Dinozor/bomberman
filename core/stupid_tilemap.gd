class_name StupidTilemap
extends TileMapLayer

var _scene_instances: Dictionary[Vector2i, Node2D]


func _ready():
	update_internals()

	for child in get_children():
		var cell_coords: Vector2i = local_to_map(child.position)
		_scene_instances[cell_coords] = child as Node2D


func get_scene_at_cell(coords: Vector2i) -> Node2D:
	if _scene_instances.has(coords):
		return _scene_instances[coords]
	return null
