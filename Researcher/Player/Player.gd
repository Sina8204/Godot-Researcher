extends KinematicBody

export var speed = 10
export var acceleration = 5
var gravity = 0.05
export var jump_power = 30
export var mouse_sensitivity = 0.3

onready var head = $spacecraft/head
onready var camera = $spacecraft/head/Camera

var velocity = Vector3()
var camera_x_rotation = 0

var is_gravity_on = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if is_gravity_on == false:
		space(event)
	else:
		space_x(event)


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):
	var head_basis
	
	if is_gravity_on == false :
		head_basis = camera.get_global_transform().basis
	else:
		head_basis = head.get_global_transform().basis
	
	var direction = Vector3()
	
	if Input.is_action_pressed("front"):
		direction -= head_basis.z
	elif Input.is_action_pressed("back"):
		direction += head_basis.z
	
	if Input.is_action_pressed("left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("right"):
		direction += head_basis.x
	
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed , acceleration * delta)
	
	#gravity
	if is_gravity_on == false:
		gravity = 0.05
		velocity.y += gravity
	########
	
	if is_gravity_on == true:
		gravity = 0.98
		velocity.y -= gravity
		jump()
	
	velocity = move_and_slide (velocity , Vector3.UP)
	


func space(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		camera.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))

func space_x (event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y += jump_power
