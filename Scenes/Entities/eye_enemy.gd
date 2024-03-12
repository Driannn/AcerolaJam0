extends Node2D

@export var health := 100
#@export var received_damage = 25

@onready var ap := %AnimationPlayer
@onready var health_bar = %HeathBar

func _ready():
	health_bar.init_health(health)

func take_damage(amount: int) -> void:
	ap.play("take_damage")
	print("Enermy take damage, health ", health)
	ap.queue("idle")
	set_health(amount)
	
##Updates enemies health bar
func set_health(value):
	health_bar.health -= value
