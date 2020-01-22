extends AnimatedSprite

const OFFSET = 400
const VELOCITY = 50

onready var Player = get_node("/root/Player")
onready var Audio = get_node("/root/AudioMaster")
onready var CirrusEffectAnimations = get_node("/root/Player/CirrusEffectAnimations")
onready var cirrus_effect_timer = get_node("cirrus_effect_timer")

var velocity


func _ready():
	randomize() 
	self.position.y = rand_range(20, 120)
	self.position.x = (Player.position.x + OFFSET)
	velocity = VELOCITY

func _process(delta):
	self.position.x -= velocity * delta
	if Player.hit_by_cirrus == true:
		Player.velocity.y += 2.5 * delta
	if self.position.x < Player.position.x - 250:
		Player.hit_by_cirrus = false
		queue_free()
		
func _on_Area2D_body_entered(body):
	Audio.play_cirrus_audio()
	Player.hit_by_cirrus = true 
	Player.velocity.y = 50
	cirrus_effect_timer.start()
	CirrusEffectAnimations.play("cirrus_modulate_effect")

func _on_cirrus_effect_timeout():
	Player.hit_by_cirrus = false
	
