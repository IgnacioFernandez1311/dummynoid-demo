class_name LevelManager extends Node2D

@onready var balls: Array[Node] = $BallsContainer.get_children()
@onready var player: CharacterBody2D = $Player
@onready var start_audio: AudioStreamPlayer = $StartAudio
@onready var ui: CanvasLayer = $UI
@onready var lose_audio: AudioStreamPlayer = $LoseAudio
var is_game_started: bool = false

func _ready() -> void:
	get_tree().paused = false

func _process(_delta: float) -> void:
	if not is_game_started:
		for ball in balls:
			set_ball_position(ball)

func replay() -> void:
	ui.hide()
	var replay_tscn: PackedScene = load("res://scenes/replay.tscn")
	var replay_instance: Control = replay_tscn.instantiate()
	add_child(replay_instance)
	get_tree().paused = true

func win() -> void:
	ui.hide()
	var win_tscn: PackedScene = load("res://scenes/win.tscn")
	var win_instance: Control = win_tscn.instantiate()
	add_child(win_instance)
	get_tree().paused = true

func start() -> void:
	start_audio.play()

func lose_ball() -> void:
	if player.health > 0:
		lose_audio.play()

func set_ball_position(ball: CharacterBody2D) -> void:
	ball.position.x = player.position.x + 20
	ball.position.y = player.position.y - 30
