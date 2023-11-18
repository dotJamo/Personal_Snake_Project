extends Area2D

var last_direction = Vector2.RIGHT
var tile_size : int = 40
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}
var started:bool=false
@onready var gtimer = get_node("/root/Main/GlobalTimer")


func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	started = true
	last_direction = inputs[dir]
	gtimer.stop()
	gtimer.wait_time = 0.05
	gtimer.start()
	

func _on_global_timer_timeout():
	if started == true:
		var old_position = position
		position += last_direction * tile_size
		
