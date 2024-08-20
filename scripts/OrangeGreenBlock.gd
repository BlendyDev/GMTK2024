extends Node2D
enum BlockType{ORANGE, GREEN}
@export var type: BlockType
@onready var animationPlayer: AnimationPlayer = Util.findChild(self, "AnimationPlayer")
@onready var collisionShape: CollisionShape2D = Util.findChild(self, "CollisionShape2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	(get_parent() as OnOffManager).activate.connect(activate)
	(get_parent() as OnOffManager).deactivate.connect(deactivate)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func activate():
	if (type == BlockType.ORANGE):
		animationPlayer.play("orangeFadeIn")
		collisionShape.disabled = false
	if (type == BlockType.GREEN):
		animationPlayer.play("greenFadeOut")
		collisionShape.disabled = true
	pass # Replace with function body.


func deactivate():
	if (type == BlockType.ORANGE):
		animationPlayer.play("orangeFadeOut")
		collisionShape.disabled = true
	if (type == BlockType.GREEN):
		animationPlayer.play("greenFadeIn")
		collisionShape.disabled = false
	pass # Replace with function body.
