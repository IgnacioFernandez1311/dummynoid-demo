extends Control


func _ready() -> void:
	var win_timer: SceneTreeTimer = get_tree().create_timer(3)
	await win_timer.timeout
	SceneTransition.change_scene_with_transition("res://scenes/main_menu.tscn")
