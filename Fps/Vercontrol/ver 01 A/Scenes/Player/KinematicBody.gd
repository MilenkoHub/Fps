extends KinematicBody


# Declare member variables here. Examples:
var wishdir : Vector3
var velocity : Vector3
var fall : Vector3
var can_run = true
#type
var speed = 25
var fric = 4.5
var grav = 20
var jump = 8
var mouse_sense = 0.5
#type
onready var Head = $Head/Camera
onready var Pcap = $CollisionShape
onready var Headcast = $Headcast
onready var wepman = $Head/Camera/wepman

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sense))
		Head.rotate_x(deg2rad(-event.relative.y * mouse_sense))
		Head.rotation.x = clamp(Head.rotation.x, deg2rad(-90),deg2rad(90))
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP:
			wepman.switch_down()
		elif event.button_index == BUTTON_WHEEL_DOWN:
			wepman.switch_up()


func _process(delta):
	var cant_stand = false
	wishdir = Vector3()
	
	



	#crouch
	if Headcast.is_colliding():
		cant_stand = true
	if cant_stand == true:
		fall
	#gravity

	fall.y -= grav * delta
	if Input.is_action_pressed("jump") and is_on_floor():
		fall.y = jump

	#movement
	if Input.is_action_pressed("ctrl"):
		speed = 10
		Pcap.shape.height = 0.75
		$Head/Camera.translation.y = -0.517
	elif cant_stand == false:
		Pcap.shape.height = 1.746
		$Head/Camera.translation.y = 0
		speed = 25
	if Input.is_action_pressed("Move_Forward"):
		wishdir -= transform.basis.z
	if Input.is_action_pressed("Move_Backward"):
		wishdir += transform.basis.z
	if Input.is_action_pressed("Move_Left"):
		wishdir -= transform.basis.x
	if Input.is_action_pressed("Move_Right"):
		wishdir += transform.basis.x
	wishdir = wishdir.normalized()
	velocity = velocity.linear_interpolate(wishdir * speed,fric * delta)
	velocity = move_and_slide(velocity,Vector3.UP)
	move_and_slide(fall,Vector3.UP)


