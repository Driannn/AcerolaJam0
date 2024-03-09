class_name MyHurtBox
extends Area2D

#@onready var l = 0
#@onready var m = 2

func _init() -> void:
	#Disable all the layers on this hitbox
	collision_layer = 0

	#Set the mask layer of this hurt box to the number 2
	#Making it able to detect only the things on the hitbox layer
	collision_mask = 2

func _ready():
#We use a signal to do something when a HurtBox detect a HitBox
	#connect("area_entered", self, "_on_area_entered")
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox: MyHitBox) -> void:
	if hitbox == null:
		return
	
	#Owner here is enemy node
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
