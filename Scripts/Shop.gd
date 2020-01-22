extends CanvasLayer

const WEAKENED_NIMBUS_PRICE = 5000
const SOLID_CLOUDS_PRICE = 8000
const GUARDIAN_TEMPEST_PRICE = 12000

var hundreds_place
var thousandths_place
onready var coin_text = get_node("Coins")
onready var PlayerConfig = get_node("/root/PlayerConfig")
onready var GameMaster = get_node("/root/GameMaster")
onready var Audio = get_node("/root/AudioMaster")

func _ready():
	set_coin_text()

func _process(delta):
	acquired_buttons()
	disabled_buttons()

func _on_MainMenu_pressed():
	Audio.play_button_audio()
	GameMaster.spawn_main_menu_screen()
	queue_free()

func _on_WeakenedNimbus_pressed():
	if PlayerConfig.coins >= WEAKENED_NIMBUS_PRICE and PlayerConfig.weakend_nimbus == false:
		Audio.play_button_audio()
		PlayerConfig.coins -= WEAKENED_NIMBUS_PRICE 
		set_coin_text()
		PlayerConfig.weakend_nimbus = true
		PlayerConfig.save_config_file()
		
func _on_SolidClouds_pressed():
	if PlayerConfig.coins >= SOLID_CLOUDS_PRICE and PlayerConfig.solid_clouds == false:
		Audio.play_button_audio()
		PlayerConfig.coins -= SOLID_CLOUDS_PRICE 
		set_coin_text()
		PlayerConfig.solid_clouds = true
		PlayerConfig.save_config_file()

func _on_GuardianWings_pressed():
	if PlayerConfig.coins >= GUARDIAN_TEMPEST_PRICE and PlayerConfig.guardian_tempest == false:
		Audio.play_button_audio()
		PlayerConfig.coins -= GUARDIAN_TEMPEST_PRICE 
		set_coin_text()
		PlayerConfig.guardian_tempest = true
		PlayerConfig.save_config_file()
		
func set_coin_text():
	coin_text.text = "$" + str(PlayerConfig.coins) 
	if PlayerConfig.coins > 1000:
		hundreds_place = fmod(PlayerConfig.coins, 1000)
		thousandths_place = int(PlayerConfig.coins / 1000)
		if hundreds_place < 100:
			hundreds_place = "0" + str(hundreds_place)
			if hundreds_place == "00":
				hundreds_place = "0" + str(hundreds_place)
		$Coins.text = "$" + str(thousandths_place) + "," + str(hundreds_place) 

func disabled_buttons():
	if PlayerConfig.coins < WEAKENED_NIMBUS_PRICE:
		$Upgrades/WeakenedNimbus.disabled = true
		$Upgrades/WeakenedNimbus.focus_mode = false
	if PlayerConfig.coins < SOLID_CLOUDS_PRICE:
		$Upgrades/SolidClouds.disabled = true
		$Upgrades/SolidClouds.focus_mode = false
	if PlayerConfig.coins < GUARDIAN_TEMPEST_PRICE:
		$Upgrades/GuardianTempest.disabled = true
		$Upgrades/GuardianTempest.focus_mode = false

func acquired_buttons():
	if PlayerConfig.weakened_nimbus == true:
		$Upgrades/WeakenedNimbus.set_modulate(Color("60ff54"))
		$Upgrades/WeakenedNimbus.text = "Weakened Nimbus (Acquired)"
	if PlayerConfig.solid_clouds == true:
		$Upgrades/SolidClouds.set_modulate(Color("60ff54"))
		$Upgrades/SolidClouds.text = "Solid Clouds (Acquired)"
	if PlayerConfig.guardian_tempest == true:
		$Upgrades/GuardianTempest.set_modulate(Color("60ff54"))
		$Upgrades/GuardianTempest.text = "Guardian Tempest (Acquired)"



# put this in the ready text, turn on visibility for the coin sprite, and left align the coin text to have a coin sprite appear on the left of the 
# label
# onready var coin_sprite = get_node("coin_sprite")
#	var coin_text_size = coin_text.get_minimum_size()
#	print (coin_text.get_minimum_size())

#	if coins < 10:
#		coin_text.rect_global_position.x = -20
#		coin_sprite.rect_global_position.x = coin_text.rect_global_position.x + coin_text_size.x + 27
#	elif coins >= 10 and coins < 100:
#		coin_text.rect_global_position.x = -13
#		coin_sprite.rect_global_position.x = coin_text.rect_global_position.x + coin_text_size.x + 18
#	elif coins >= 100 and coins < 1000:
#		coin_text.rect_global_position.x = -3
#		coin_sprite.rect_global_position.x = coin_text.rect_global_position.x + coin_text_size.x + 8
#	elif coins >= 1000 and coins < 10000:
#		coin_text.rect_global_position.x = 7
#		coin_sprite.rect_global_position.x = coin_text.rect_global_position.x + coin_text_size.x + 3





