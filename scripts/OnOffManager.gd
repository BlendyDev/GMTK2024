extends Node2D
class_name OnOffManager
var active: bool = false
signal activate()
signal deactivate()

func _ready():
	makeActive()

func makeActive():
	active = true
	activate.emit()

func makeInctive():
	active = false
	deactivate.emit()
