extends CanvasLayer

@onready var animations: AnimationPlayer = $Animations

func change_scene_with_transition(scene_path: StringName) -> void:
	animations.play("fade")
	await animations.animation_finished
	get_tree().change_scene_to_file(scene_path)
	animations.play_backwards("fade")
