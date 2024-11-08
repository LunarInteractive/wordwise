
extends Control

@onready var out: Button = $MarginContainer/VBoxContainer/HBoxContainer2/Out as Button
@onready var sign_out: Button = $"MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Sign Out" as Button

func _ready() -> void:
	sign_out.button_down.connect(on_signout_pressed)
	out.button_down.connect(on_exit_pressed)
	set_process(false)
	
func on_signout_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/login.tscn")
	
func on_exit_pressed () -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
