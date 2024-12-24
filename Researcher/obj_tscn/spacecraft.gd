extends Spatial

#onready var camera = [$Camera , $hand_right , $hand_left]
#onready var player_animes = $AnimationPlayer/player_anims

#func _ready():
#	player_animes.play("move_stop")

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30

onready var camera = $spacecraft/Camera

onready var player_animes = $spacecraft/AnimationPlayer/player_anims

var velocity = Vector3()


func _physics_process(delta):
	var head_basis = camera.get_global_transform().basis
	
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
	
	velocity = move_and_slide(velocity)
	





