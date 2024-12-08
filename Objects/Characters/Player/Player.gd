extends CharacterBody3D


var SPEED: float = 5.0
var JUMP_VELOCITY: float = 4.5: set = set_jump_velocity, get = get_jump_velocity
var angle: Array = ["rawr", "juga"]

@onready var animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	LimboConsole.register_command(jump, "jump", "jump")
	LimboConsole.register_command(set_jump_velocity, "set_jump_velocity", "set jump velocity")
	Dialogic.start("test")


func _process(_delta: float) -> void:
	animation_tree.set("parameters/blend_position", Vector2(velocity.x, velocity.z * -1))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		#handle directional walk
		animation_tree.set("parameters/Blend2/blend_amount", input_dir.length())

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
