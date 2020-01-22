extends AnimatedSprite

var velocity 
onready var Audio = get_node("/root/AudioMaster")
onready var Player = get_node("/root/Player")
onready var PlayerConfig = get_node("/root/PlayerConfig")

func _ready():
	Audio.play_lightningbolt_audio()
	if PlayerConfig.weakened_nimbus == false:
		velocity = 450
	elif PlayerConfig.weakened_nimbus == true:
		velocity = 350
	
func _process(delta):
	self.position.x -= velocity * delta
	if self.global_position.x < (Player.position.x - 150):
		queue_free()

func _on_Area2D_body_entered(body):
	GameMaster.game_over()
	queue_free()
