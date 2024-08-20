extends Area2D
var hasEntered = false
@export var player: Player
# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.danceFinished:
		if Input.is_action_just_pressed("NEXT") && player.enteringDoor:
			player.enterDoor()
			$EnterAnimationTime.start()

func _on_body_entered(body):
	if player.danceFinished: player.enteringDoor = true


func _on_win_zone_body_entered(body):
	if !player.danceFinished: player.puzzleWin()
	
func _on_blink_sound_timeout():
	Sounds.blink()

func _on_next_screen_timeout():
	hasEntered = true
	$AnimationPlayer.play("enter")
	$BlinkSound.start()

func animationFinished(anim_name):
	hasEntered = false
	Global.changeScreen = true
