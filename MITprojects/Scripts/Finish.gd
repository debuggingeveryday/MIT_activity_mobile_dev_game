extends Control

func _ready():
	$Label.text = GameManager.score

func _on_Button_button_down():
	GameManager.accel = 15
	GameManager.speed = 5
	GameManager.grav = -200
	GameManager.max_grav = -150
	GameManager.jump_force = 20
	get_tree().change_scene("res://Scene/StartScreen.tscn")
	pass # Replace with function body.
