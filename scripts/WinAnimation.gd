extends Node2D

@onready var player: Player = self.get_parent()

func _on_animation_player_animation_finished(anim_name):
	player.onDanceFinished()
	$Sprite2D.visible = false
