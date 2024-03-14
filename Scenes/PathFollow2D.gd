extends PathFollow2D

@export var speed := 0.1
@export var is_enemy := true

func _process(delta):
	progress_ratio += speed * delta
	if get_child_count() < 2 and is_enemy:
		get_parent().queue_free()
