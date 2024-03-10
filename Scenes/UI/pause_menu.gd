extends Control

@onready var game_manager = %GameManager

func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_toggle_gaame_paaused)
	

func _on_game_manager_toggle_gaame_paaused(is_paused : bool):
	if is_paused:
		show()
	else:
		hide()


func _on_reusme_pressed():
	game_manager.game_paused = false


func _on_exit_pressed():
	get_tree().quit()
