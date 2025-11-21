class_name LinearExplodeAbility
extends Ability

@export var distance: int = 1
@export var fire_scene: PackedScene


func execute(
	_owner: Player = null,
	target_position: Vector2 = Vector2.ZERO,
	_target_object: Node2D = null,
) -> void:
	var map: TileMapLayer = _level.map
	var local_map: Vector2 = map.to_local(target_position)
	var position: Vector2i = map.local_to_map(local_map)
	prints("EXPLODE POSITION", position)

	for cell_x in range(position.x + 1, position.x + distance):
		var cell_pos: Vector2i = Vector2i(cell_x, position.y)
		var should_stop: bool = _update_cell(cell_pos, map)
		if should_stop:
			break
	for cell_x in range(position.x - 1, position.x - distance, -1):
		var cell_pos: Vector2i = Vector2i(cell_x, position.y)
		var should_stop: bool = _update_cell(cell_pos, map)
		if should_stop:
			break
	for cell_y in range(position.y + 1, position.y + distance):
		var cell_pos: Vector2i = Vector2i(position.x, cell_y)
		var should_stop: bool = _update_cell(cell_pos, map)
		if should_stop:
			break
	for cell_y in range(position.y - 1, position.y - distance, -1):
		var cell_pos: Vector2i = Vector2i(position.x, cell_y)
		var should_stop: bool = _update_cell(cell_pos, map)
		if should_stop:
			break

	return


func _update_cell(cell_pos: Vector2i, map: TileMapLayer) -> bool:
	var cell: TileData = map.get_cell_tile_data(cell_pos)
	if cell:
		# check if destructable
		map.set_cell(cell_pos)

		prints("DESTRUCTION!", cell_pos)

		var fire: Node2D = fire_scene.instantiate()
		_level.object_holder.add_child(fire)
		fire.global_position = map.to_global(map.map_to_local(cell_pos))

		return true
	else:
		# spawn fire particle
		var fire: Node2D = fire_scene.instantiate()
		_level.object_holder.add_child(fire)
		fire.global_position = map.to_global(map.map_to_local(cell_pos))

		prints("Boom!", cell_pos)

	return false
