extends Node3D


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		var player := body as Player
		if player.presents >= player.presentsInLevel:
			print("YOU WON!")
		else:
			print("Not enough presents yet")


func _on_win_effect_finished():
	get_tree().change_scene_to_file("res://.godot/imported/bouncePad.fbx-c7fa70041aadb1a2ad87fb154a102f3a.scn")
