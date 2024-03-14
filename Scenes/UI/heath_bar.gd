extends ProgressBar

#tutorial for this
#https://www.youtube.com/watch?v=f90ieBOoIYQ
@export var destroy_on_zero_health := false
@export var destroy_node: Node

@onready var damage_bar = %DamageBar
@onready var timer = %Timer

var health = 0 : set = _set_health

##Called everytime the var health is changed
func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		#queue_free()
		if destroy_on_zero_health:
			AudioManager.play_enemy_die_sound()
			#Destroy parent game object
			destroy_node.queue_free()
	
	if health < prev_health:
		timer.start()
	#In case of healing
	else:
		damage_bar.value = health


##Initialize health on max
func init_health(_health):
	health = _health
	max_value = health
	value = health
	
	damage_bar.max_value = health
	damage_bar.value = health


func _on_timer_timeout():
	damage_bar.value = health
