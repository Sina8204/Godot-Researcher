extends Spatial


func _ready():
<<<<<<< HEAD
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$spacecraft/AnimationPlayer.play("we_are_in_the_space")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

=======
	$spacecraft/AnimationPlayer.play("we_are_in_the_space")

>>>>>>> b9a0239caefa8869b14a09168b5a25d9b24d6bcf
func chang_scens():
	get_tree().change_scene("res://scenses/world_to_play.tscn")
