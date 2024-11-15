extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$TextureButton.grab_focus()

func _on_texture_button_pressed():
	$Transition/AnimationPlayer.play("transition")

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()


func transition_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://Worlds/TitleSequence.tscn")
