extends Sprite

onready var Player = get_node("/root/Player")
onready var PlayerConfig = get_node("/root/PlayerConfig")
var lightning_bolt
var lightning_bolt_acceleration
var lightning_bolt_spawned
var nimbus_y_position
var nimbus_amount
const STRAIGHT_OFFSET = 210

func _ready():
	randomize()
	nimbus_y_position_decider()
	lightning_bolt_spawned = false 
	$Nimbus_Animation.play("nimbus_animation")

func _process(delta):
	lightning_bolt_spawner()
	nimbus_out_of_bounds()
	keep_nimbus_position()
	
func lightning_bolt_spawner():
# 	if a lightning bolt hasn't spawned and the nimbus has finished it's warning animation, then spawn a lightning bolt
	if $Nimbus_Animation.is_playing() == false:
		if lightning_bolt_spawned == false:
			lightning_bolt_spawn()

func lightning_bolt_spawn():
	lightning_bolt = preload("res://Scenes/Enemies/LightningBolt.tscn").instance() 
	add_child(lightning_bolt)
	lightning_bolt.velocity += lightning_bolt_acceleration
	lightning_bolt_spawned = true

func nimbus_y_position_decider():
	if nimbus_amount == 1:
		nimbus_y_position = (Player.position.y - rand_range(0, 50) + rand_range(0, 50))
	elif nimbus_amount == 2:
		nimbus_y_position = (Player.position.y - rand_range(0, 50) + rand_range(0, 50))
	elif nimbus_amount == 3:
		nimbus_y_position = (rand_range(10, 130))

func keep_nimbus_position():
# 	uses the position of the player to keep the nimbus on screen. 
	self.position.y = nimbus_y_position
	self.position.x = (Player.position.x + STRAIGHT_OFFSET)


func nimbus_out_of_bounds():
# 	keeps the nimbus in bounds
	if nimbus_y_position < 10:
		nimbus_y_position = 10
	elif nimbus_y_position > 125 and PlayerConfig.solid_clouds == false:
		nimbus_y_position = 125
	elif nimbus_y_position > 135 and PlayerConfig.solid_clouds == true:
		nimbus_y_position = 135

func _on_queue_free_timer_timeout():
	queue_free()
