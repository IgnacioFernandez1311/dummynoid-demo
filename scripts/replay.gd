extends Control


@onready var replay_button: TextureButton = $Margins/Menu/Replay/ReplayButton
@onready var quit_button: TextureButton = $Margins/Menu/Quit/QuitButton

var _on_replay_button_pressed: Callable = func() -> void:
	SceneTransition.change_scene_with_transition("res://scenes/level.tscn")
var _on_quit_button_pressed: Callable = func() -> void:
	SceneTransition.change_scene_with_transition("res://scenes/main_menu.tscn")

func _ready() -> void:
	replay_button.pressed.connect(_on_replay_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
