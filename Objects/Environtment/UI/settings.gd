class_name Settings
extends Control

@onready var exit: TextureButton = $MarginContainer/Exit as TextureButton


signal exit_setting

func _ready() -> void:
	exit.button_down.connect(on_exit_pressed)
	set_process(false)
	
func on_exit_pressed () -> void:
	exit_setting.emit()
