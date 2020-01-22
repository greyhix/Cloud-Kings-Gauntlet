extends Node2D

onready var player = get_node("/root/Player")

func _process(delta):
#	after coins go past the player's camera the coins get queue freed 
	if self.position.x < (player.position.x - 200):
		queue_free()
	
