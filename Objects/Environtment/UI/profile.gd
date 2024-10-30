
extends Control

@onready var exit: Button = $MarginContainer/VBoxContainer/Exit as Button
@onready var sign_out: Button = $"MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer3/Sign Out" as Button

signal exit_ava

func _ready() -> void:
	sign_out.button_down.connect(on_signout_pressed)
	exit.button_down.connect(on_exit_pressed)
	set_process(false)
	
func on_signout_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/login.tscn")
	
func on_exit_pressed () -> void:
	exit_ava.emit()
	set_process(false)
