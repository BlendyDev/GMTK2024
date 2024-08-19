extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sounds.uienter()
	$AnimationPlayer.play("faces")
	$AnimationPlayer2.play("main")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	Sounds.uiclick()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_back_mouse_entered() -> void:
	Sounds.uihover()
