extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("my_custom_signal", func_name)
	
func func_name():
	print("3")
