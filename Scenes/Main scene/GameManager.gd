extends Node


@onready var player = %MyPlayer
@onready var game_over_screen = %GameOverScreen

func _process(_delta):
	
	if player.is_dead:
		show_game_over_screen()
	
	restart_scene()



##restart on R
func restart_scene():
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func show_game_over_screen():
	game_over_screen.visible = true
	
