extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.puzzleWin = false
	Global.haswon = false
	$Transitions.play("fadein")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.changeScreen:
		$TransitionTime.start()
		$Transitions.play("fadeout")
			


func _on_transition_time_timeout():
	Global.changeScreen = false
	get_tree().reload_current_scene()
