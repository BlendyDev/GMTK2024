extends CharacterBody2D
class_name Player
@export var MAX_SPEED := 150.0
@export var MAX_AIR_SPEED := 200
@export var MAX_DASH_SPEED := 300.0
@export var MAX_AIR_DASH_SPEED := 400.0
@export var LONG_JUMP_SPEED := 500.0
@export var JUMP_VELOCITY := 4-400.0
@export var ACCELERATION := 700
@export var DASH_ACCELERATION := 1200
@export var DECELERATION := 1000
@export var lupa: Lupa
@export var camera: Cam
@onready var coyoteTimer = $CoyoteTime
@onready var jumpBufferTimer = $JumpBuffer
@onready var jumpHeightTimer = $JumpHeight

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")*1.5
var shifting := false
var coyote := false
var jumpBuffered := false
var jumping := false
var allowCutJump := true
var queuedCutJump := false

var allowMove := true
var danceFinished := false
var enteringDoor := false
@onready var ogPos: Vector2 = self.global_position

func _process(delta):
	pass

func _physics_process(delta):
	if (Input.is_action_just_pressed("L")): puzzleWin()
	if Input.is_action_just_pressed("RESET"): resetLevel()
	shifting = Input.is_action_pressed("SHIFT")
	var direction := Input.get_axis("LEFT", "RIGHT")
	handleJump(delta, direction)
	handleMoving(direction, delta) if direction else handleStatic(delta)
	var was_on_floor = is_on_floor()
	if allowMove: move_and_slide()
	if was_on_floor && !is_on_floor() && velocity.y >= 0:
		coyote = true
		coyoteTimer.start()
	if !was_on_floor && is_on_floor():
		Sounds.land()
		$AnimationPlayer.play("land")
		$Dust/AnimationPlayer.play("dust")
	if is_on_floor():
		$AnimatedSprite2D.animation = "idle" if direction == 0 else "walk"
	else:
		velocity.y += gravity * delta
		
func resetLevel():
	$AnimatedSprite2D.visible = true
	$WinAnimation/Sprite2D.visible = false
	self.global_position = ogPos
	velocity = Vector2.ZERO
	lupa.mode = Lupa.ModeType.NONE
	lupa.scalePlayer = 1.0
	lupa.scaleLevel = 1.0
	camera.reset()

func handleJump(delta, direction):
	if Input.is_action_just_pressed("UP") and (is_on_floor() || coyote): jump()
	if Input.is_action_pressed("UP") and jumpBuffered and is_on_floor(): jump()	
	if Input.is_action_just_pressed("UP") and not (is_on_floor() || coyote):
		jumpBuffered = true	
		jumpBufferTimer.start()
	if Input.is_action_just_released("UP"): jumpBuffered = false
	if jumping:
		if velocity.y >= 0: jumping = false
		elif Input.is_action_just_released("UP") || queuedCutJump:
			if allowCutJump:
				queuedCutJump = false
				jumping = false
				velocity.y = 0
			else:
				queuedCutJump = true
				pass

func jump():
	jumping = true
	allowCutJump = false
	jumpHeightTimer.start()
	coyote = false
	jumpBuffered = false
	Sounds.jumpvoice()
	Sounds.jumpsound()
	$AnimationPlayer.play("jump")
	velocity.y = JUMP_VELOCITY * self.global_scale.x
func max_speed(dash):
	if (dash):
		if (is_on_floor()): return MAX_DASH_SPEED
		else: return MAX_AIR_DASH_SPEED
	else:
		if (is_on_floor()): return MAX_SPEED
		else: return MAX_AIR_SPEED
func accel(direction):
	if (velocity.x * direction < 0): return DECELERATION
	return DASH_ACCELERATION if shifting else ACCELERATION
	
func handleMoving(direction, delta):
	if (!$Steps.playing or $Steps.stream_paused) and is_on_floor(): 
		if ($Steps.stream_paused): $Steps.stream_paused = false
		if (!$Steps.playing): $Steps.play() 
	if $Steps.playing && !is_on_floor(): $Steps.stream_paused = true
	$AnimatedSprite2D.flip_h = direction == -1 
	var sizeVelMultiplier = self.global_scale.x
	if shifting:
		$Steps.pitch_scale = 1.3
		velocity.x = max_speed(true) * sizeVelMultiplier * direction
		velocity.x = move_toward(velocity.x, direction * max_speed(true) * sizeVelMultiplier, accel(direction) * delta)
		$AnimatedSprite2D.rotation = direction * 0.1308996939
		$AnimatedSprite2D.speed_scale = 1.5
	else:
		$Steps.pitch_scale = 1.0
		velocity.x = max_speed(false) * sizeVelMultiplier * direction
		$AnimatedSprite2D.rotation = 0
		$AnimatedSprite2D.speed_scale = 1

func handleStatic(delta):
	if $Steps.playing && !$Steps.stream_paused: $Steps.stream_paused = true 
	velocity.x = move_toward(velocity.x, 0, DECELERATION)
	$AnimatedSprite2D.speed_scale = 1
	$AnimatedSprite2D.rotation = 0

func coyoteTimeout():
	coyote = false

func jumpBufferTimeout():
	jumpBuffered = false 

func jumpHeightTimeout():
	allowCutJump = true 

func _on_win_timer_timeout():
	Global.hasWon = true
	$WinAnimation.visible = false
	$AnimatedSprite2D.visible = true
	$Sprite2D.visible = false
	allowMove = true

func puzzleWin():
	print("puzzleWin")
	allowMove = false
	$WinAnimation/Sprite2D.visible = true
	$WinAnimation/AnimationPlayer.play("dance")
	$AnimatedSprite2D.visible = false
	$Sprite2D.visible = false
func onDanceFinished():
	print("danceFinished")
	danceFinished = true
	allowMove = true
	$AnimatedSprite2D.visible = true
func enterDoor():
	print("enterDoor")
	danceFinished = false
	enteringDoor = false
	allowMove = false
	$AnimatedSprite2D.visible = false
	$Sprite2D.visible = true
	
	Sounds.entersound()
	var tween2 = get_tree().create_tween()
	tween2.tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0), 1)
