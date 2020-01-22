extends CanvasLayer

onready var GUI = get_node("/root/GUI")
onready var GameMaster = get_node("/root/GameMaster")
onready var Audio = get_node("/root/AudioMaster")
var coins_collected
var distance_traveled
var hundreds_place
var thousandths_place

func _ready():
	coins_collected = GUI.coin_counter
	distance_traveled = GUI.distance_traveled
	$VBoxContainer/CoinsCollected.text = str(coins_collected) + " Coins Collected"
	if distance_traveled < 1000:
		$VBoxContainer/DistanceTraveled.text = str(distance_traveled) + " KM Traveled"
	elif distance_traveled > 1000:
		hundreds_place = fmod(distance_traveled, 1000)
		thousandths_place = int(distance_traveled / 1000)
		if hundreds_place < 100:
			hundreds_place = "0" + str(hundreds_place)
		$VBoxContainer/DistanceTraveled.text = str(thousandths_place) + "," + str(hundreds_place) + " KM Traveled"

func _on_MainMenu_pressed():
	Audio.play_button_audio()
	GameMaster.spawn_main_menu_screen()
	queue_free()


func _on_PlayAgain_pressed():
	Audio.play_button_audio()
	GameMaster.game_restart()
	queue_free()
