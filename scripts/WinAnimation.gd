extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.puzzleWin and !Global.haswon:
		Sounds.stoptutorialmusic()
		$AnimationPlayer.play("dance")
		#if $AnimationPlayer.animation_finished:
			#self.visible = false
			#Global.puzzleWin = false


func _on_win_timer_timeout():
	$AnimationPlayer.stop()
	self.visible = false
	Global.puzzleWin = false
