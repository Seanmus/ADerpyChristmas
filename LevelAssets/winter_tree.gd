extends Node3D

@onready var winEffect = $WinEffect
@export var nextLevel: String

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		var player := body as Player
		if player.presents >= player.presentsInLevel:
			winEffect.play()
			print("YOU WON!")
		else:
			print("Not enough presents yet")


func _on_win_effect_finished():
	get_tree().change_scene_to_file(nextLevel)
