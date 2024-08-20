extends Node2D
class_name OnOffManager
var active: bool = false
signal activate()
signal deactivate()

# Called when the node enters the scene tree for the first time.
func _ready():
	makeActive()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("L")):
		if active: makeInctive()
		else: makeActive()
	pass

func makeActive():
	active = true
	activate.emit()
func makeInctive():
	active = false
	deactivate.emit()
