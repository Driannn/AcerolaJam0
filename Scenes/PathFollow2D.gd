extends PathFollow2D

@export var speed := 0.1

func _process(delta):
	progress_ratio += speed * delta
	if get_child_count() < 2:
		get_parent().queue_free()
