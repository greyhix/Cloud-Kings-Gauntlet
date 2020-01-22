extends AnimatedSprite

const VELOCITY = 70
const ACCELERATION = 0.4
const JUMP = -2500 
const GRAVITY = 125 
const TERMINAL_VELOCITY = 45 
const MAX_UPWARDS_VELOCITY = -70

var distance_traveled
var velocity = Vector2()
var hit_by_cirrus
var game_in_session

onready var Audio = get_node("/root/AudioMaster")

func _ready():
	game_in_session = false 
	velocity.x = VELOCITY
	velocity.y = GRAVITY
	hit_by_cirrus = false
	distance_traveled = 0
	$PlayerAnimations.play("idle")
	
func _process(delta):
# maintains the speed for the players vertical and horizontal movement
	if game_in_session == true:
		position.y += velocity.y * delta * 1.5
		position.x += velocity.x * delta
		distance_traveled += velocity.x * delta * 0.5
		controls(delta)
		gravity(delta)
		if position.x > 35:
			$Camera2D.current = true
	elif game_in_session == false:
		position.x = 0
		position.y = 50
	
func gravity(delta):
	if velocity.y < TERMINAL_VELOCITY:
		velocity.y += GRAVITY * delta

func controls(delta):
	if Input.is_action_pressed("space") and hit_by_cirrus == false:
		Audio.play_playerjump_audio()
		$PlayerAnimations.queue("jump")  
		if velocity.y > MAX_UPWARDS_VELOCITY and hit_by_cirrus == false:
			velocity.y += JUMP * delta
			if velocity.y <= -50 and hit_by_cirrus == false:
				velocity.y = -50
	elif Input.is_action_just_released("space") and hit_by_cirrus == false:
		if $PlayerAnimations.is_playing() == true:
			$PlayerAnimations.clear_queue()
		elif $PlayerAnimations.is_playing() == false:
			$PlayerAnimations.play("jump")
		
func _on_Timer_timeout():
	if velocity.x < 200 and game_in_session == true:
		velocity.x += ACCELERATION

