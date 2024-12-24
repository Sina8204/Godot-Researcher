extends Spatial

var next_mission = false
var can_open_door = true
var can_play_friend_anim = true

const speed_door_anim = 0.05
var open_door = false
var close_door = true
#var friend_com_to_cobin = false
var close_door_for_ever = false

onready var anim = $AnimationTree

func _process(delta):
	if Input.is_action_just_pressed("next_mission") and next_mission :
		get_tree().change_scene("res://scenses/world_in_cobin.tscn")
	
	if open_door  and not close_door_for_ever:
		open_door()
	if close_door  and not close_door_for_ever:
		close_door()
	
	if close_door_for_ever :
		friend_com_to_cobin()

func _on_Area_to_open_kabin_door_body_entered(body):
	if body.name == "player" : # and can_open_door :
		#$spacecraft2/AnimationPlayer.play("door_open_close")
		open_door = true
		close_door = false


func _on_Area_to_open_kabin_door_body_exited(body):
	if body.name == "player" : # and can_open_door :
		#$spacecraft2/AnimationPlayer.play_backwards("door_open_close")
		open_door = false
		close_door = true


func _on_Area_to_close_the_door_body_entered(body):
	if body.name == "player" :
		$Label.visible = true
		$lable_anim.play("Press_shift")
		#$spacecraft2/AnimationPlayer.play("friend_com_to_cobin")
		next_mission = true
		close_door_for_ever = true
	

func open_door(): 
	if anim["parameters/door/blend_amount"] < 0 :
			anim["parameters/door/blend_amount"] += speed_door_anim
	else :
		anim["parameters/door/blend_amount"] = 0

func close_door(): 
	if anim["parameters/door/blend_amount"] > -1 :
			anim["parameters/door/blend_amount"] -= speed_door_anim
	else :
		anim["parameters/door/blend_amount"] = -1

func friend_com_to_cobin():
	if anim["parameters/door/blend_amount"] < 1 :
			anim["parameters/door/blend_amount"] += speed_door_anim
	else :
		anim["parameters/door/blend_amount"] = 1

