extends Node


func _process(delta):
	pass
func processTilemapCollision(body: TileMap, rid):
	print("tilemapey")
	var tilemap := body as TileMap
	var coords := tilemap.get_coords_for_body_rid(rid)
	for i in tilemap.get_layers_count():
		var tileData = tilemap.get_cell_tile_data(i, coords)
		if !tileData is TileData: continue
		
#THIS WORKS (its the #7 with body) i tried usin
func bodyShapeEntered(body_rid, body, body_shape_index, local_shape_index):
	print("yayzers " + body.name)
	if (body is TileMap): processTilemapCollision(body, body_rid)
#also if instead of area2d i made terrainDetector a staticbody2d it also didnt work
#with bodyShapeEntered
func areaShapeEntered(area_rid, area, area_shape_index, local_shape_index):
	#this also never worked
	print("yayzers (area shap) " + area.name)


#i can try add one thats not dynamic and test ig
func areaEntered(area):
	pass # Replace with function body.
