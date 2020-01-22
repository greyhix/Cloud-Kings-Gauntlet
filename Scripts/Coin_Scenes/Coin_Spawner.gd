extends Node2D

var coin_arc
var coin_line
var coin_shape
var coin_dip

var coins_spawned
var coins_last_spawn_position

var coin_spawn_weight

onready var spawn_point = $spawn_point
onready var player = get_node("/root/Player")

func _ready():
	coins_spawned = false
	coins_last_spawn_position = 0
	coin_spawn_weight = 1
	randomize()

func _process(delta):
	spawn_point_movement(delta)
	spawn_random_coin_shape()

func spawn_random_coin_shape():
	if spawn_point.position.x > 400 and coins_spawned == false:
		var coin_value_decider = rand_range(0, coin_spawn_weight)
		if coin_value_decider < 12:
			var coin_decider = rand_range(0, 0.75)
			if coin_decider < 0.25:
				spawn_coin_line()
			elif coin_decider >= 0.25 and coin_decider < 0.5:
				spawn_coin_arc()
			elif coin_decider >= 0.5 and coin_decider < 0.75:
				spawn_coin_dip()
		elif coin_value_decider > 12:
			spawn_coin_shape()
		coins_spawned = true
		coin_spawn_weight += 1
	if player.position.x > coins_last_spawn_position:
		coins_spawned = false

func spawn_coin_line():
	coin_line = preload("res://Scenes/Coin_Scenes/Coin_Line.tscn").instance()
	add_child(coin_line) 
	spawn_point.position.y = rand_range(20, 120)
	coin_line.position.x = spawn_point.position.x 
	coin_line.position.y = spawn_point.position.y
	coins_last_spawn_position = coin_line.position.x

func spawn_coin_arc():
	coin_arc = preload("res://Scenes/Coin_Scenes/Coin_Arc.tscn").instance()
	add_child(coin_arc) 
	spawn_point.position.y = rand_range(40, 130)
	coin_arc.position.x = spawn_point.position.x
	coin_arc.position.y = spawn_point.position.y
	coins_last_spawn_position = coin_arc.position.x

func spawn_coin_dip():
	coin_dip = preload("res://Scenes/Coin_Scenes/Coin_Dip.tscn").instance()
	add_child(coin_dip) 
	spawn_point.position.y = rand_range(10, 100)
	coin_dip.position.x = spawn_point.position.x
	coin_dip.position.y = spawn_point.position.y
	coins_last_spawn_position = coin_dip.position.x

func spawn_coin_shape():
	coin_shape = preload("res://Scenes/Coin_Scenes/Coin_CoinShape.tscn").instance()
	add_child(coin_shape) 
	spawn_point.position.y = rand_range(70, 125)
	coin_shape.position.x = spawn_point.position.x
	coin_shape.position.y = spawn_point.position.y
	coins_last_spawn_position = coin_shape.position.x

func spawn_point_movement(delta):
	spawn_point.position.x += Player.velocity.x * delta




