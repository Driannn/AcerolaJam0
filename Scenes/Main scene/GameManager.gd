extends Node
class_name GameManager

@onready var player = %MyPlayer
@onready var game_over_screen = %GameOverScreen
@onready var pause_menu = %PauseMenu

#pause game tutorial
#https://www.youtube.com/watch?v=OWtwYp2lIlQ
signal toggle_game_paused(is_paused : bool)

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

func _ready():
	MusicController.play_music()

func _process(_delta):
	
	if player.is_dead:
		show_game_over_screen()
	
	restart_scene()

func _input(event : InputEvent):
	if(event.is_action_pressed("pause")):
		game_paused = !game_paused
		print("Game Paused")

##restart on R
func restart_scene():
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func show_game_over_screen():
	game_over_screen.visible = true
	
#func pause_game():
	#if Input.is_action_just_pressed("pause"):
		##pause
