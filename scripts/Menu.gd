extends Node2D

onready var anim = $AnimationTree
const speed_anim = 0.03

var first_menu = true
var blend = "parameters/anims/blend_amount"

func _process(delta):
	animation()

func animation():
	var anim_tree = anim[blend]
	if first_menu == true :
		if anim_tree > 0 :
			anim[blend] -= speed_anim
		else :
			anim[blend] = 0
	else :
		if anim_tree < 1 :
			anim[blend] += speed_anim
		else :
			anim[blend] = 1


func _on_start_pressed():
	first_menu = false


func _on_Go_to_menu_pressed():
	first_menu = true


func _on_exit_pressed():
	get_tree().quit()


func _on_Space_mission_pressed():
	get_tree().change_scene("res://scenses/world.tscn")
