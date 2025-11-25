class_name LinearExplodeAbility
extends Ability

@export var fire_scene: PackedScene
@export var ability: Ability
var _distance: int = 1
var _character: Character


func execute(
	target_position: Vector2 = Vector2.ZERO,
	character: Character = null,
) -> void:
	_character = character
	_distance = character.get_bomb_range()
	var map: StupidTilemap = _level.map
	var local_map: Vector2 = map.to_local(target_position)
	var position: Vector2i = map.local_to_map(local_map)
	var should_stop: bool = _update_cell(position, map)
	if should_stop:
		return

	for cell_x in range(position.x + 1, position.x + _distance):
		var cell_pos: Vector2i = Vector2i(cell_x, position.y)
		should_stop = _update_cell(cell_pos, map)
		if should_stop:
			break
	for cell_x in range(position.x - 1, position.x - _distance, -1):
		var cell_pos: Vector2i = Vector2i(cell_x, position.y)
		should_stop = _update_cell(cell_pos, map)
		if should_stop:
			break
	for cell_y in range(position.y + 1, position.y + _distance):
		var cell_pos: Vector2i = Vector2i(position.x, cell_y)
		should_stop = _update_cell(cell_pos, map)
		if should_stop:
			break
	for cell_y in range(position.y - 1, position.y - _distance, -1):
		var cell_pos: Vector2i = Vector2i(position.x, cell_y)
		should_stop = _update_cell(cell_pos, map)
		if should_stop:
			break

	return


func _update_cell(cell_pos: Vector2i, map: StupidTilemap) -> bool:
	var fire: Node2D = fire_scene.instantiate()
	_level.object_holder.add_child(fire)
	var pos: Vector2 = map.to_global(map.map_to_local(cell_pos))
	fire.global_position = pos
	var source_id: int = map.get_cell_source_id(cell_pos)

	if source_id == -1:
		return false
	if source_id == 0:
		var cell: TileData = map.get_cell_tile_data(cell_pos)
		if cell:
			# check if destructable
			if cell.get_custom_data("destructable"):
				map.set_cell(cell_pos)
				if ability:
					ability.execute(pos, _character)

			return true
	if source_id == 1:
		var scene_cell: Node2D = map.get_scene_at_cell(cell_pos)
		if scene_cell and scene_cell.has_method(&"destroy"):
			scene_cell.destroy()
			return true

	return false
