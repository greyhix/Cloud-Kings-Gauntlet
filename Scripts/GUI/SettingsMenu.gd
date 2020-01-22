extends CanvasLayer

onready var PlayerConfig = get_node("/root/PlayerConfig")
onready var GameMaster = get_node("/root/GameMaster")
onready var Audio = get_node("/root/AudioMaster")
onready var master_volume_slider = get_node("MasterVolumeSlider")
onready var master_volume = get_node("MasterVolume")
onready var background_music_volume_slider = get_node("BackgroundVolumeSlider")
onready var background_music_volume = get_node("BackgroundVolume")

var muted

func _ready():
	master_volume_slider.value = PlayerConfig.master_volume
	master_volume.text = "Master Volume " + str(PlayerConfig.master_volume)
	background_music_volume_slider.value = PlayerConfig.background_volume
	background_music_volume.text = "Music Volume " + str(PlayerConfig.background_volume)
	
	muted = PlayerConfig.muted
	if muted == false:
		$MuteButton.text = "  Mute  "
	elif muted == true:
		$MuteButton.text = " Unmute "
		
func _on_MuteButton_pressed():
	Audio.play_button_audio()
	if PlayerConfig.muted == false:
		PlayerConfig.muted = true
		PlayerConfig.save_config_file()
		Audio.play_button_audio()
		$MuteButton.text = " Unmute "
	elif PlayerConfig.muted == true:
		PlayerConfig.muted = false
		PlayerConfig.save_config_file()
		$MuteButton.text = "  Mute  "

func _on_MainMenuButton_pressed():
	Audio.play_button_audio()
	GameMaster.spawn_main_menu_screen()
	queue_free()

func _on_MasterVolumeSlider_value_changed(value):
	master_volume.text = "Master Volume " + str(value)
	PlayerConfig.master_volume = value
	PlayerConfig.save_config_file()
	Audio.set_audio_volumes()

func _on_BackgroundVolumeSlider_value_changed(value):
	background_music_volume.text = "Music Volume " + str(value)
	PlayerConfig.background_volume = value
	PlayerConfig.save_config_file()
	Audio.set_audio_volumes()
