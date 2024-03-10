extends MyTrails

func _get_position():
	return get_parent().position + position_offset
