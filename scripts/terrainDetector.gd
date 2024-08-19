extends Node


func bodyShapeEntered(body_rid, body, body_shape_index, local_shape_index):
	print("yayzers " + body.get_class())
	if (body is TileMap): processTilemapCollision(body, body_rid)
func processTilemapCollision(body: TileMap, rid):
	print("tilemapey")
	var tilemap := body as TileMap
	var coords := tilemap.get_coords_for_body_rid(rid)
	for i in tilemap.get_layers_count():
		var tileData = tilemap.get_cell_tile_data(i, coords)
		if !tileData is TileData: continue
		var isDeathTile: bool = tileData.get_custom_data_by_layer_id(0)
		if isDeathTile: print("DEATH")
