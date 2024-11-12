extends CanvasLayer

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func Change_scene(Target: String) -> void:
	animationPlayer.play("Dissolf")
	await animationPlayer.animation_finished
	get_tree().change_scene_to_file(Target)
	animationPlayer.play("Reset")
	
