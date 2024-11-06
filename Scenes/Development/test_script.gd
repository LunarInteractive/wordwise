extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.get_subsystem("Choices").connect("question_shown", handle_dialogic_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func handle_dialogic_signal(info: Dictionary):
	#get each choices in dictionary
	for choice in info["choices"]:
		print(choice.text)
