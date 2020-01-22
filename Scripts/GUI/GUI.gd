extends CanvasLayer

var coin_counter 
var distance_traveled
onready var coin_sprite = $Coin
onready var coin_counter_text = $Coin_Counter
onready var distance_traveled_text = $Distance_Traveled
onready var best_distance_traveled_text = $Best_Distance_Traveled
onready var Player = get_node("/root/Player")
onready var PlayerConfig = get_node("/root/PlayerConfig")

# sets the Coin Counter
func _ready():
	best_distance_traveled_text.text = (str(PlayerConfig.best_distance_traveled) + " KM Best")
	coin_counter = 0
	distance_traveled = 0
	
func _process(delta):
	update_coins()
	update_distance_traveled()

func update_coins():
	# updates the coin art to be shifted when the coin counter text overlaps it
	coin_counter_text.text = str(coin_counter)   
	if coin_counter < 10:
		coin_sprite.rect_position.x = 13
	elif coin_counter >= 10 and coin_counter < 100:
		coin_sprite.rect_position.x = 19
	elif coin_counter >= 100 and coin_counter < 1000:
		coin_sprite.rect_position.x = 27
	elif coin_counter >= 1000:
		coin_sprite.rect_position.x = 33
	elif coin_counter >= 2000:
		coin_sprite.rect_position.x = 34

func update_distance_traveled():
	distance_traveled = round(Player.distance_traveled)
	distance_traveled_text.text = str(distance_traveled)
	if distance_traveled < 10:
		$KM.rect_position.x = 60
	elif distance_traveled >= 10 and distance_traveled < 100:
		$KM.rect_position.x = 67
	elif distance_traveled >= 100 and distance_traveled < 1000:
		$KM.rect_position.x = 74
	elif distance_traveled >= 1000:
		$KM.rect_position.x = 81
		
func coin_up():
	if PlayerConfig.double_coins == false:
		coin_counter += 1
	elif PlayerConfig.double_coins == true:
		coin_counter += 2

