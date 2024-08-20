extends Area2D

var canenter = false
var hasEntered = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print ($EnterAnimationTime.time_left)
	if canenter:
		if Input.is_action_just_pressed("NEXT"):
			Global.isEntering = true
	if Global.isEntering:
		if $EnterAnimationTime.is_stopped() and !hasEntered:
			$EnterAnimationTime.start()
		
	#var tween = get_tree().create_tween()
	#tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1), 2)

func _on_body_entered(body):
	canenter = true


func _on_win_zone_body_entered(body):
	Global.puzzleWin = true


func _on_enter_animation_time_timeout():
	hasEntered = true
	print ("yeehaw")
	$AnimationPlayer.play("enter")
	$BlinkSound.start()


func _on_body_exited(body):
	print ("nahhh")
	canenter = false




func _on_blink_sound_timeout():
	Sounds.blink()
