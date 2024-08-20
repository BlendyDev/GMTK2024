extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sounds.uienter()
	$HBoxContainer.visible = false
	$YouSure.visible = false
	$"?".visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	Sounds.uiclick()
	get_tree().change_scene_to_file("res://scenes/level/tutorial/tutorial.tscn")

func _on_play_mouse_entered() -> void:
	Sounds.uihover()

func _on_options_pressed() -> void:
	Sounds.uiclick()
	get_tree().change_scene_to_file("res://path/to/scene.tscn")

func _on_options_mouse_entered() -> void:
	Sounds.uihover()

func _on_credits_pressed() -> void:
	Sounds.uiclick()
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func _on_credits_mouse_entered() -> void:
	Sounds.uihover()

func _on_quit_pressed() -> void:
	Sounds.uiquit()
	Sounds.uiclick()
	$HBoxContainer.visible = true
	$YouSure.visible = true
	$"?".visible = true
	$"?/AnimationPlayer".play("questionspin")

func _on_quit_mouse_entered() -> void:
	Sounds.uihover()

func _on_yes_pressed() -> void:
	$ColorRect.visible = true
	$AnimationPlayer.play("quit")
	Sounds.stopmainmenumusic()
	Sounds.uiclick()
	Sounds.uiquityes()
	Sounds.uino()
	$QuitTimer.start()

func _on_yes_mouse_entered() -> void:
	Sounds.uihover()

func _on_no_pressed() -> void:
	Sounds.uiquitno()
	Sounds.uiclick()
	$HBoxContainer.visible = false
	$YouSure.visible = false
	$"?".visible = false

func _on_no_mouse_entered() -> void:
	Sounds.uihover()


func _on_quit_timer_timeout() -> void:
	get_tree().quit()
