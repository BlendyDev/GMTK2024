extends Area2D
var stoppedTalking = false
var talking = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sounds.stopturtlevoice()
	$RichTextLabel.visible_ratio = 0
	$TextureRect.modulate = "ffffff00"
	$RichTextLabel.modulate = "ffffff00"
	$AnimatedSprite2D.animation = "idle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $TalkingTime.is_stopped():
		Sounds.stopturtlevoice()
	pass
	
		

func _on_area_entered(area: Area2D) -> void:
	
	var tween = get_tree().create_tween()
	
	tween.tween_property($RichTextLabel, "visible_ratio", 0, 1).set_trans(Tween.TRANS_BOUNCE)


func _on_body_entered(body: Node2D) -> void:
	Sounds.newdialogue()
	stoppedTalking = false
	$AnimatedSprite2D.animation = "talk"
	$TextureRect.visible = true
	$RichTextLabel.visible = true
	$AnimationPlayer.play("fadein")
	$AnimationPlayer2.play("text")
	$TalkingTime.start()
	if !stoppedTalking:
		$SoundTime.start()
		$AnimationTime.start()
	else:
		$SoundTime.stop()
		$AnimationTime.stop()


func _on_talking_time_timeout() -> void:
	Sounds.stopturtlevoice()
	$AnimatedSprite2D.animation = "idle"
	stoppedTalking = true



func _on_body_exited(body: Node2D) -> void:
	$AnimationPlayer.play("fadeout")
	$AnimationPlayer2.stop()
	$AnimatedSprite2D.animation = "idle"
	Sounds.stopturtlevoice()
	$TalkingTime.stop()
	Sounds.hidedialogue()


func _on_sound_time_timeout() -> void:
	Sounds.turtlevoice()
	$SoundTime.start()


#func _on_animation_time_timeout() -> void:
	#if $AnimatedSprite2D.frame == 0:
		#$AnimatedSprite2D.frame = $AnimatedSprite2D.frame + 1
	#else:
		#$AnimatedSprite2D.frame = $AnimatedSprite2D.frame - 1
	#$AnimationTime.start()
