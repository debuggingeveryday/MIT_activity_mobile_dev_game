extends Label
onready var timer = get_parent().get_node("Timer")
var DisplayValue = 0

func _ready():
	timer.set_wait_time(2)
	timer.start()
	pass

func _on_Timer_timeout():
	DisplayValue += 1
	text = DisplayValue
	pass # Replace with function body.
