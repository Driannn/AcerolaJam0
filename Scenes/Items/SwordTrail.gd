extends MyTrails


func _get_position():
	return get_parent().global_position + position_offset
