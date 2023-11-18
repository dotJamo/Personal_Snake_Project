extends Area2D

var last_direction = Vector2.RIGHT
@onready var tile_size : int = get_node("/root/Main/").tile_size
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}
var started:bool=false
@onready var gtimer = get_node("/root/Main/GlobalTimer")
var all_pos:Array = []
@onready var food = get_node("/root/Main/Food")
@onready var main = get_node("/root/Main/")

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir) and inputs[dir] != -last_direction:
			move(dir)
		if event.is_action_pressed(dir) and started == false:
			move(dir)

func move(dir):
	started = true
	last_direction = inputs[dir]
	gtimer.stop()
	gtimer.wait_time = 0.01
	gtimer.start()
	

func _on_global_timer_timeout():
	if started == true:
		get_all_object_position_but_not_food()
		var new_position = position + last_direction * tile_size
		for check in all_pos:
			if new_position == check:
				get_tree().reload_current_scene()
			if new_position.x >= 440 or new_position.x <= 0 or new_position.y >= 680 or new_position.y <= 0:
				get_tree().reload_current_scene()
		all_pos.clear()
		if new_position == food.position:
			main.food_spawn()
			main.length += 1
			main.speed *= .97
		position = new_position
func get_all_object_position_but_not_food():
	for pos in main.get_children():
		if pos.is_in_group("collisionobjects"):
			all_pos.append(pos.position)
