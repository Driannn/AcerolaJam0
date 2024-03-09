extends Node2D

@onready var ap := %AnimationPlayer

func take_damage(amount: int) -> void:
	ap.play("take_damage")
	ap.queue("idle")
	print ("Damage ", amount)
