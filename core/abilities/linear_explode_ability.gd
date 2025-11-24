class_name LinearExplodeAbility
extends Ability

@export var distance: int = 1
@export var fire_scene: PackedScene


func execute(
	target_position: Vector2 = Vector2.ZERO,
	# _target_object: Node2D = null,
) -> void:
	var map: TileMapLayer = _level.map
	var local_map: Vector2 = map.to_local(target_position)
	var position: Vector2i = map.local_to_map(local_map)
	prints("EXPLODE POSITION", position)
	var should_stop: bool = _update_cell(position, map)
	if should_stop:
		return

	for cell_x in range(position.x + 1, position.x + distance):
		var cell_pos: Vector2i = Vector2i(cell_x, position.y)
		should_stop = _update_cell(cell_pos, map)
		if should_stop:
			break
	for cell_x in range(position.x - 1, position.x - distance, -1):
		var cell_pos: Vector2i = Vector2i(cell_x, position.y)
		should_stop = _update_cell(cell_pos, map)
		if should_stop:
			break
	for cell_y in range(position.y + 1, position.y + distance):
		var cell_pos: Vector2i = Vector2i(position.x, cell_y)
		should_stop = _update_cell(cell_pos, map)
		if should_stop:
			break
	for cell_y in range(position.y - 1, position.y - distance, -1):
		var cell_pos: Vector2i = Vector2i(position.x, cell_y)
		should_stop = _update_cell(cell_pos, map)
		if should_stop:
			break

	return


func _update_cell(cell_pos: Vector2i, map: TileMapLayer) -> bool:
	var fire: Node2D = fire_scene.instantiate()
	_level.object_holder.add_child(fire)
	fire.global_position = map.to_global(map.map_to_local(cell_pos))

	var cell: TileData = map.get_cell_tile_data(cell_pos)
	if cell:
		# check if destructable
		if cell.get_custom_data("destructable"):
			map.set_cell(cell_pos)
			prints("DESTRUCTION!", cell_pos)

		return true

	return false
