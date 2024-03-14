extends Node2D

@onready var enemy_die = $EnemyDie

func play_enemy_die_sound():
	enemy_die.play()
