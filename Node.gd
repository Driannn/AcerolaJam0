extends Node

@export var main_music_loop = preload("res://Assets/Audio/Idea #2_fuzz 808_200bpm_loopable.ogg")
@onready var music_player = $MusicPlayer

func _ready():
	pass

func play_music():
	music_player.stream = main_music_loop
	music_player.play()
