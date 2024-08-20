extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Sounds.winmusic()
	GemsUIs.get_child(0).visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_quit_mouse_entered():
	Sounds.uihover()
