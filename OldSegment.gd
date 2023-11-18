extends StaticBody2D

var lifetime:int = 0
@onready var length = get_parent().length

func _process(_delta):
	var timer = get_node("/root/Main/GlobalTimer")
	timer.timeout.connect(_on_global_timer_timeout)
	
	
func _on_global_timer_timeout():
	length = get_parent().length
	lifetime += 1
	if lifetime == length:
		queue_free()
