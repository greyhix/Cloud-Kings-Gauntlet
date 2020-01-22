extends Node2D

var cirrus
var fog
var nimbus
var nimbus_animation_speed
var lightning_bolt_acceleration
var cloud_king

var enemy_decider
var spawn_weight
var initial_spawn_weight

var timer_min
var timer_max

onready var Player = get_node("/root/Player")

func _ready():
	randomize()
	lightning_bolt_acceleration = 0
	nimbus_animation_speed = 2
	$Timer.wait_time = 3
	spawn_weight = 4
	timer_min = 2.5
	timer_max = 4
	
func _on_Timer_timeout():
	if Player.game_in_session == true:
		$Timer.wait_time = rand_range(timer_min, timer_max)
		timer_min -= 0.05
		enemy_spawner()
	elif Player.game_in_session == false:
		spawn_weight = 4

func enemy_spawner():
	initial_spawn_weight = spawn_weight
	spawn_random_enemy()
	spawn_weight = initial_spawn_weight + 1.5
		
func spawn_random_enemy():
	enemy_decider = rand_range(0, spawn_weight)
	if enemy_decider < 4:   
		spawn_straight_nimbus(1)
	elif enemy_decider > 4 and enemy_decider < 8:
		spawn_straight_nimbus(1)
		spawn_fog_or_cirrus()
	elif enemy_decider > 8 and enemy_decider < 12:
		spawn_straight_nimbus(2)
	elif enemy_decider > 12 and enemy_decider < 16:
		spawn_rotated_nimbus()
		spawn_fog_or_cirrus()
	elif enemy_decider > 16 and enemy_decider < 20:
		spawn_straight_nimbus(3)
		spawn_fog_or_cirrus()
	elif enemy_decider > 20 and enemy_decider < 24:
		spawn_straight_nimbus(1)
		spawn_rotated_nimbus() 
	elif enemy_decider > 24 and enemy_decider < 28:
		spawn_straight_nimbus(2)
		spawn_rotated_nimbus() 
	elif enemy_decider > 28 and enemy_decider < 32:
		spawn_rotated_nimbus()
		spawn_rotated_nimbus()
		spawn_straight_nimbus(1)
	elif enemy_decider > 32 and enemy_decider < 36:
		spawn_rotated_nimbus()
		spawn_straight_nimbus(2)
		spawn_fog_or_cirrus()
	elif enemy_decider > 36:
		spawn_cloud_king()

func spawn_cloud_king():
	cloud_king = load("res://Scenes/Enemies/CloudKing.tscn").instance()
	add_child(cloud_king)
	$Timer.stop()
	$Timer.wait_time = 3
	$Timer.start()

func spawn_fog_or_cirrus():
	enemy_decider = rand_range(0, 1)
	if enemy_decider <= 0.5:
		spawn_cirrus()
	elif enemy_decider > 0.5:
		spawn_fog()
	
func spawn_rotated_nimbus():
	enemy_decider = rand_range(0, 1)
	if enemy_decider <= 0.5:
		spawn_top_nimbus()
	elif enemy_decider > 0.5:
		spawn_bottom_nimbus()

func spawn_straight_nimbus(amount):
	var nimbus_array = Array()
	for each in range(0, amount):
		nimbus = load("res://Scenes/Enemies/Straight_Nimbus.tscn").instance() 
		nimbus.nimbus_amount = amount
		nimbus.get_child(0).playback_speed = nimbus_animation_speed
		nimbus.lightning_bolt_acceleration = lightning_bolt_acceleration
		add_child(nimbus)
		nimbus_array.append(nimbus)
	if amount == 2:
		nimbus_array[1].nimbus_y_position = nimbus_array[0].nimbus_y_position 
		if nimbus_array[0].nimbus_y_position < 60:
			nimbus_array[1].nimbus_y_position += rand_range(30, 60)
		elif nimbus_array[0].nimbus_y_position >= 60:
			nimbus_array[1].nimbus_y_position -= rand_range(30, 60)
	elif amount == 3:
		nimbus_array[1].nimbus_y_position = nimbus_array[0].nimbus_y_position 
		if nimbus_array[0].nimbus_y_position < 60:	
			nimbus_array[1].nimbus_y_position += rand_range(20, 40)
			nimbus_array[2].nimbus_y_position = nimbus_array[1].nimbus_y_position 
			nimbus_array[2].nimbus_y_position += rand_range(20, 40)
		elif nimbus_array[0].nimbus_y_position >= 60:
			nimbus_array[1].nimbus_y_position -= rand_range(20, 40)
			nimbus_array[2].nimbus_y_position = nimbus_array[1].nimbus_y_position 
			nimbus_array[2].nimbus_y_position -= rand_range(20, 40) 
	increment_animation_speed_and_lightning_bolt_acceleration()
	
func spawn_bottom_nimbus():
	nimbus = load("res://Scenes/Enemies/Rotated_Nimbus.tscn").instance() 
	nimbus.nimbus_type = "bottom"
	nimbus.get_child(0).playback_speed = nimbus_animation_speed
	nimbus.lightning_bolt_acceleration = lightning_bolt_acceleration
	add_child(nimbus)
	increment_animation_speed_and_lightning_bolt_acceleration()
	
	
func spawn_top_nimbus():
	nimbus = load("res://Scenes/Enemies/Rotated_Nimbus.tscn").instance() 
	nimbus.nimbus_type = "top"
	nimbus.get_child(0).playback_speed = nimbus_animation_speed
	nimbus.lightning_bolt_acceleration = lightning_bolt_acceleration
	add_child(nimbus)
	increment_animation_speed_and_lightning_bolt_acceleration()
	
func spawn_cirrus():
	cirrus = load("res://Scenes/Enemies/Cirrus.tscn").instance()
	add_child(cirrus)	
	
func spawn_fog():
	fog = load("res://Scenes/Enemies/Fog.tscn").instance()
	add_child(fog)

func increment_animation_speed_and_lightning_bolt_acceleration():
	if lightning_bolt_acceleration < 250:
		lightning_bolt_acceleration += 15
	if nimbus_animation_speed < 4.5:
		nimbus_animation_speed += 0.1

