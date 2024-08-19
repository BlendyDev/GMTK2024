extends CollisionObject2D

@export var lupa: Lupa
@export var tilemap: TileMap
var intersectionRes = preload("res://scenes/intersectionCollision.tscn")
@export var inverseMode := false
@export var tileRadius := 4
@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (lupa.modeUsesCustomTerrain()):
		createTiledIntersection() if inverseMode else createTiledDifference()
	else: createColliders([])

	
##Create colliders based on the intersection of collider areas defined by tiles in tilemap and lupa
func createTiledIntersection():
	var intersectedPolygons = []
	var adjustedPolygons = getAdjustedPolygons(lupa.global_position)
	for polygon in adjustedPolygons:
		intersectedPolygons.append_array(Geometry2D.intersect_polygons(polygon, offsetPolygon(lupa)))
	createColliders(intersectedPolygons)
		
##Create colliders based on the difference of collider areas defined by tiles-lupa
func createTiledDifference():
	var clippedPolygons = []
	var adjustedPolygons = getAdjustedPolygons(player.global_position)

	for polygon in adjustedPolygons:
		clippedPolygons.append_array(Geometry2D.clip_polygons(polygon, offsetPolygon(lupa)))
	var nonHolePolygons = clippedPolygons.filter(func(p: PackedVector2Array): return !Geometry2D.is_polygon_clockwise(p))
	createColliders(nonHolePolygons)
		

##Returns array of offset polygons near lupa's global_position
func getAdjustedPolygons(center: Vector2):
	var tileCoords := tilemap.local_to_map(tilemap.to_local(center))
	var tiles := getNearbyTiles(tileCoords, tileRadius)
	var polygons := offsetTiles(tiles)
	return polygons
	
##Returns tile coordinates near a tile based on radius
func getNearbyTiles(tile, radius) -> Array[Vector2]:
	var tiles: Array[Vector2] = []
	for a in range(-radius, radius):
		for b in range(-radius,radius):
			var currentTile = Vector2(a + tile.x,b + tile.y)
			tiles.append(currentTile)
	return tiles
	
##Returns an array of offset polygons corresponding to the tile
func offsetTiles (tiles) -> Array:
	var offsetPolygons = []
	for tile in tiles:
		offsetPolygons.append(offsetTilePolygon(tile))
	return offsetPolygons

##Offset the collision polygon of a tile (by tile coordinates) based on tilemap's global_scale 
func offsetTilePolygon (tile) -> PackedVector2Array:
	var newPoly = PackedVector2Array()
	var pos = tilemap.to_global(tilemap.map_to_local(tile))
	var polygon = getTileCollision(tile)
	for i in range(0, polygon.size()):
		var vert = polygon[i]
		newPoly.append(Vector2(vert.x * tilemap.global_scale.x + pos.x, vert.y * tilemap.global_scale.y + pos.y))
	return newPoly
	
##Get the collision polygon of a tile (based on tile coordinates)
func getTileCollision(tile) -> PackedVector2Array:
	var tileData = tilemap.get_cell_tile_data(0, tile)
	if (tileData == null): return PackedVector2Array()
	if tileData.get_collision_polygons_count(0) == 0: return PackedVector2Array()
	var polygon = tileData.get_collision_polygon_points(0, 0)
	return polygon

##Lazily create enough children to assign colliders to
func createColliders(unsanitizedPolygons) -> void:
	var polygons = sanitizePolygons(unsanitizedPolygons)
	if (polygons.size() > get_child_count()):
		instantiateChildren(polygons.size() - get_child_count())
	for i in range(0, get_child_count()):
		if (polygons.size() > i):
			if (Geometry2D.triangulate_polygon(polygons[i]).is_empty()): print("wee woo")
			#else: push_warning("fine")
		get_child(i).polygon = polygons[i] if polygons.size() > i else PackedVector2Array()
		
func sanitizePolygons(polygons):
	if (polygons.is_empty()): return polygons
	var sanitizedPolygons := []
	for polygon in polygons:
		if polygon.size() < 3: 
			print("wee woo")
			continue
		if Geometry2D.triangulate_polygon(polygon).is_empty():
			print("Failed to triangulate polygon. Dumping polygon data")
			for vert in polygon:
				print ("Vert: " + Util.parseVector(vert))
			print("Skipping...")
			continue
		sanitizedPolygons.append(polygon)
	return sanitizedPolygons

##Add num new children to intersectionRes
func instantiateChildren(num) -> void:
	for i in range(0, num):
		add_child(intersectionRes.instantiate())

##Offset the collision polygon of an Area2D based on its global_transform
func offsetPolygon (area: Area2D) -> PackedVector2Array:
	var newPoly = PackedVector2Array()
	var collisionPolygon: CollisionPolygon2D = Util.findChild(area, "CollisionPolygon2D")
	var pos = collisionPolygon.global_position
	var trans = collisionPolygon.global_transform
	
	var polygon = collisionPolygon.polygon
	if (collisionPolygon == null):
		return PackedVector2Array()
	for i in range(0, polygon.size()):
		var vert = polygon[i]
		newPoly.append(Vector2(vert.x, vert.y))#why tf did i do this it does nothing lmao
	return trans*newPoly


# UNUSED METHODS #
##Create colliders based on the intersection of collider areas defined by level and lupa
func createIntersection():
	pass
	#var intersectedPolygons = Geometry2D.intersect_polygons(offsetPolygon(level), offsetPolygon(lupa))
	#createColliders(intersectedPolygons)
		
##Create colliders based on the difference of collider areas defined by level-lupa
func createDifference():
	pass
	#var clippedPolygons = Geometry2D.clip_polygons(offsetPolygon(level), offsetPolygon(lupa))
	#var nonHolePolygons = clippedPolygons.filter(func(p: PackedVector2Array): return !Geometry2D.is_polygon_clockwise(p))
	#createColliders(nonHolePolygons)
	



