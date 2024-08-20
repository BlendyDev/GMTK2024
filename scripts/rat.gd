extends Area2D
var stoppedTalking = false
var talking = false
var hastalked = false
var gotlupa = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$RichTextLabel.visible_ratio = 0
	$TextureRect.modulate = "ffffff00"
	$RichTextLabel.modulate = "ffffff00"
	$Label.modulate = "ffffff00"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hastalked:
		$AnimationPlayer.play("fadeout")
		$AnimationPlayer2.stop()
		Sounds.blink()
		$TextFadeOut.start()
		hastalked = false
		gotlupa = true
		$BlinkSound.start()
		if $BlinkSound.is_stopped():
			Sounds.stopblink()
		var tween = get_tree().create_tween()
		tween.tween_property($Label, "modulate", Color(1, 1, 1), 0.1)
		tween.tween_property($Label, "scale", 1.5, 0.1)
	if $TextFadeOut.is_stopped():
		var tween2 = get_tree().create_tween()
		tween2.tween_property($Label, "modulate", Color(1, 1, 1, 0), 0.1)
		hastalked = false
	if $TalkingTime.is_stopped():
		Sounds.stopratvoice()
	pass
	#if Global.playerTurtle:
		
			
		#var tween = get_tree().create_tween()
	
		#tween.tween_property($TextureRect, "modulate", Color(1, 1, 1), 0.2)
		#tween.tween_property($RichTextLabel, "modulate", Color(1, 1, 1), 0.2)
		#Sounds.turtlevoice()
		#tween.tween_property($RichTextLabel, "visible_ratio", 1, 1.0).set_trans(Tween.TRANS_BOUNCE)
		
		#Sounds.stopturtlevoice()
		#$TalkingTime.start()
			
		
	#else:
		#$TextureRect.visible = false
		#$RichTextLabel.visible = false
	#if talking:
		

func _on_area_entered(area: Area2D) -> void:
	
	var tween = get_tree().create_tween()
	
	tween.tween_property($RichTextLabel, "visible_ratio", 0, 1).set_trans(Tween.TRANS_BOUNCE)


func _on_body_entered(body: Node2D) -> void:
	if !gotlupa:
		Sounds.newdialogue()
		stoppedTalking = false
		$AnimatedSprite2D.animation = "talk"
		$TextureRect.visible = true
		$RichTextLabel.visible = true
		$AnimationPlayer.play("fadein")
		if !hastalked:
			$AnimationPlayer2.play("text")
			$TalkingTime.start()
		if !stoppedTalking:
			$SoundTime.start()
			$AnimationTime.start()
		else:
			$SoundTime.stop()
			$AnimationTime.stop()


func _on_talking_time_timeout() -> void:
	hastalked = true
	Sounds.stopratvoice()
	$AnimatedSprite2D.animation = "idle"
	stoppedTalking = true



func _on_body_exited(body: Node2D) -> void:
	
	$AnimatedSprite2D.animation = "idle"
	Sounds.stopratvoice()
	$TalkingTime.stop()
	if !gotlupa:
		$AnimationPlayer.play("fadeout")
		$AnimationPlayer2.stop()
		Sounds.hidedialogue()
	


func _on_sound_time_timeout() -> void:
	Sounds.ratvoice()
	$SoundTime.start()


#func _on_animation_time_timeout() -> void:
	#if $AnimatedSprite2D.frame == 0:
		#$AnimatedSprite2D.frame = $AnimatedSprite2D.frame + 1
	#else:
		#$AnimatedSprite2D.frame = $AnimatedSprite2D.frame - 1
	#$AnimationTime.start()
