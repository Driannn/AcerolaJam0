extends Node
class_name GameManager

@onready var player = %MyPlayer
@onready var game_over_screen = %GameOverScreen
@onready var pause_menu = %PauseMenu
@onready var max_enemies : int = %Enemies.get_child_count()
@onready var you_win_screen = %YouWinScreen
@onready var glow_red = %"Glow Red"

@export var open_door := false
@export var win_screen := false
@export var next_scene_path : String

var current_enemy_count : int
var win : bool

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

func _process(_delta):
	current_enemy_count = %Enemies.get_child_count()
	if current_enemy_count == 0:
		win = true
	
	if win and !game_paused and win_screen:
		you_win_screen.visible = true
	elif game_paused:
		you_win_screen.visible = false
	
	if win and open_door and glow_red != null:
		glow_red.queue_free()
	
	if !MusicController.is_music_playing:
		MusicController.play_music()
	
	if game_paused or player.is_dead or win:
		MusicController.pitch_down()
	else:
		MusicController.reset_pitch()
	
	if player.is_dead and !game_paused:
		game_over_screen.visible = true
	elif game_paused:
		game_over_screen.visible = false
	
	restart_scene()

##pause game, get input and change bool variable
func _input(event : InputEvent):
	if(event.is_action_pressed("pause")):
		game_paused = !game_paused
		#print("Game Paused")

##restart on R
func restart_scene():
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func load_next_scene():
	get_tree().change_scene_to_file(next_scene_path)

#Turn visible the game over canvas layer
func show_game_over_screen():
	game_over_screen.visible = true
	
#func pause_game():
	#if Input.is_action_just_pressed("pause"):
		##pause
