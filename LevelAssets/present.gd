extends Node3D

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		print("player got me")
		queue_free()
