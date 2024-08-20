extends Camera2D

@export var player: CharacterBody2D
@export var wrapSpeed: = 200.0
@export var accel := 150.0
var currentX: float = 0

func _process(delta):
	var cameraSize = get_viewport_rect().size / self.zoom
	
	if (player.global_position.x - currentX > 0.47*cameraSize.x):
		var end = currentX-self.global_position.x + cameraSize.x * 0.95
		var progress = (self.offset.x - currentX)/(end - currentX)
		self.offset.x = move_toward(self.offset.x, end, delta * wrapSpeed + (pow((1 - progress), 1.5) + 0.005) * accel)
	elif player.global_position.x - currentX < -0.47*cameraSize.x:
		var end = currentX-self.global_position.x - cameraSize.x * 0.95
		var progress = (self.offset.x - currentX)/(end - currentX)
		self.offset.x = move_toward(self.offset.x, end, delta * wrapSpeed + (pow((1 - progress), 1.5) + 0.005) * accel)
	else: currentX = (self.global_position.x + self.offset.x)
	#global_position.x = player.global_position.x
