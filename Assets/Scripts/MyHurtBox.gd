class_name MyHurtBox
extends Area2D

func _init() -> void:
	#Disable all the layers on this hitbox
	collision_layer = 0
	
	#Set the mask layer of this hurt box to the number 2
	#Making it able to detect only the things on the hitbox layer
	collision_mask = 2
	
func _ready():
	pass
