extends Camera2D
class_name Cam

@export var player: CharacterBody2D
@export var wrapSpeed: = 600.0
@export var accel := 1500.0
var initialOffset := self.offset

var currentX: float = 0
var currentY: float = 0
var currentScreenX :int
var currentScreenY: int
var widthX: float
var widthY: float
var endX: float
var endY: float
var progressX: float
var progressY: float
var movingX := 0
var movingY := 0

func _process(delta):
	var cameraSize: Vector2 = get_viewport_rect().size / self.zoom
	
	widthX = cameraSize.x * 0.95
	endX = widthX * currentScreenX
	progressX = ((self.global_position.x + self.offset.x) - widthX * currentScreenX)/(widthX)
	
	widthY = cameraSize.y * 0.95
	endY = widthY * currentScreenY
	progressY = ((self.global_position.y + self.offset.y) - widthY * currentScreenY)/(widthY)
	
	if player.global_position.x - currentX > 0.47*cameraSize.x || movingX == 1:
		movingX = 1
		self.offset.x = move_toward(self.offset.x, endX + widthX, delta * (wrapSpeed + (pow((1 - progressX), 1.5) + 0.005) * accel))
		if (self.offset.x == endX + widthX): updateX()
	elif player.global_position.x - currentX < -0.47*cameraSize.x || movingX == -1:
		movingX = -1
		self.offset.x = move_toward(self.offset.x, endX - widthX, delta * (wrapSpeed + (pow((1 + progressX), 1.5) + 0.005) * accel))
		if (self.offset.x == endX - widthX): updateX()
	else:
		updateX()
		
	if player.global_position.y - currentY > 0.47*cameraSize.y || movingY == 1:
		movingY = 1
		self.offset.y = move_toward(self.offset.y, endY + widthY, delta * (wrapSpeed + (pow((1 - progressY), 1.5) + 0.005) * accel))
		if (self.offset.y == endY + widthY): updateY()
	elif player.global_position.y - currentY < -0.47*cameraSize.y || movingY == -1:
		movingY = -1
		self.offset.y = move_toward(self.offset.y, endY - widthY, delta * (wrapSpeed + (pow((1 + progressY), 1.5) + 0.005) * accel))
		if (self.offset.y == endY - widthY): updateY()
	else:
		updateY()
	
func updateX():
	movingX = 0
	currentScreenX = floor(self.global_position.x + self.offset.x / widthX)
	currentX = (self.global_position.x + self.offset.x)
	
func updateY():
	movingY = 0
	currentScreenY = floor(self.global_position.y + self.offset.y / widthY)
	currentY = (self.global_position.y + self.offset.y)
	
func reset():
	self.offset = initialOffset
	movingX = 0
	progressX = 0
	movingY = 0
	progressY = 0
	updateX()
	updateY()
