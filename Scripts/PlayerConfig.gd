extends Node2D

var config_file

var coins
var best_distance_traveled
var muted
var master_volume
var background_volume

var double_coins
var disabled_defenses
var bottled_tempest

var weakened_nimbus
var solid_clouds
var guardian_tempest

func _ready():
	config_file = load_config_file()

func load_config_file():
	var config = ConfigFile.new()
	var err = config.load("res://ConfigFile.cfg")
	if err == OK:
		print("Game Loaded with: ")
		print_config_file(config)
		coins = config.get_value("coins", "coins", 0)
		best_distance_traveled = config.get_value("distance_traveled", "distance_traveled", 0)
		muted = config.get_value("audio", "muted", false)
		master_volume = config.get_value("audio", "master_volume", 45)
		background_volume = config.get_value("audio", "background_volume", 80)
		
		double_coins = config.get_value("one_use_powerups", "double_coins", false)
		disabled_defenses = config.get_value("one_use_powerups", "disabled_defenses", false)
		bottled_tempest = config.get_value("one_use_powerups", "bottled_tempest", false)
		
		weakened_nimbus = config.get_value("permanent_upgrades", "weakened_nimbus", false)
		solid_clouds = config.get_value("permanent_upgrades", "solid_clouds", false)
		guardian_tempest = config.get_value("permanent_upgrades", "guardian_tempest", false)
		config.save("res://ConfigFile.cfg")
	elif err != OK:
		print ("failure to load cfg file, initializing default cfg file...")
		coins = 0
		best_distance_traveled = 0
		muted = false
		master_volume = 45
		background_volume = 80
		double_coins = false
		disabled_defenses = false
		bottled_tempest = false
		weakened_nimbus = false
		solid_clouds = false
		guardian_tempest = false
		config.set_value("coins", "coins", coins)
		config.set_value("distance_traveled", "distance_traveled", best_distance_traveled)
		config.set_value("audio", "muted", muted)
		config.set_value("audio", "master_volume", master_volume)
		config.set_value("audio", "background_volume", background_volume)
		
		config.set_value("one_use_powerups", "double_coins", double_coins)
		config.set_value("one_use_powerups", "disabled_defenses", disabled_defenses)
		config.set_value("one_use_powerups", "bottled_tempest", bottled_tempest)
		
		config.set_value("permanent_upgrades", "weakend_nimbus", weakened_nimbus)
		config.set_value("permanent_upgrades", "solid_clouds", solid_clouds)
		config.set_value("permanent_upgrades", "guardian_tempest", guardian_tempest)
		config.save("res://ConfigFile.cfg")  

func save_config_file():
	var config = ConfigFile.new()
	var err = config.load("res://ConfigFile.cfg")
	if err == OK:
		config.set_value("coins", "coins", coins)
		config.set_value("distance_traveled", "distance_traveled", best_distance_traveled)
		config.set_value("audio", "muted", muted)
		config.set_value("audio", "master_volume", master_volume)
		config.set_value("audio", "background_volume", background_volume)
		
		config.set_value("one_use_powerups", "double_coins", double_coins)
		config.set_value("one_use_powerups", "disabled_defenses", disabled_defenses)
		config.set_value("one_use_powerups", "bottled_tempest", bottled_tempest)
		
		config.set_value("permanent_upgrades", "weakened_nimbus", weakened_nimbus)
		config.set_value("permanent_upgrades", "solid_clouds", solid_clouds)
		config.set_value("permanent_upgrades", "guardian_tempest", guardian_tempest)
		print("Config File Saved with: ")
		print_config_file(config)
		config.save("res://ConfigFile.cfg")
	if err != OK:
		print ("failure to save cfg file")

func print_config_file(config):
	print("Coins: " + str(config.get_value("coins", "coins")))
	print("Best Distance Traveled: " + str(config.get_value("distance_traveled", "distance_traveled")))
	print("Muted: " + str(config.get_value("audio", "muted")))
	print ("Master Volume: " + str(config.get_value("audio", "master_volume")))
	print("Background Volume: " + str(config.get_value("audio", "background_volume")))
	print ("Double Coins: " + str(config.get_value("one_use_powerups", "double_coins")))
	print ("Disabled Defenses: " + str(config.get_value("one_use_powerups", "disabled_defenses")))
	print ("Bottled Tempest: " + str(config.get_value("one_use_powerups", "bottled_tempest")))
	print ("Weakened Nimbus: " + str(config.get_value("permanent_upgrades", "weakened_nimbus")))
	print ("Solid Clouds: " + str(config.get_value("permanent_upgrades", "solid_clouds")))
	print ("Guardian Tempest: " + str(config.get_value("permanent_upgrades", "guardian_tempest")))

#THIS IS WHAT I USED FOR MY JSON FILE BEFORE I REALIZED HOW EASY IT IS TO USE CONFIG FILES
#
#
#func _ready():
#	config_file = get_configfile()
#	if config_file == null:
#		null_check()
#	elif config_file != null:
#		set_settings()
#		load_settings()
#
#func get_configfile():
#	var file = File.new()
#	file.open("res://ConfigFile.json", File.READ)
#	var text = file.get_as_text()
#	var data = parse_json(text)
#	return data
#
#func save():
#	set_settings()
#	set_string_settings()
#	var file = File.new()
#	file.open("res://ConfigFile.json", File.WRITE)
#	file.store_line(to_json(string_settings))
#	file.close()
#	print ("Game saved with: " + "Coins: " + str(coins) + ", Muted: " + str(muted) + ", Master Volume: " + str(master_volume))
#
#func load_settings():
#	coins = (config_file[0]["coins"]).to_int()
#	set_muted(config_file[1]["muted"])
#	master_volume = (config_file[2]["master_volume"]).to_int()
#	print ("Game loaded with: " + "Coins: " + str(coins) + ", Muted: " + str(muted) + ", Master Volume: " + str(master_volume))
#
#func set_settings():
#	settings = [{"coins":coins},{"muted":muted},{"master_volume":master_volume}]
#
#func set_string_settings():
#	string_settings = [{"coins":str(coins)},{"muted":str(muted)},{"master_volume":str(master_volume)}]
#
#func set_muted(string):
#	if string == null:
#		muted = false
#	if string == "False":
#		muted = false
#	elif string == "false":
#		muted = false
#	elif string == "True":
#		muted = true
#	elif string == "true":
#		muted = true
#
#func null_check():
#	if coins == null:
#		coins = 0
#		save()
#	if muted == null:
#		muted = false
#		save()
#	if master_volume == null:
#		master_volume = 60
#		save()