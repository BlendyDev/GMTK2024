extends Node2D
@export var offset: Vector2 = Vector2.ZERO
@export var lupa: Node2D
@onready var child: Area2D = self.get_child(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	adjustPos()
	scaleHandle()
	
func adjustPos():
	global_position = lupa.global_position
	child.position = -lupa.global_position

func scaleHandle():
	var scaleAdj = Input.get_axis("SCROLL_DOWN", "SCROLL_UP")
	global_scale.x = max(1, global_scale.x + scaleAdj*0.01)
	global_scale.y = max(1, global_scale.y + scaleAdj*0.01)
	print(str(global_scale.x))
