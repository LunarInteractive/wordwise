extends CanvasLayer

@onready var UI_layer = $"../UI_dialog"

func _ready() -> void:
	Dialogic.start_timeline('chapter_1', "Level 1 - School")
