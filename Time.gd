extends Node2D

@export var length:int=3
@export var speed : float = .4
var tile_size : int = 40
var foodpos = 0
@onready var all_possible_positions : Array = []

func _ready():
	for x in range(1,12):
		for y in range(1,17):
			all_possible_positions.append(Vector2(x*tile_size-20,y*tile_size-20))
			#the -20 is because I fucked up and need to adjust the coordinates to match the grid that the snake is on whoops
			
	food_spawn()
	
	
func _process(_delta):
	get_node("GlobalTimer").wait_time = speed
	
func _on_global_timer_timeout():
	var started = get_node("MainSegment").started
	get_all_object_position()
	if started == true:
		var createsegment = load("res://old_segment.tscn").instantiate()
		createsegment.position = get_node("MainSegment").position
		add_child(createsegment)

func get_all_object_position():
	var all_pos : Array
	for pos in self.get_children():
		if pos is Node2D:
			all_pos.append(pos.position)
	return all_pos
	
#func random_pos():
#	return Vector2(randi_range(1,11), randi_range(1,17)) * tile_size	
	
func random_pos2():
	var rand2 = all_positions()
	rand2.shuffle()
	return rand2[0]
	
func valid_coord(check):
	var radar = get_all_object_position()
	for i in radar:
		if check == i:
			return false
			return
		else:
			return true
func all_positions():
	var remaining = all_possible_positions
	for bad in get_all_object_position():
		remaining.erase(bad)
	return remaining


func food_spawn():
	var spawnpoint = random_pos2()
	#var createfood = load("res://food.tscn").instantiate()
	#createfood.position = spawnpoint
	#add_child(createfood)
	#var spawnpoint = random_pos2()
	#if valid_coord(spawnpoint) == true:
	get_node("Food").position = spawnpoint
	#else:
	#	food_spawn()

#would it be better to iterate through all valid locations and just pick a random location from that? this guarantees success
#yes james, it would.
