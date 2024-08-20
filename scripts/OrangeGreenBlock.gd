extends Node2D
enum BlockType{ORANGE, GREEN}
@export var type: BlockType
@onready var animationPlayer: AnimationPlayer = Util.findChild(self, "AnimationPlayer")
@onready var collisionShape: CollisionShape2D = Util.findChild(self, "CollisionShape2D")


func _ready():
	(get_parent() as OnOffManager).activate.connect(activate)
	(get_parent() as OnOffManager).deactivate.connect(deactivate)


func activate():
	if (type == BlockType.ORANGE):
		animationPlayer.play("orangeFadeIn")
		collisionShape.set_deferred("disabled", false)
	if (type == BlockType.GREEN):
		animationPlayer.play("greenFadeOut")
		collisionShape.set_deferred("disabled", true)

func deactivate():
	if (type == BlockType.ORANGE):
		animationPlayer.play("orangeFadeOut")
		collisionShape.set_deferred("disabled", true)
	if (type == BlockType.GREEN):
		animationPlayer.play("greenFadeIn")
		collisionShape.set_deferred("disabled", false)
	pass # Replace with function body.
