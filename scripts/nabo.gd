extends Area2D
var stoppedTalking = false
var talking = false
var textnumber = 1
var mousePointing = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "eyesmall"
	$RichTextLabel.visible_ratio = 0
	$TextureRect.modulate = "ffffff00"
	$RichTextLabel.modulate = "ffffff00"
	$RichTextLabel2.visible_ratio = 0
	$RichTextLabel3.visible_ratio = 0
	$RichTextLabel4.visible_ratio = 0
	$RichTextLabel5.visible_ratio = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if textnumber > 4 and !mousePointing:
		#$AnimatedSprite2D.animation = "eyesmall"
	if $TalkingTime.is_stopped():
		Sounds.stopnabovoice()
		if textnumber == 2:
			$Sprite2D.visible = true
			$AnimatedSprite2D.animation = "eyesmall"
			if Input.is_action_just_pressed("NEXT"):
				$Sprite2D.frame = 1
				Sounds.newdialogue()
				$AnimatedSprite2D.animation = "talksmall"
				$AnimationPlayer2.play("text2")
				$TalkingTime.start()
		if textnumber == 3:
			$Sprite2D.frame = 0
			$AnimatedSprite2D.animation = "eyesmall"
			if Input.is_action_just_pressed("NEXT"):
				$Sprite2D.frame = 1
				Sounds.newdialogue()
				$AnimatedSprite2D.animation = "talksmall"
				$AnimationPlayer2.play("text3")
				$TalkingTime.start()
		if textnumber == 4:
			$Sprite2D.frame = 0
			$AnimatedSprite2D.animation = "eyesmall"
			if mousePointing:
				$Sprite2D.frame = 1
				Sounds.newdialogue()
				$AnimatedSprite2D.animation = "talkbig"
				$AnimationPlayer2.play("text4")
				$TalkingTime.start()
		if textnumber == 5:
			$Sprite2D.visible = false
			$AnimatedSprite2D.animation = "eyebig"
			if Input.is_action_just_pressed("NEXT"):
				Sounds.newdialogue()
				$AnimatedSprite2D.animation = "talkbig"
				$AnimationPlayer2.play("text5")
				$TalkingTime.start()
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
	Sounds.newdialogue()
	stoppedTalking = false
	$TextureRect.visible = true
	$RichTextLabel.visible = true
	$AnimationPlayer.play("fadein")
	if textnumber > 4:
		$AnimatedSprite2D.animation = "talkbig"
		$AnimationPlayer2.play("text5")
		$TalkingTime.start()
	else:
		$AnimatedSprite2D.animation = "talksmall"
		$AnimationPlayer2.play("text")
		$TalkingTime.start()
	if !stoppedTalking:
		$SoundTime.start()
		$AnimationTime.start()
	else:
		$SoundTime.stop()
		$AnimationTime.stop()
	

func _on_talking_time_timeout() -> void:
	if textnumber < 5:
		textnumber = textnumber + 1
	
	#if textnumber == 2:
		#if Input.is_action_just_pressed("NEXT"):
			#$AnimatedSprite2D.animation = "talksmall"
			#$AnimationPlayer2.play("text2")
			#$TalkingTime.start()
	#if textnumber == 3:
		#$AnimatedSprite2D.animation = "talksmall"
		#$AnimationPlayer2.play("text3")
		#$TalkingTime.start()
	#if textnumber == 4:
		#$AnimatedSprite2D.animation = "talkbig"
		#$AnimationPlayer2.play("text4")
		#$TalkingTime.start()
	#if textnumber == 5:
		#$AnimatedSprite2D.animation = "talkbig"
		#$AnimationPlayer2.play("text5")
		#$TalkingTime.start()
	#if textnumber == 1:
		#$AnimatedSprite2D.animation = "talksmall"
		#$AnimationPlayer2.play("text")
		#$TalkingTime.start()
	Sounds.stopnabovoice()
	#$AnimatedSprite2D.animation = "idle"
	stoppedTalking = true



func _on_body_exited(body: Node2D) -> void:
	$AnimationPlayer.play("fadeout")
	$AnimationPlayer2.stop()
	if textnumber > 3:
		$AnimatedSprite2D.animation = "eyebig"
	if textnumber == 5:
		$AnimatedSprite2D.animation = "eyebig"
	$TalkingTime.stop()
	Sounds.hidedialogue()
	


func _on_sound_time_timeout() -> void:
	Sounds.nabovoice()
	$SoundTime.start()


#func _on_animation_time_timeout() -> void:
	#if $AnimatedSprite2D.frame == 0:
		#$AnimatedSprite2D.frame = $AnimatedSprite2D.frame + 1
	#else:
		#$AnimatedSprite2D.frame = $AnimatedSprite2D.frame - 1
	#$AnimationTime.start()


func _on_mouse_entered():
	if textnumber == 4:
		mousePointing = true


func _on_mouse_exited():
	mousePointing = false
