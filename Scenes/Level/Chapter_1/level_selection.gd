extends PanelContainer

@onready var back: TextureButton = $VBoxContainer/HBoxContainer/Back as TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handle_connecting_signal()

func on_back_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func handle_connecting_signal() -> void:
	back.button_down.connect(on_back_pressed)
