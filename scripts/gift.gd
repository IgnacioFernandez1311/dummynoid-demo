class_name Gift extends RigidBody2D

const SPEED: int = 100

enum GiftType {
	INCREMENT_SIZE,
	SPEED_SLOW,
	SPEED_FAST,
	INCREMENT_HEALTH,
	NEW_BALL,
	SLOW_PLAYER
}

@onready var sprites: AnimatedSprite2D = $Sprites

func _ready() -> void:
	sprites.frame = randi() % 6

func _on_visible_notifier_screen_exited() -> void:
	queue_free()

func _physics_process(_delta: float) -> void:
	linear_velocity = Vector2.DOWN * SPEED

func _on_body_entered(body: Node) -> void:
	if body is Player:
#		body = body as Player
		queue_free()
		body.gift_picked.emit(self)



