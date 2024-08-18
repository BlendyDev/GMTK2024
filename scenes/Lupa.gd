extends Area2D
class_name Lupa
enum ModeType{NONE, BIG_ZOOM, ZOOM_OUT, STATIC, ADJUSTABLE_ZOOM, DIFFERENT_LEVEL, INVISIBLE}
# Called when the node enters the scene tree for the first time.
@export var mode: ModeType = ModeType.NONE
@export var mainLevel: Node2D
@export var scaledLevel: Node2D
@export var altLevel: Node2D
@export var invisLevel: Node2D
@export var player: CharacterBody2D

func modeUsesCustomTerrain() -> bool:
	return mode in [ModeType.BIG_ZOOM, ModeType.ZOOM_OUT, ModeType.ADJUSTABLE_ZOOM, ModeType.DIFFERENT_LEVEL, ModeType.INVISIBLE]

func handleModeSwitch ():
	if (Input.is_action_just_pressed("TAB")):
		mode = max((mode + 1) % 7, 1)
	if (Input.is_action_just_pressed("1")): mode = 1
	if (Input.is_action_just_pressed("2")): mode = 2
	if (Input.is_action_just_pressed("3")): mode = 3
	if (Input.is_action_just_pressed("4")): mode = 4
	if (Input.is_action_just_pressed("5")): mode = 5
	if (Input.is_action_just_pressed("6")): mode = 6
	
func switchLevel(mode):
	Util.enableMode(scaledLevel) if mode in [ModeType.BIG_ZOOM, ModeType.ZOOM_OUT, ModeType.ADJUSTABLE_ZOOM] else Util.disableNode(scaledLevel)
	Util.enableMode(altLevel) if mode == ModeType.DIFFERENT_LEVEL else Util.disableNode(altLevel)
	Util.enableMode(invisLevel) if mode == ModeType.INVISIBLE else Util.disableNode(invisLevel)
	var tileMap = Util.findChild(mainLevel, "TileMap") as TileMap
	if modeUsesCustomTerrain():
		tileMap.light_mask = tileMap.light_mask & ~(0b10)
		player.collision_mask = player.collision_mask & ~(0b100)
	else:
		tileMap.light_mask = tileMap.light_mask | 0b10
		player.collision_mask = player.collision_mask | 0b100
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.frame = mode
	handleModeSwitch()
	switchLevel(mode)
	global_position = get_global_mouse_position()
	pass
