class_name Ball extends CharacterBody2D

const LINEAR_VELOCITY: Vector2 = Vector2(50, -300)

@onready var level_manager: LevelManager = get_parent().get_parent()
@onready var ball_angle_timer: Timer = $BallAngleTimer
@onready var speed_timer: Timer = $SpeedTimer

var speed: float = 1
var can_play: bool = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and !level_manager.is_game_started:
		velocity = LINEAR_VELOCITY
		level_manager.start()
		level_manager.is_game_started = true
	if event.is_action_pressed("ui_accept") and !can_play:
		velocity = LINEAR_VELOCITY
		can_play = true

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta * speed)
	if collision:
		var body_collider: PhysicsBody2D = collision.get_collider()
		if body_collider is Player:
			body_collider.hit()
		if body_collider.is_in_group("gr_border"):
			body_collider.get_parent().border_hit()
		if body_collider.is_in_group("gr_block"):
			body_collider.break_block(level_manager)
		if int(collision.get_angle(Vector2.UP) * 100) == 157 and ball_angle_timer.is_stopped():
			ball_angle_timer.start(8)
		elif int(collision.get_angle(Vector2.UP) * 100) != 157 and !ball_angle_timer.is_stopped():
			ball_angle_timer.stop()
		print(roundf(collision.get_angle(Vector2.UP)))
		print(int(collision.get_angle(Vector2.UP) * 100))
		velocity = velocity.bounce(collision.get_normal())

func _on_visible_notifier_screen_exited() -> void:
	if get_parent().get_child_count() == 1:
		level_manager.player.health -= 1
		level_manager.lose_ball()
		level_manager.is_game_started = false
		speed_timer.start(0)
	else:
		level_manager.balls.erase(self)
		queue_free()
	if level_manager.player.health <= 0:
		print("Perdiste")
		level_manager.replay()

func _on_speed_timer_timeout() -> void:
	speed = 1


func _on_ball_angle_timer_timeout() -> void:
	velocity = LINEAR_VELOCITY
