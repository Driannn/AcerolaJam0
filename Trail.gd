extends Line2D
class_name MyTrails
#tutorial
#https://www.youtube.com/watch?v=y8bi0_Fggn0

##Store Trail points
var queue : Array
##Max lenght of the trail/queue
@export var max_lenght : int = 10
@export var position_offset : Vector2

func _process(_delta):
	#Testing, store mouse pos in a variable
	var pos = _get_position()
	
	#push each point in front of the queue
	queue.push_front(pos)
	
	#Remove points from the end when it reach its limit
	if queue.size() > max_lenght:
		queue.pop_back()
	
	#Clear all the points
	clear_points()
	
	#Draw the only points in the queue
	for point in queue:
		add_point(point)

func _get_position():
	return get_global_mouse_position() + position_offset
#get_parent().position
