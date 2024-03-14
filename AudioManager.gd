extends Node2D

@onready var enemy_die = $EnemyDie
@onready var scene_transition = $SceneTransition

func play_enemy_die_sound():
	enemy_die.play()
	
func play_scene_transition():
	scene_transition.play()
