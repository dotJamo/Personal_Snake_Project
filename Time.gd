extends Node2D

@export var length:int=3
@export var speed : float = .4
var tile_size : int = 40
var foodpos = 0
var positions = [Vector2(1,1),Vector2(10,1),Vector2(1,10),Vector2(10,10)]
var all_pos : Array = []

func _process(_delta):
	get_node("GlobalTimer").wait_time = speed
	
func _on_global_timer_timeout():
	all_pos.clear()
	var started = get_node("MainSegment").started
	get_all_object_position()
	if started == true:
		var createsegment = load("res://old_segment.tscn").instantiate()
		createsegment.position = get_node("MainSegment").position
		add_child(createsegment)
		food_spawn()

func get_all_object_position():
	for pos in self.get_children():
		if pos is Node2D:
			all_pos.append(pos.position)
			
func random_pos():
	return Vector2(randi_range(1,11), randi_range(1,17)) * tile_size	
	
func valid_coord(check):
	var radar = all_pos
	for i in radar:
		if check == i:
			return false
			return
		else:
			return true

func food_spawn():
	var spawnpoint = random_pos()
	print(str("random position is ", spawnpoint))
	if valid_coord(spawnpoint) == true:
		var createfood = load("res://food.tscn").instantiate()
		createfood.position = spawnpoint
		add_child(createfood)
	else:
		food_spawn()
