extends CharacterBody3D


var SPEED = 5.0
var JUMP_VELOCITY: float = 4.5: set = set_jump_velocity, get = get_jump_velocity

@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D

func _ready() -> void:
	LimboConsole.register_command(jump, "jump", "jump")
	LimboConsole.register_command(set_jump_velocity, "set_jump_velocity", "set jump velocity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func jump():
	LimboConsole.info("Jump!")
	velocity.y = JUMP_VELOCITY

func set_jump_velocity(value: float) -> void:
	LimboConsole.info("Set jump velocity to: " + str(value))
	JUMP_VELOCITY = value

func get_jump_velocity() -> float:
	return JUMP_VELOCITY
