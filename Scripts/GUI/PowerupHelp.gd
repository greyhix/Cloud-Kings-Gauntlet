extends CanvasLayer

onready var GameMaster = get_node("/root/GameMaster")

func _on_Back_pressed():
	GameMaster.spawn_help_menu()
	queue_free()
