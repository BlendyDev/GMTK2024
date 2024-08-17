extends StaticBody2D

@export var lupa: Area2D
@export var level: Area2D
var intersectionRes = preload("res://tmp/intersectionCollision.tscn")
@export var inverseMode = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	createIntersection() if inverseMode else createDifference()
	pass


func createIntersection():
	var intersectedPolygons = Geometry2D.intersect_polygons(offsetPolygon(level), offsetPolygon(lupa))
	createColliders(intersectedPolygons)
		
func createDifference():
	var clippedPolygons = Geometry2D.clip_polygons(offsetPolygon(level), offsetPolygon(lupa))
	var nonHolePolygons = clippedPolygons.filter(func(p: PackedVector2Array): return !Geometry2D.is_polygon_clockwise(p))
	createColliders(nonHolePolygons)

func createColliders(polygons):
	if (polygons.size() > get_child_count()):
		instantiateChildren(polygons.size() - get_child_count())
	for i in range(0, get_child_count()):
		get_child(i).polygon = polygons[i] if polygons.size() > i else PackedVector2Array()

func instantiateChildren(num):
	for i in range(0, num):
		add_child(intersectionRes.instantiate())

func offsetPolygon (area: Area2D):
	var newPoly = PackedVector2Array()
	var pos = area.global_position
	var trans = area.global_transform
	var collisionPolygon: CollisionPolygon2D = Util.findChild(area, "CollisionPolygon2D")
	var polygon = collisionPolygon.polygon
	if (collisionPolygon == null):
		return null
	for i in range(0, polygon.size()):
		var vert = polygon[i]
		newPoly.append(Vector2(vert.x, vert.y))
	return trans*newPoly
	
	
