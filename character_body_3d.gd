extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 6.0
const DASH_VELOCITY = 20.0
var isready = true

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("left2", "right2", "up2", "down2")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("Sprint") and isready:
		if direction:
			$DashTimer.start()
			$DashCooldown.start()
			SPEED = DASH_VELOCITY
			isready = false
	
	
		
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_dash_timer_timeout() -> void:
	SPEED = 5.0





func _on_dash_cooldown_timeout() -> void:
	isready = true
