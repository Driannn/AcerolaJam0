extends Node

@export var main_music_loop = preload("res://Assets/Audio/Idea #2_fuzz 808_200bpm_loopable.ogg")
@onready var music_player = $MusicPlayer
var is_music_playing := false

@export var starting_pitch := 0.5
@export var on_pause_pitch := 0.25

func play_music():
	music_player.stream = main_music_loop
	music_player.play()
	is_music_playing = true

func pitch_down():
	music_player.pitch_scale = on_pause_pitch
	print(music_player.pitch_scale)

func reset_pitch():
	music_player.pitch_scale = starting_pitch
