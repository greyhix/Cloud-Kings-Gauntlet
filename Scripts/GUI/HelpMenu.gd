extends CanvasLayer

onready var GameMaster = get_node("/root/GameMaster")

func _ready():
	$VBoxContainer.add_constant_override("separation", 8)

func _on_MainMenu_pressed():
	GameMaster.spawn_main_menu_screen()
	queue_free()

func _on_Enemies_pressed():
	var enemies_help_menu = preload("res://Scenes/GUI/EnemiesHelp.tscn").instance()
	GameMaster.add_child(enemies_help_menu)
	queue_free()

func _on_Powerups_pressed():
	var powerup_help_menu = preload("res://Scenes/GUI/PowerupHelp.tscn").instance()
	GameMaster.add_child(powerup_help_menu)
	queue_free()
