extends StaticBody2D
@onready var animationPlayer: AnimationPlayer = Util.findChild(self, "AnimationPlayer")
@onready var onOffManager: OnOffManager = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	onOffManager.activate.connect(activate)
	onOffManager.deactivate.connect(deactivate)

func activate():
	animationPlayer.play("toRed")
	pass
func deactivate():
	animationPlayer.play("toGreen")
	pass


func bodyEntered(body):
	if onOffManager.active: onOffManager.makeInctive()
	else: onOffManager.makeActive()
