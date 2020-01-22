extends Node2D

onready var Player = get_node("/root/Player")
onready var GUI = get_node("/root/GUI")
#warning-ignore:unused_class_variable
onready var PlayerConfig = get_node("/root/PlayerConfig")
onready var Audio = get_node("/root/AudioMaster")

# gets the camera from the player
onready var Player_Camera = get_node("/root/Player/Camera2D")

# gets various scenes
var start_screen_scene 
var gameover_scene 
var coin_spawner_scene
var enemy_spawner_scene
var powerup_spawner_scene
var game_just_ended
var main_menu_scene
var settings_scene
var shop_scene
var help_menu_scene

func _ready():
	scene_preloads()
	game_prestart()


func _process(delta):
	game_start()
	out_of_bounds()

func game_prestart():
	game_just_ended = false
	Player_Camera.current = true
	Player.position.x = 0
	Player.position.y = 50
	Player_Camera.position.x = Player.position.x 
	spawn_start_screen()
	gui_toggle(true)

func game_start():
	if Input.is_action_pressed("space") and Player.game_in_session == false and game_just_ended == false:
		Player.game_in_session = true
		spawn_coin_spawner()
		spawn_enemy_spawner()
		spawn_powerup_spawner()
		disabled_defenses()
		if PlayerConfig.guardian_tempest == true:
			PlayerConfig.bottled_tempest = true
			PlayerConfig.save_config_file()
			
func game_over():
	if PlayerConfig.bottled_tempest == true:
		bottled_tempest()
	elif PlayerConfig.bottled_tempest == false:
		Audio.play_playerhurt_audio()
		Audio.bg_audio.stop()
		spawn_gameover_screen()
		save_coins_and_distance_traveled()
		game_just_ended = true
		Player.game_in_session = false
		powerup_spawner_scene.powerup_save()
		enemy_spawner_scene.queue_free()
		coin_spawner_scene.queue_free()
		powerup_spawner_scene.queue_free()
		gui_toggle(false)
	
func game_restart():
	Player.game_in_session = true
	Player_Camera.offset.x = 100
	GameMaster.game_prestart()
	Player._ready()
	GUI._ready()
	
func save_coins_and_distance_traveled():
	if PlayerConfig.double_coins == true:
		PlayerConfig.double_coins = false
	var coins = GUI.coin_counter
	var distance_traveled = GUI.distance_traveled
	if distance_traveled > PlayerConfig.best_distance_traveled:
		PlayerConfig.best_distance_traveled = distance_traveled
	PlayerConfig.coins += coins
	PlayerConfig.save_config_file()

func out_of_bounds():
	if Player.position.y > 140:
		if PlayerConfig.bottled_tempest == true:
			Player.position.y = 50
			bottled_tempest()
		elif PlayerConfig.solid_clouds == true:
			Player.position.y = 140
		elif PlayerConfig.solid_clouds == false:
			game_over()
	if Player.position.y < 10:
		Player.position.y = 10
		Player.velocity.y = 0
	
func gui_toggle(toggle):
	for child in GUI.get_children():
		child.visible = toggle

func disabled_defenses():
	if PlayerConfig.disabled_defenses == true:
		enemy_spawner_scene.timer_min = 3
		enemy_spawner_scene.timer_max = 6
		PlayerConfig.save_config_file()
		PlayerConfig.disabled_defenses = false
	
func bottled_tempest():
	Audio.play_bottled_tempest_audio()
	if Player.hit_by_cirrus == true:
		Player.hit_by_cirrus = false
	var timer = enemy_spawner_scene.get_children()
	for child in enemy_spawner_scene.get_children():
		if child != timer[0]:
			child.queue_free()
	PlayerConfig.bottled_tempest = false
	PlayerConfig.save_config_file()

func spawn_start_screen():
	start_screen_scene = preload("res://Scenes/GUI/StartScreen.tscn").instance()
	add_child(start_screen_scene)

func spawn_gameover_screen():
	gameover_scene = preload("res://Scenes/GUI/GameOver.tscn").instance()
	add_child(gameover_scene)
	
func spawn_main_menu_screen():
	main_menu_scene = preload("res://Scenes/GUI/MainMenu.tscn").instance()
	add_child(main_menu_scene)

func spawn_shop():
	shop_scene = preload("res://Scenes/GUI/Shop.tscn").instance()
	add_child(shop_scene)

func spawn_settings():
	settings_scene = preload("res://Scenes/GUI/SettingsScreen.tscn").instance()
	add_child(settings_scene)

func spawn_help_menu():
	help_menu_scene = preload("res://Scenes/GUI/HelpMenu.tscn").instance()
	add_child(help_menu_scene)

func spawn_coin_spawner():
	coin_spawner_scene = preload("res://Scenes/Coin_Scenes/Coin_Spawner.tscn").instance()
	add_child(coin_spawner_scene)
	
func spawn_enemy_spawner():
	enemy_spawner_scene = preload("res://Scenes/Enemies/EnemySpawner.tscn").instance()
	add_child(enemy_spawner_scene)

func spawn_powerup_spawner():
	powerup_spawner_scene = preload("res://Scenes/PowerupSpawner.tscn").instance()
	add_child(powerup_spawner_scene)

func scene_preloads():
	spawn_shop()
	shop_scene.queue_free()
	spawn_main_menu_screen()
	main_menu_scene.queue_free()
	spawn_gameover_screen()
	gameover_scene.queue_free()
	spawn_settings()
	settings_scene.queue_free()
	spawn_coin_spawner()
	coin_spawner_scene.queue_free()
	spawn_enemy_spawner()
	enemy_spawner_scene.queue_free()
	spawn_powerup_spawner()
	powerup_spawner_scene.queue_free()

