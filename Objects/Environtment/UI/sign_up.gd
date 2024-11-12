class_name Logup
extends Control

@onready var su: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/su as Button
@onready var si: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/si as Button

signal signing_in

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handle_connecting_signal()
	set_process(false)
	
func on_signin_pressed():
	signing_in.emit()
	set_process(false)
	
func on_su_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func handle_connecting_signal() -> void:
	si.button_down.connect(on_signin_pressed)
	su.button_down.connect(on_su_pressed)
