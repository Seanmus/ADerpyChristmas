extends Node3D


# Called when the node enters the scene tree for the first time.
func _RotateForward( angleToAdd):
	rotate_object_local(Vector3.FORWARD, angleToAdd)
