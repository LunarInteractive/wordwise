extends CanvasLayer

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func Change_scene(Target: String) -> void:
	animationPlayer.play("Dissolf")
	await animationPlayer.animation_finished
	get_tree().change_scene_to_file(Target)
	animationPlayer.play("Reset")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
