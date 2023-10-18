extends Area3D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(delta)



func _on_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
