extends Spatial


func door_close_anim():
	$AnimationPlayer.play_backwards("door_open_close")
