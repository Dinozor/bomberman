class_name SpawnObjectAbility
extends Ability

@export var object_to_spawn: PackedScene


func execute(
	_player: Player = null, target_position: Vector2 = Vector2.ZERO, _target_object: Node2D = null
) -> void:
	var map: TileMapLayer = _level.map
	var local_point: Vector2 = map.to_local(target_position)
	var map_point: Vector2i = map.local_to_map(local_point)

	var tile: TileData = map.get_cell_tile_data(map_point)
	if tile:
		# TODO: check if can spawn on top of it (like fire/water etc.)
		print_debug("Tile is not empty! Can not spawn object!", object_to_spawn)
		return

	local_point = map.map_to_local(map_point)

	var object: Node2D = object_to_spawn.instantiate()
	var holder: Node = _level.bomb_holder
	holder.add_child(object)
	object.global_position = map.to_global(local_point)
