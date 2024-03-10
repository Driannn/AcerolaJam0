extends Node

#
#@onready var player_health = %MyPlayer
#
func _process(_delta):
	
	restart_scene()
	
	#change to other scene
	#get_tree().change_scene_to_file("res://Scenes/Main scene/main_scene.tscn")


##restart on R
func restart_scene():
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
