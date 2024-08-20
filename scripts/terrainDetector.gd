extends Node

@onready var player: Player = self.get_parent()

func processTilemapCollision(body: TileMap, rid):
	var tilemap := body as TileMap
	var coords := tilemap.get_coords_for_body_rid(rid)
	for i in tilemap.get_layers_count():
		var tileData = tilemap.get_cell_tile_data(i, coords)
		if !tileData is TileData: continue
		
func bodyShapeEntered(body_rid, body, body_shape_index, local_shape_index):
	if (body is TileMap && (body as TileMap).name.to_lower().contains("spike")):
		print("death")
		handleDeath()
	
func areaShapeEntered(area_rid, area, area_shape_index, local_shape_index):
	if (area is Area2D && (area as Area2D).name.to_lower().contains("spike")):
		print("death")
		handleDeath()

func handleDeath():
	Global.hasDied = true
	Sounds.deathsound()
	player.resetLevel()
