extends Node2D

onready var PlayerConfig = get_node("/root/PlayerConfig")
onready var Player = get_node("/root/Player")
onready var coin_audio = get_node("CoinAudio")
onready var bg_audio = get_node("BGAudio")
onready var lightning_audio = get_node("LightningBoltAudio")
onready var player_hurt_audio = get_node("PlayerHurtAudio")
onready var player_jump_audio = get_node("PlayerJumpAudio")
onready var cirrus_audio = get_node("CirrusAudio")
onready var powerup_pickup = get_node("PowerupPickupAudio")
onready var button_audio = get_node("ButtonAudio")
onready var bottled_tempest_audio = get_node("BottledTempestAudio")

func _process(delta):
	if PlayerConfig.muted == false and bg_audio.is_playing() == false and Player.game_in_session == true:
		bg_audio.play()

func _ready():
	set_audio_volumes()

func play_coin_audio():
	if PlayerConfig.muted == false:
		coin_audio.play()

func toggle_bg_audio():
	if PlayerConfig.muted == false and bg_audio.is_playing() == false:
		bg_audio.play()
	elif PlayerConfig.muted == false and bg_audio.is_playing() == true:
		bg_audio.stop()

func play_lightningbolt_audio():
	if PlayerConfig.muted == false:
		lightning_audio.play()

func play_playerhurt_audio():
	if PlayerConfig.muted == false:
		player_hurt_audio.play()

func play_playerjump_audio():
	if PlayerConfig.muted == false and player_jump_audio.is_playing() == false:
		player_jump_audio.play()
		
func play_cirrus_audio():
	if PlayerConfig.muted == false and cirrus_audio.is_playing() == false:
		cirrus_audio.play()
		
func play_powerup_pickup_audio():
	if PlayerConfig.muted == false and powerup_pickup.is_playing() == false:
		powerup_pickup.play()

func play_button_audio():
	if PlayerConfig.muted == false and button_audio.is_playing() == false:
		button_audio.play()

func play_bottled_tempest_audio():
	if PlayerConfig.muted == false and bottled_tempest_audio.is_playing() == false:
		bottled_tempest_audio.play()

func set_audio_volumes():
	coin_audio.volume_db = (PlayerConfig.master_volume - 80)
	bg_audio.volume_db = (PlayerConfig.background_volume + PlayerConfig.master_volume - 150)
	lightning_audio.volume_db = (PlayerConfig.master_volume - 90)
	player_hurt_audio.volume_db = (PlayerConfig.master_volume - 75)
	player_jump_audio.volume_db =  (PlayerConfig.master_volume - 90)
	cirrus_audio.volume_db =  (PlayerConfig.master_volume - 80)
	powerup_pickup.volume_db =  (PlayerConfig.master_volume - 80)
	button_audio.volume_db =  (PlayerConfig.master_volume - 80)
	bottled_tempest_audio.volume_db =  (PlayerConfig.master_volume - 80)