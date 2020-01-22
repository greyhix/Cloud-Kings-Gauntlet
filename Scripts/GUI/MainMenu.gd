extends CanvasLayer

onready var Audio = get_node("/root/AudioMaster")

func  _on_Settings_pressed():
	Audio.play_button_audio()
	GameMaster.spawn_settings()
	queue_free()

func _on_PlayGame_pressed():
	Audio.play_button_audio()
	GameMaster.game_restart()
	queue_free()

func _on_Shop_pressed():
	Audio.play_button_audio()
	GameMaster.spawn_shop()
	queue_free()

func _on_Help_pressed():
	GameMaster.spawn_help_menu()
	queue_free()

func _on_CloseGame_pressed():
	get_tree().quit()


	