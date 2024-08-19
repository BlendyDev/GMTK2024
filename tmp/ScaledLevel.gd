extends Node2D
@export var offset: Vector2 = Vector2.ZERO
@export var lupa: Node2D
@onready var child: TileMap = self.get_child(0)
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

func _process(delta):
	adjustPos()
	
func adjustPos():
	global_position = lupa.global_position
	child.position = -lupa.global_position

func scaleLevelChange(oldValue, newValue):
	global_scale.x = newValue ** 2
	global_scale.y = newValue ** 2
