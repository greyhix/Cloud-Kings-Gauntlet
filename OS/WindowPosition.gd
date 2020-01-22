extends Node
var window_position = Vector2()

func _ready():
	OS.set_window_title("Cloud King's Gauntlet")
	window_position.x = 350
	window_position.y = 150
	OS.set_window_position(window_position)