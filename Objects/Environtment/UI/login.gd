extends Control

@onready var si: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/SI as Button
@onready var su: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/SU as Button

func _ready() :
	handle_connecting_signal()

func on_si_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
	
func on_su_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/signup.tscn")
	
func handle_connecting_signal() -> void:
	su.button_down.connect(on_su_pressed)
	si.button_down.connect(on_si_pressed)
