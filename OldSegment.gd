extends StaticBody2D

var lifetime:int = 0
@onready var length = get_parent().length

func _ready():
	pass
	var timer = get_node("/root/Main/GlobalTimer")
	timer.timeout.connect(_on_global_timer_timeout)
	
func _on_global_timer_timeout():
	lifetime += 1
	if lifetime == length:
		queue_free()
