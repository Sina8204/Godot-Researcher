extends KinematicBody

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sensitivity = 0.3
onready var head = $head
onready var camera = $head/Camera

var velocity = Vector3()
var camera_x_rotation = 0

var move_action = { 
	"move_forward" : false , 
	"move_backward" : false ,
	"move_right" : false ,
	"move_left" : false 
	}

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	#var head_basis = head.get_global_transform().basis
	var head_basis = camera.get_global_transform().basis
	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
		move_action.move_forward = true
	elif Input.is_action_just_released("move_forward"):
		move_action.move_forward = false
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
		move_action.move_backward = true
	elif Input.is_action_just_released("move_backward") :
		move_action.move_backward = false
	#
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
		move_action.move_left = true
	elif Input.is_action_just_released("move_left"):
		move_action.move_left = false
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
		move_action.move_right = true
	elif Input.is_action_just_released("move_right"):
		move_action.move_right = false
	animation()
	
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	#velocity.y -= gravity
	#if Input.is_action_just_pressed("jump") and is_on_floor():
	#	velocity.y += jump_power
	velocity = move_and_slide (velocity , Vector3.UP)

func animation():
	var anim = $AnimationTree
	var noMove_front = "parameters/noMove_front/blend_amount"
	var moveBack = "parameters/moveBack/blend_amount"
	var moveLeft = "parameters/moveLeft/blend_amount"
	var moveRight = "parameters/moveRight/blend_amount"
	#
	if move_action.move_forward:
		if anim[noMove_front] < 1 :
			anim[noMove_front] += 0.1
		else :
			anim[noMove_front] = 1
	elif not move_action.move_forward:
		if anim[noMove_front] > 0 :
			anim[noMove_front] -= 0.1
		else :
			anim[noMove_front] = 0
	#
	if move_action.move_backward :
		if anim[moveBack] < 1 :
			anim[moveBack] += 0.1
		else :
			anim[moveBack] = 1
	elif not move_action.move_backward :
		if anim[moveBack] > 0:
			anim[moveBack] -= 0.1
		else :
			anim[moveBack] = 0
	#
	if move_action.move_left:
		if anim[moveLeft] < 1:
			anim[moveLeft] += 0.1
		else :
			anim[moveLeft] = 1
	elif not move_action.move_left:
		if anim[moveLeft] > 0:
			anim[moveLeft] -= 0.1
		else :
			anim[moveLeft] = 0
	#
	if move_action.move_right:
		if anim[moveRight] < 1:
			anim[moveRight] += 0.1
		else :
			anim[moveRight] = 1
	elif not move_action.move_right :
		if anim[moveRight] > 0:
			anim[moveRight] -= 0.1
		else :
			anim[moveRight] = 0



