class_name MyHitBox
extends Area2D

@export var damage := 10

func _init() -> void:
	#Set the layer of this hit box to the number 2
	#seting this as part of the hit box layer
	collision_layer = 2
	#Disable all the mask on this hitbox
	collision_mask = 0
