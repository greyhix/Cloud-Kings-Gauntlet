extends AnimatedSprite

onready var gui = get_node("/root/GUI")
onready var audio = get_node("/root/AudioMaster")
onready var coin_idle = $Coin_Idle

var coin_collected 

func _ready():
# 	coin collected prevents the player from taking a coin twice 
	coin_collected = false
	coin_idle.play("Coin_Idle")
	
func _on_Area_body_entered(body):
	gui.coin_up()  
	audio.play_coin_audio()
	coin_idle.stop()
	queue_free()

