extends CharacterBody2D


@export var MAX_SPEED := 150.0
@export var MAX_AIR_SPEED := 200
@export var MAX_DASH_SPEED := 350.0
@export var MAX_AIR_DASH_SPEED := 450.0
@export var LONG_JUMP_SPEED := 500.0
@export var JUMP_VELOCITY := 4-400.0
@export var ACCELERATION := 700
@export var DASH_ACCELERATION := 1200
@export var DECELERATION := 1000
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")*1.5
var shifting = false

func _physics_process(delta):
	if Input.is_action_just_pressed("SPACE"):
		velocity = Vector2.ZERO
		global_position = Vector2.ZERO
	shifting = Input.is_action_pressed("SHIFT")
	var direction := Input.get_axis("LEFT", "RIGHT")
	if is_on_floor():
		$AnimatedSprite2D.animation = "idle" if direction == 0 else "walk"
	else:
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("UP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	handleMoving(direction, delta) if direction else handleStatic(delta)
	move_and_slide()

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
	print (str(!$Steps.playing) + str($Steps.stream_paused) + str(is_on_floor()))
	if (!$Steps.playing or $Steps.stream_paused) and is_on_floor(): 
		if ($Steps.stream_paused): $Steps.stream_paused = false
		if (!$Steps.playing): $Steps.play() 
	if $Steps.playing && !is_on_floor(): $Steps.stream_paused = true
	$AnimatedSprite2D.flip_h = direction == -1 
	if shifting:
		velocity.x = max(abs(velocity.x), max_speed(false)) * direction
		velocity.x = move_toward(velocity.x, direction * max_speed(true), accel(direction) * delta)
		$AnimatedSprite2D.rotation = direction * 0.1308996939
		$AnimatedSprite2D.speed_scale = 1.5
	else:
		velocity.x = max(abs(velocity.x), max_speed(false)) * direction
		$AnimatedSprite2D.rotation = 0
		$AnimatedSprite2D.speed_scale = 1

func handleStatic(delta):
	if $Steps.playing && !$Steps.stream_paused: $Steps.stream_paused = true 
	velocity.x = move_toward(velocity.x, 0, DECELERATION)
	$AnimatedSprite2D.speed_scale = 1
	$AnimatedSprite2D.rotation = 0

