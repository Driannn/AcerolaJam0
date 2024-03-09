extends Node2D

@onready var ap := %AnimationPlayer

@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		ap.play("slash")
		ap.queue("idle")
