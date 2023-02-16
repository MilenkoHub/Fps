extends Spatial


# Declare member variables here. Examples:
var mouse_move
var sw_thresh = 5
var sw_lerp = 5
export var sw_left : Vector3
export var sw_right : Vector3
export var sw_normal : Vector3


# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventMouseMotion:
		mouse_move = -event.relative.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_move != null:
		if mouse_move > sw_thresh:
			rotation = rotation.linear_interpolate(sw_left,sw_lerp * delta)
		elif mouse_move < -sw_thresh:
			rotation = rotation.linear_interpolate(sw_right,sw_lerp * delta)
		else:
			rotation = rotation.linear_interpolate(sw_normal,sw_lerp * delta)
