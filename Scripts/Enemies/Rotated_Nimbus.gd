extends Sprite

onready var Player = get_node("/root/Player")
var lightning_bolt
var lightning_bolt_spawned
var lightning_bolt_acceleration

var nimbus_type
var nimbus_rotation
var nimbus_x_position 

func _ready():
	randomize()
	nimbus_setter()
	lightning_bolt_spawned = false 
	$Nimbus_Animation.play("nimbus_animation")


func _process(delta):
	lightning_bolt_spawner()
	keep_nimbus_position()

func lightning_bolt_spawner():
# 	if a lightning bolt hasn't spawned and the nimbus has finished it's warning animation, then spawn a lightning bolt
	if $Nimbus_Animation.is_playing() == false:
		if lightning_bolt_spawned == false:
			lightning_bolt_spawn()

func lightning_bolt_spawn():
	lightning_bolt = preload("res://Scenes/Enemies/LightningBolt.tscn").instance() 
	add_child(lightning_bolt)
	lightning_bolt.velocity -= 50
	lightning_bolt.velocity += lightning_bolt_acceleration
	lightning_bolt_spawned = true

func nimbus_setter():
#	this function is called by the enemy spawner and determines if the rotated nimbus will be on top or the bottom
	if nimbus_type == "top":
		top_nimbus()
	elif nimbus_type == "bottom":
		bottom_nimbus()

func bottom_nimbus():
#	sets the x, y, and rotation value for the bottom nimbus 
	self.position.y = 150
	nimbus_x_position = rand_range(100, 200)
	if nimbus_x_position < 150:
		nimbus_rotation = rand_range(30, 45)
	elif nimbus_x_position >= 150:
		nimbus_rotation = rand_range(20, 30)
	self.rotation_degrees = nimbus_rotation

func top_nimbus():
#	sets the x, y, and rotation value for the top nimbus 
	self.position.y = -5
	nimbus_x_position = rand_range(50, 180)
	if nimbus_x_position < 115:
		nimbus_rotation = rand_range(-45, -30)
	elif nimbus_x_position > 115:
		nimbus_rotation = rand_range(-30, -20)
	self.rotation_degrees = nimbus_rotation

func keep_nimbus_position():
# 	uses the position of the player to keep the nimbus on screen, the nimbus_x_position is essentially an offset. 
	self.position.x = (Player.position.x + nimbus_x_position)

func _on_queue_free_timer_timeout():
	queue_free()
