extends Spatial


func _ready():
	$spacecraft/AnimationPlayer.play("we_are_in_the_space")

func chang_scens():
	get_tree().change_scene("res://scenses/world_to_play.tscn")
