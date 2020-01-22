extends Node2D

onready var double_coins = get_node("DoubleCoins")
onready var disabled_defenses = get_node("DisabledDefenses")
onready var bottled_tempest = get_node("BottledTempest")
onready var animator = get_node("AnimationPlayer")
onready var GUI = get_node("/root/GUI")
onready var Player = get_node("/root/Player")
onready var PlayerConfig = get_node("/root/PlayerConfig")
onready var Audio = get_node("/root/AudioMaster")


var distance_traveled
var last_spawn
var spawn_chance
var disabled_defenses_bool 
var double_coins_bool
var bottled_tempest_bool
var spawn_distance

func _ready():
	randomize()
	spawn_chance = 0
	last_spawn = 0
	spawn_distance = rand_range(1000, 2000)

func _process(delta):
	distance_traveled = GUI.distance_traveled
	if distance_traveled > last_spawn + spawn_distance:
		last_spawn = distance_traveled
		spawn_decider()

func spawn_decider():
	spawn_distance = rand_range(1000, 2000)
	spawn_chance += 10
	var spawn_decider = rand_range(0, spawn_chance)
	if spawn_decider > 7:
		powerup_decider()

func powerup_decider():
	var powerup_decider = rand_range(0, 3)
	if powerup_decider < 1:
		if is_instance_valid(disabled_defenses) == true and PlayerConfig.disabled_defenses == false:
			spawn_powerup(disabled_defenses)
	elif powerup_decider >= 1 and powerup_decider < 2 and PlayerConfig.bottled_tempest == false:
		if is_instance_valid(bottled_tempest) == true:
			spawn_powerup(bottled_tempest)
	elif powerup_decider >= 2 and powerup_decider < 3 and PlayerConfig.double_coins == false:
		if is_instance_valid(double_coins) == true:
			spawn_powerup(double_coins)

func spawn_powerup(powerup):
	var x_position = Player.position.x + 250
	var y_position = rand_range(20, 130)
	if powerup.get_class() == "Sprite":
		powerup.global_position.x = x_position
		powerup.global_position.y = y_position

func on_player_entered_disabled_defense(body):
	animator.play("DisabledDefensesPickup")
	Audio.play_powerup_pickup_audio()
	disabled_defenses_bool = true
	if animator.is_playing() == false:
		disabled_defenses.queue_free()
	spawn_chance -= 10
	
func on_player_entered_double_coins(body):
	animator.play("DoubleCoinsPickup")
	Audio.play_powerup_pickup_audio()
	double_coins_bool = true
	if animator.is_playing() == false:
		double_coins.queue_free()
	spawn_chance -= 10

func on_player_entered_bottled_tempest(body):
	animator.play("BottledTempestPickup")
	Audio.play_powerup_pickup_audio()
	if PlayerConfig.guardian_tempest == false:
		bottled_tempest_bool = true
	if PlayerConfig.guardian_tempest == true:
		PlayerConfig.bottled_tempest = true
	if animator.is_playing() == false:
		bottled_tempest.queue_free()
	spawn_chance -= 10

func powerup_save():
	if double_coins_bool != null:
		PlayerConfig.double_coins = double_coins_bool
	if bottled_tempest_bool != null:
		PlayerConfig.bottled_tempest = bottled_tempest_bool
	if disabled_defenses_bool != null:
		PlayerConfig.disabled_defenses = disabled_defenses_bool
	PlayerConfig.save_config_file()
