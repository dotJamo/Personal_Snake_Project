extends Node2D

@export var length:int=3
@export var speed : float = .4

func _ready():
	pass
	#something about spawning the food.

func _process(_delta):
	get_node("GlobalTimer").wait_time = speed
	
func _on_global_timer_timeout():
	var started = get_node("MainSegment").started
	if started == true:
		var createsegment = load("res://old_segment.tscn").instantiate()
		createsegment.position = get_node("MainSegment").position
		add_child(createsegment)
		
func _get_all_object_position():
	var all_pos : Array = []
	var _food_pos = 0
	for pos in self.get_children():
		if pos is Node2D:
			all_pos.append(pos.position)
	
