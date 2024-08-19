extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ESC"):
		if !Global.paused:
			get_tree().paused = true
			Global.paused = true
			self.visible = true
		else:
			get_tree().paused = false
			Global.paused = false
			self.visible = false


func _on_resume_pressed():
	get_tree().paused = false
	Sounds.uiclick()
	Global.paused = false


func _on_resume_mouse_entered():
	Sounds.uihover()


func _on_options_pressed():
	get_tree().paused = false
	pass # Replace with function body.


func _on_options_mouse_entered():
	Sounds.uihover()


func _on_main_menu_pressed():
	get_tree().paused = false
	Global.paused = false
	Sounds.uiclick()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_main_menu_mouse_entered():
	Sounds.uihover()


func _on_quit_pressed():
	get_tree().paused = false
	Sounds.uiquit()
	Sounds.uiclick()
	$HBoxContainer.visible = true
	$YouSure.visible = true
	$"?".visible = true
	$"?/AnimationPlayer".play("questionspin")


func _on_quit_mouse_entered():
	Sounds.uihover()


func _on_yes_pressed():
	$ColorRect.visible = true
	$AnimationPlayer.play("quit")
	Sounds.stopmainmenumusic()
	Sounds.uiclick()
	Sounds.uiquityes()
	Sounds.uino()
	$QuitTimer.start()


func _on_yes_mouse_entered():
	Sounds.uihover()


func _on_no_pressed():
	Sounds.uiquitno()
	Sounds.uiclick()
	$HBoxContainer.visible = false
	$YouSure.visible = false
	$"?".visible = false


func _on_no_mouse_entered():
	Sounds.uihover()


func _on_quit_timer_timeout():
	get_tree().quit()
