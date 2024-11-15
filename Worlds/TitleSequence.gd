extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		_StartGame()

func _StartGame():
	get_tree().change_scene_to_file("res://Worlds/world.tscn")


func _on_animation_player_animation_finished(anim_name):
	_StartGame()
