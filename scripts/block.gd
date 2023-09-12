extends StaticBody2D

@onready var break_audio: AudioStreamPlayer = $BreakAudio
@onready var block_collision: CollisionShape2D = $BlockCollision
@onready var block_sprite: Sprite2D = $BlockSprite

func generate_gift(level_manager: Node2D) -> void:
	var random_gift: int = randi() % 2
	if random_gift == 1:
		var gift_tscn: PackedScene = load("res://scenes/gift.tscn")
		var gift_instance: RigidBody2D = gift_tscn.instantiate()
		gift_instance.global_position = global_position
		level_manager.add_child(gift_instance)

func break_block(level_manager: Node2D) -> void:
	break_audio.play()
	hide()
	block_collision.disabled = true
	if get_parent().get_child_count() == 1:
		level_manager.win()
	else:
		generate_gift(level_manager)
	await break_audio.finished
	queue_free()
