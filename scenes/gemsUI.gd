extends Control
class_name GemsUI
enum GemType{RED, ORANGE, YELLOW, GREEN, BLUE, PINK, PURPLE}
# Called when the node enters the scene tree for the first time.
@export var unlockedGems: Array[GemType] = []
@onready var redGemSprite = preload("res://sprites/gem/redGem.png")
@onready var orangeGemSprite = preload("res://sprites/gem/orangeGem.png")
@onready var yellowGemSprite = preload("res://sprites/gem/yellowGem.png")
@onready var greenGemSprite = preload("res://sprites/gem/greenGem.png")
@onready var blueGemSprite = preload("res://sprites/gem/blueGem.png")
@onready var pinkGemSprite = preload("res://sprites/gem/pinkGem.png")
@onready var purpleGemSprite = preload("res://sprites/gem/purpleGem.png")

@onready var redGrayedSprite = preload("res://sprites/gem/redGrayed.png")
@onready var orangeGrayedSprite = preload("res://sprites/gem/orangeGrayed.png")
@onready var yellowGrayedSprite = preload("res://sprites/gem/yellowGrayed.png")
@onready var greenGrayedSprite = preload("res://sprites/gem/greenGrayed.png")
@onready var blueGrayedSprite = preload("res://sprites/gem/blueGrayed.png")
@onready var pinkGrayedSprite = preload("res://sprites/gem/pinkGrayed.png")
@onready var purpleGrayedSprite = preload("res://sprites/gem/purpleGrayed.png")

@onready var redGemUI = $CanvasLayer/PanelContainer/HBoxContainer/RedGem
@onready var orangeGemUI = $CanvasLayer/PanelContainer/HBoxContainer/OrangeGem
@onready var yellowGemUI = $CanvasLayer/PanelContainer/HBoxContainer/YellowGem
@onready var greenGemUI = $CanvasLayer/PanelContainer/HBoxContainer/GreenGem
@onready var blueGemUI = $CanvasLayer/PanelContainer/HBoxContainer/BlueGem
@onready var pinkGemUI = $CanvasLayer/PanelContainer/HBoxContainer/PinkGem
@onready var purpleGemUI = $CanvasLayer/PanelContainer/HBoxContainer/PurpleGem



func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if unlockedGems.has(GemType.RED): redGemUI.texture = redGemSprite
	else: redGemUI.texture = redGrayedSprite
	if unlockedGems.has(GemType.ORANGE): orangeGemUI.texture = orangeGemSprite
	else: orangeGemUI.texture = orangeGrayedSprite
	if unlockedGems.has(GemType.YELLOW): yellowGemUI.texture = yellowGemSprite
	else: yellowGemUI.texture = yellowGrayedSprite
	if unlockedGems.has(GemType.GREEN): greenGemUI.texture = greenGemSprite
	else: greenGemUI.texture = greenGrayedSprite
	if unlockedGems.has(GemType.BLUE): blueGemUI.texture = blueGemSprite
	else: blueGemUI.texture = blueGrayedSprite
	if unlockedGems.has(GemType.PINK): pinkGemUI.texture = pinkGemSprite
	else: pinkGemUI.texture = pinkGrayedSprite
	if unlockedGems.has(GemType.PURPLE): purpleGemUI.texture = purpleGemSprite
	else: purpleGemUI.texture = purpleGrayedSprite
	pass
