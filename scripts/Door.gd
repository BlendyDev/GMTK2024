extends Area2D

var canenter = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "idle"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if canenter:
		if Input.is_action_just_pressed("TAB"):
			Global.isEntering = true
	if Global.isEntering:
		$EnterAnimationTime.start()
		
	#var tween = get_tree().create_tween()
	#tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1), 2)

func _on_body_entered(body):
	canenter = true


func _on_win_zone_body_entered(body):
	Global.puzzleWin = true


func _on_enter_animation_time_timeout():
	$AnimatedSprite2D.animation = "enter"
