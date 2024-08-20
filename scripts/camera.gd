extends Camera2D

@export var player: CharacterBody2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position.x = player.global_position.x
	self.global_position.y = player.global_position.y
