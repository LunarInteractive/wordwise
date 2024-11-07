class_name Settings
extends Control

@onready var exit: Button = $MarginContainer/VBoxContainer/Exit as Button

signal exit_setting

func _ready() -> void:
	exit.button_down.connect(on_exit_pressed)
	set_process(false)
	
func on_exit_pressed () -> void:
	exit_setting.emit()
	set_process(false)