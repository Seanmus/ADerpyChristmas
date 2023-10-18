extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 6
var mouse_sensitivty = 0.002
var wasInAir
var stuckOnWall
@onready var anim = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

@onready var landEffect = $JumpEffect
@onready var jumpEffect = $JumpEffect
@onready var stickEffect = $StickEffect

@onready var derpy = $Chicky

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivty)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() && not stuckOnWall:
		wasInAir = true
		if velocity.y < 0:
			velocity.y -= gravity * 0.5 * delta
		velocity.y -= gravity * delta

	if is_on_floor():
		if wasInAir:
			animationState.travel("Land")
			landEffect.play()
		wasInAir = false
		
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or stuckOnWall):
		velocity.y = JUMP_VELOCITY
		animationState.travel("Jump")
		stuckOnWall = false
		jumpEffect.play()
	
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		animationState.travel("Hover")
		
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#Turn right
	if input_dir.x > 0 && input_dir.y == 0:
		derpy.rotation_degrees.y = -90
	#Turn right forward	
	if input_dir.x > 0 && input_dir.y < 0:
		derpy.rotation_degrees.y = -45
	#Turn left	
	if input_dir.x < 0 && input_dir.y == 0:
		derpy.rotation_degrees.y = 90
	#Turn left forward	
	if input_dir.x < 0 && input_dir.y < 0:
		derpy.rotation_degrees.y = 45	
	if input_dir.y < 0 && input_dir.x == 0:
		derpy.rotation_degrees.y = 0	
	if input_dir.x < 0 && input_dir.y > 0:
		derpy.rotation_degrees.y = 135		
	if input_dir.y > 0 && input_dir.x == 0:
		derpy.rotation_degrees.y = 180
	if input_dir.x > 0 && input_dir.y > 0:
		derpy.rotation_degrees.y = 225
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	

	if not stuckOnWall:
		move_and_slide()


func _on_sticky_area_entered(body):
	if(body.is_in_group("wall")):
		print(body.rotation)
		stickEffect.play()
		stuckOnWall = true


func _on_area_3d_body_exited(body):
	if(body.is_in_group("wall")):
		stuckOnWall = false


