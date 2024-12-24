extends Spatial


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$spacecraft/AnimationPlayer.play("we_are_in_the_space")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func chang_scens():
	get_tree().change_scene("res://scenses/world_to_play.tscn")
