extends Label

onready var Audio = get_node("/root/AudioMaster")

func _ready():
	$press_to_start_animation.play("start_screen_animation")

func _process(delta):
	if Input.is_action_just_pressed("space"):
		Audio.toggle_bg_audio()
		queue_free()