class_name StupidTilemap
extends TileMapLayer

var _scene_instances: Dictionary[Vector2i, Node2D]


func _ready():
	child_entered_tree.connect(_on_child_entered_tree)
	child_exiting_tree.connect(_on_child_exited_tree)


func get_scene_at_cell(coords: Vector2i) -> Node2D:
	if _scene_instances.has(coords):
		return _scene_instances[coords]
	return null


func _on_child_entered_tree(child: Node) -> void:
	var cell_coords: Vector2i = local_to_map(child.position)
	_scene_instances[cell_coords] = child as Node2D


func _on_child_exited_tree(child: Node) -> void:
	var cell_coords: Vector2i = local_to_map(child.position)
	_scene_instances.erase(cell_coords)
	erase_cell(cell_coords)
