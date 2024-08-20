extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.hasWon = false
	$Transitions.play("fadein")
	Sounds.tutorialmusic()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.changeScreen:
		$Transitions.play("fadeout")
			


func _on_transition_time_timeout():
	Global.changeScreen = false


func transitionFinished(anim_name):
	if (Global.changeScreen):
		Global.changeScreen = false
		get_tree().change_scene_to_file("res://scenes/level/level1/level1.tscn")
	pass # Replace with function body.
