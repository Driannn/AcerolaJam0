extends Area2D

signal my_custom_signal
var count := 0

func _ready():
	connect("mouse_entered", read_mouse_pos)
	

func read_mouse_pos() -> void:
	var mouse_pos = get_local_mouse_position()
	print("mouse entered", mouse_pos)
	count += 1
	if count >= 3:
		emit_signal("my_custom_signal")
