extends RigidBody3D

const SPEED = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$SpringArm3D.position = position
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		apply_impulse(Vector3(0,15,0))
		
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		apply_force(direction * SPEED)

