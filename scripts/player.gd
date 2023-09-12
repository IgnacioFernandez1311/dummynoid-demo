class_name Player extends CharacterBody2D

signal gift_picked(gift: Gift)

var speed: float = 300

@export_node_path("CanvasLayer") var ui_path: NodePath
@onready var ui: CanvasLayer = get_node(ui_path)
@export_node_path("Node2D") var level_path: NodePath
@onready var level_manager: LevelManager = get_node(level_path)

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var hit_audio: AudioStreamPlayer = $HitAudio
@onready var player_collision: CollisionShape2D = $PlayerCollision
@onready var power_up_audio: AudioStreamPlayer = $PowerUpAudio
@onready var power_up_timer: Timer = $PowerUpTimer

var health: int = 3

func _physics_process(_delta: float) -> void:
	position.y = 478
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed * .5)
	
	move_and_slide()

func _process(_delta: float) -> void:
	ui.update_health(health)

func hit() -> void:
	hit_audio.play()

func _on_gift_picked(gift: Gift) -> void:
	call_deferred("enable_power_up", gift)

func _balls_speed(speed_scale: float) -> void:
	for ball in level_manager.balls:
				ball.speed *= speed_scale
				print(ball.speed)
				ball.speed_timer.start(3)

func enable_power_up(gift: Gift) -> void:
	match gift.sprites.frame:
		gift.GiftType.INCREMENT_SIZE:
			print("Primer Frame del Power Up")
			player_sprite.frame = 1
			player_collision.shape.height = 80
			power_up_timer.start()
		gift.GiftType.SPEED_SLOW:
			_balls_speed(.5)
		gift.GiftType.SPEED_FAST:
			_balls_speed(1.5)
		gift.GiftType.NEW_BALL:
			var ball_tscn: PackedScene = load("res://scenes/ball.tscn")
			var new_ball: CharacterBody2D = ball_tscn.instantiate()
			level_manager.set_ball_position(new_ball)
			new_ball.can_play = false
			level_manager.get_node("BallsContainer").add_child(new_ball)
		gift.GiftType.INCREMENT_HEALTH:
			health += 1
		gift.GiftType.SLOW_PLAYER:
			speed = 150
			$SpeedTimer.start()
		_:
			print("Otro Frame del Power Up")
	power_up_audio.play()

func disable_power_up() -> void:
	player_sprite.frame = 0
	player_collision.shape.height = 68

func _on_power_up_timer_timeout() -> void:
	disable_power_up()


func _on_speed_timer_timeout() -> void:
	speed = 300
