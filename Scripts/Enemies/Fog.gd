extends AnimatedSprite

const OFFSET = 300

var player_hit
var velocity = Vector2()

func _ready():
	player_hit = false
	self.position.x = (Player.position.x + OFFSET)
	self.position.y = rand_range(20, 120)

	
func _process(delta):
	if player_hit == false:
		velocity.x = ((Player.position.x - position.x) * 0.5)
		velocity.y = ((Player.position.y - position.y) * 0.5)
		self.position.x += velocity.x * delta
		self.position.y += velocity.y * delta
	elif player_hit == true:
		self.position.x = Player.position.x
		self.position.y = Player.position.y 
		$fog_effect.visible = true
		$fog_effect.global_position.y = 70
		$fog_effect.global_position.x = Player.position.x + 90

		
func _on_Area2D_body_entered(body):
	player_hit = true
	$fog_effect.visible = true
	$fog_effect_timer.start()

func _on_fog_effect_timer_timeout():
	queue_free()

func _on_fog_queue_timer_timeout():
	queue_free()
