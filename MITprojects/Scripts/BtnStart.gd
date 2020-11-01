extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BtnStart_button_down():
	print_debug("btn-start was press down")
	get_tree().change_scene("res://Scene/Main.tscn")
	
	pass # Replace with function body.
