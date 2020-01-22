extends Sprite

const OFFSET = 280

var lightning_bolt_counter
var lightning_bolt_y_position
var y_position_decider
var lightning_bolt_multiplier
var lightning_bolt_space_multiplier
var lightning_bolt_shorten_multiplier
var lightning_bolt_array = Array()
var attack_performed
onready var player = get_node("/root/Player")


func _ready():
	randomize()
	lightning_bolt_shorten_multiplier = false
	lightning_bolt_multiplier = 1
	y_position_decider = rand_range(0, 1)
	if y_position_decider < 0.5:
		lightning_bolt_y_position = 10
	elif y_position_decider > 0.5:
		lightning_bolt_y_position = 20
	$CloudKingAnimator.play("cloud_king_animation")
	attack_performed = false
	get_lightning_bolt_value()
	self.position.x = player.position.x + OFFSET
	self.position.y = 60

#warning-ignore:unused_argument
func _process(delta):
	self.position.x = player.position.x + OFFSET
	if $CloudKingAnimator.is_playing() == false:
		if attack_performed == false:
			lightning_bolt_spawner()
		attack_performed = true
		
			
func get_lightning_bolt_value():
	lightning_bolt_counter = rand_range(3, 6)
	lightning_bolt_counter = int(lightning_bolt_counter)
	if lightning_bolt_y_position == 20:
		lightning_bolt_shorten_multiplier = true
		
	if lightning_bolt_shorten_multiplier == true and lightning_bolt_counter == 3:
		lightning_bolt_multiplier = 0.6
	elif lightning_bolt_shorten_multiplier == true and lightning_bolt_counter == 4:
		lightning_bolt_multiplier = 0.8
	elif lightning_bolt_shorten_multiplier == true and lightning_bolt_counter == 5:
		lightning_bolt_y_position = 10

	if lightning_bolt_counter == 3:
		lightning_bolt_space_multiplier = 2 * lightning_bolt_multiplier
	elif lightning_bolt_counter == 4:
		lightning_bolt_space_multiplier = 1.3 * lightning_bolt_multiplier
	elif lightning_bolt_counter == 5:
		lightning_bolt_space_multiplier = 1 * lightning_bolt_multiplier
	
func _on_queue_free_timer_timeout():
	queue_free()
	
func lightning_bolt_spawner():
	# make sure the lightning bolts cover the entire screen
	for lightning_bolt in lightning_bolt_counter:
		lightning_bolt = preload("res://Scenes/Enemies/LightningBolt.tscn").instance()
		add_child(lightning_bolt)
		lightning_bolt_array.append(lightning_bolt)
	for lightning_bolt in lightning_bolt_array:
		if lightning_bolt == lightning_bolt_array[0]:
			lightning_bolt.global_position.y = lightning_bolt_y_position
		elif lightning_bolt != lightning_bolt_array[0]:
			lightning_bolt_y_position += 30 * lightning_bolt_space_multiplier
			lightning_bolt.global_position.y = lightning_bolt_y_position
	 $queue_free_timer.start()
