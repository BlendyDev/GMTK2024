extends StaticBody2D

@export var lupa: Area2D
@export var level: Area2D
@export var intersection: CollisionPolygon2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var intersectedPolygons = Geometry2D.intersect_polygons(offsetPolygon(lupa), offsetPolygon(level))
	intersection.polygon = intersectedPolygons[0] if intersectedPolygons.size() > 0 else PackedVector2Array()
	pass

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
	
	
