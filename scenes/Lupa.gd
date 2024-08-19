extends Area2D
class_name Lupa
enum ModeType{NONE, BIG_ZOOM, SCALE_ITEM, STATIC, ADJUSTABLE_ZOOM, DIFFERENT_LEVEL, INVISIBLE, SCALE_PLAYER}
# Called when the node enters the scene tree for the first time.
@export var mode: ModeType = ModeType.NONE
@export var mainLevel: Node2D
@export var scaledLevel: Node2D
@export var altLevel: Node2D
@export var invisLevel: Node2D
@export var player: CharacterBody2D

@export var bigZoomLevel: float = 1.81
@export var zoomSpeed: float = 8.0
@export var maxAdjustableLevelZoom: = 1.5
@export var minAdjustableLevelZoom: = 1.0
@export var minAdjustablePlayerZoom: = 0.1
@export var maxAdjustablePlayerZoom: = 2

@onready var pitchShiftEffect: AudioEffectPitchShift = AudioServer.get_bus_effect(0, 0)


signal scaleLevelChanged(oldValue: float, newValue: float)

var scaleLevel = 1.0
var insideLupa = false
var scalePlayer = 1.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.frame = mode
	switchLevel(handleModeSwitch())
	if mode == ModeType.ADJUSTABLE_ZOOM: handleLevelScroll(delta)
	if mode == ModeType.SCALE_PLAYER: handlePlayerScroll(delta)
	global_position = get_global_mouse_position()
	pass

func setScaleLevel(value: float):
	scaleLevelChanged.emit(scaleLevel, value)
	scaleLevel = value

func modeUsesCustomTerrain() -> bool:
	return mode in [ModeType.BIG_ZOOM, ModeType.ADJUSTABLE_ZOOM, ModeType.DIFFERENT_LEVEL, ModeType.INVISIBLE]

func scalableMode() -> bool:
	return mode in [ModeType.BIG_ZOOM, ModeType.ADJUSTABLE_ZOOM]

func handleModeSwitch() -> bool:
	var oldMode = mode
	if (Input.is_action_just_pressed("TAB")):
		mode = max((mode + 1) % 7, 1)
	if (Input.is_action_just_pressed("1")): mode = ModeType.BIG_ZOOM
	if (Input.is_action_just_pressed("2")): mode = ModeType.SCALE_ITEM
	if (Input.is_action_just_pressed("3")): mode = ModeType.STATIC
	if (Input.is_action_just_pressed("4")): mode = ModeType.ADJUSTABLE_ZOOM
	if (Input.is_action_just_pressed("5")): mode = ModeType.DIFFERENT_LEVEL
	if (Input.is_action_just_pressed("6")): mode = ModeType.INVISIBLE
	if (Input.is_action_just_pressed("7")): mode = ModeType.SCALE_PLAYER
	return oldMode != mode

func switchLevel(switchingMode):
	if mode != ModeType.SCALE_PLAYER:
		player.scale = Vector2.ONE
	if scalableMode():
		Util.enableNode(scaledLevel)
		if (mode == ModeType.BIG_ZOOM): setScaleLevel(bigZoomLevel)
		if (mode == ModeType.ADJUSTABLE_ZOOM && switchingMode): setScaleLevel(1.0)
		if (mode == ModeType.SCALE_PLAYER && switchingMode): scalePlayer = 1.0
	else: Util.disableNode(scaledLevel)
	
	Util.enableNode(altLevel) if mode == ModeType.DIFFERENT_LEVEL else Util.disableNode(altLevel)
	Util.enableNode(invisLevel) if mode == ModeType.INVISIBLE else Util.disableNode(invisLevel)
	
	var tileMap = Util.findChild(mainLevel, "TileMap") as TileMap
	if modeUsesCustomTerrain():
		tileMap.light_mask = tileMap.light_mask & ~(0b10)
		player.collision_mask = player.collision_mask & ~(0b100)
		player.collision_mask = player.collision_mask | 0b1000
	else:
		tileMap.light_mask = tileMap.light_mask | 0b10
		player.collision_mask = player.collision_mask | 0b100
		player.collision_mask = player.collision_mask & ~(0b1000)
	if mode == ModeType.STATIC:
		player.collision_mask = player.collision_mask | 0b100000
	else:
		player.collision_mask = player.collision_mask & ~(0b100000)

func handleLevelScroll(delta):
	var adjustment = int(Input.is_action_just_released("SCROLL_UP"))-int(Input.is_action_just_released("SCROLL_DOWN"))
	setScaleLevel(min(maxAdjustableLevelZoom, max(minAdjustableLevelZoom, scaleLevel + adjustment * delta * zoomSpeed)))
	
func handlePlayerScroll(delta):
	var adjustment = int(Input.is_action_just_released("SCROLL_UP"))-int(Input.is_action_just_released("SCROLL_DOWN"))
	scalePlayer = (min(maxAdjustablePlayerZoom, max(minAdjustablePlayerZoom, scalePlayer + adjustment * delta * zoomSpeed)))
	updatePlayerScale()
	
func updatePlayerScale():
	player.global_scale = Vector2(scalePlayer, scalePlayer) if insideLupa else Vector2.ONE
	pitchShiftEffect.pitch_scale = float(scalePlayer+1)/float(2*scalePlayer) if scalePlayer > 1 else -pow(scalePlayer, 0.4)+2

func bodyEntered(body):
	insideLupa = true
	updatePlayerScale()

func bodyExited(body):
	insideLupa = false
	updatePlayerScale()
