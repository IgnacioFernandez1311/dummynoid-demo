extends Control

@onready var play_button: TextureButton = $Margins/Menu/Play/PlayButton
@onready var quit_button: TextureButton = $Margins/Menu/Quit/QuitButton

func _ready() -> void:
	play_button.pressed.connect(func() -> void: SceneTransition.change_scene_with_transition("res://scenes/level.tscn"))
	quit_button.pressed.connect(func() -> void: get_tree().quit())
