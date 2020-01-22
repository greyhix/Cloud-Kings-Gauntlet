extends Sprite

onready var Player = get_node("/root/Player")

func _ready():
	self.position.x = Player.position.x
	self.position.y = Player.position.y
	print (self.position)

func _process(delta):
	self.position.x = Player.position.x
	self.position.y = Player.position.y
