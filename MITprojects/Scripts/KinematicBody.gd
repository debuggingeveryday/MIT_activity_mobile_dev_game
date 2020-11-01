extends KinematicBody

var vel = Vector3()
var sens = 0.1
var crouch = false

onready var joystick = get_parent().get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/Control/Joystick/Joystick")
onready var anim_player = get_parent().get_node("Player/skeleton/AnimationPlayer")
onready var cam = get_parent().get_node("Player/Camera")
onready var positionLabel = get_parent().get_node("Control/Position")
onready var playerMesh = get_parent().get_node("Player/skeleton")

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _input(event) -> void:
	#if event is InputEventMouseMotion:
		#var movement = event.relative
		#cam.rotation.x += -deg2rad(movement.y * sens)
		#cam.rotation.x = clamp(cam.rotation.x, deg2rad(-90), deg2rad(90))
		#rotation.y += -deg2rad(movement.x * sens)
	
	#if event is InputEventScreenDrag:
		#if event.index == joystick.ongoing_drag:
			#return
	pass

func _process(delta) -> void:
	var accel = GameManager.accel
	var speed = GameManager.speed
	var grav = GameManager.grav
	var max_grav = GameManager.max_grav
	var jump_force = GameManager.jump_force
	var jumping = GameManager.jumping

	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	var target_dir = Vector2(0, 0)
	target_dir = joystick.get_value()
	
	if Input.is_action_pressed("up"):
		target_dir.y -= 1
	if Input.is_action_pressed("down"):
		target_dir.y += 1
	if Input.is_action_pressed("left"):
		target_dir.x -= 1
	if Input.is_action_pressed("right"):
		target_dir.x += 1
	
	if not (jumping or crouch):
		set_anim(target_dir)
	
	target_dir = target_dir.normalized().rotated(-rotation.y)
	
	vel.x = lerp(vel.x, target_dir.x * speed, accel * delta)
	vel.z = lerp(vel.z, target_dir.y * speed, accel * delta)
	
	vel.y += grav * delta
	if vel.y < max_grav:
		vel.y = max_grav
	
	if target_dir != Vector2(0, 0):
		anim_player.play("Skeleton_Run", 0.1)
		var angle = atan2(vel.x, vel.z)
		var char_rot = playerMesh.get_rotation()
		char_rot.y = angle
		playerMesh.set_rotation(char_rot)
	
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jump_force
	
	#if Input.is_action_pressed("crouch") and not crouch:
		#crouch = true
	
	#if Input.is_action_pressed("crouch") and crouch:
		#crouch = false
	
	move_and_slide(vel, Vector3(0, 1, 0))
	
	if is_on_floor() and vel.y < 0:
		vel.y = 0
		jumping = false

	pass

func on_finished():
	print("Animation Finished")
	pass

func set_animatation(dir):
	print(vel)
	pass
	
func set_anim(dir):
	#standby animation
	if dir == Vector2(0, 0) and anim_player.current_animation != "Skeleton_Standby":
		anim_player.play("Skeleton_Standby", 0.1)
	
	#forward animation
	if dir == Vector2(0, 1) and anim_player.current_animation != "Skeleton_Run":
		anim_player.play("Skeleton_Run", 0.1)
		
	#up-left animation
	if dir == Vector2(1, 1) and anim_player.current_animation != "Skeleton_Run":
		anim_player.play("Skeleton_Run", 0.1)
	
	#front-right animation
	if dir == Vector2(-1, 1) and anim_player.current_animation != "Skeleton_Run":
		anim_player.play("Skeleton_Run", 0.1)
		
	#left animation
	if dir == Vector2(1, 0) and anim_player.current_animation != "Skeleton_Run":
		anim_player.play("Skeleton_Run", 0.1)
	
	#right animation
	if dir == Vector2(-1, 0) and anim_player.current_animation != "Skeleton_Run":
		anim_player.play("Skeleton_Run", 0.1)
	
	#backward animation
	if dir == Vector2(0, -1) and anim_player.current_animation != "Skeleton_Run":
		anim_player.play_backwards("Skeleton_Run", 0.1)
	
	#right-backward animation
	if dir == Vector2(1, -1) and anim_player.current_animation != "Skeleton_Run":
		anim_player.play_backwards("Skeleton_Run", 0.1)
		
	#left-backward animation
	if dir == Vector2(-1, -1) and anim_player.current_animation != "Skeleton_Run":
		anim_player.play_backwards("Skeleton_Run", 0.1)
