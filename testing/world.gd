extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("Ugauga", asdfa)


func asdfa():
	get_tree().quit()
