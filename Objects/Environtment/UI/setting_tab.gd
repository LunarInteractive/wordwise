extends Control

@onready var advancey: TextureButton = $TabContainer/Visual/MarginContainer/VBoxContainer/Advanced/advancey as TextureButton
@onready var mc_advanced: MarginContainer = $"TabContainer/Visual/MarginContainer/VBoxContainer/Advanced/MC Advanced"
var is_visible = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handle_connecting_signal()

func on_advancey_pressed() -> void :
	is_visible = !is_visible
	mc_advanced.visible = is_visible
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func handle_connecting_signal() -> void:
	advancey.button_down.connect(on_advancey_pressed)
