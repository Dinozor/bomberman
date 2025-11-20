class_name LinearExplodeAbility
extends Ability

@export var distance: int = 1
@export var fire_scene: PackedScene


func execute(context: AbilityContext = null) -> void:
	if not context:
		printerr("Ability must have context")
		return
	# explosion animation
	# get surrounding tiles in allowed directions
	# spawn at those tiles Fire projectiles/sprites etc.
	# projectiles can have their own ability to damager whatever they touch
	# finish ability
	var map: TileMapLayer = context.level_tilemap
	var position: Vector2i = context.position
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
		map.add_child(fire)
		fire.position = map.map_to_local(cell_pos)

		return true
	else:
		# spawn fire particle
		var fire: Node2D = fire_scene.instantiate()
		map.add_child(fire)
		fire.position = map.map_to_local(cell_pos)
		prints("Boom!", cell_pos)

	return false
