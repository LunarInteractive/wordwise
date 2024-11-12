extends Control

@onready var si: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/SI
@onready var su: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/SU
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer

@onready var sign_up: Logup = $Sign_up as Logup

func _ready() :
	handle_connecting_signal()

func on_si_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
	
func on_su_pressed():
	margin_container.visible = false
	sign_up.set_process(false)
	sign_up.visible = true
	
func on_signin_on_signup():
	margin_container.visible = true
	sign_up.visible = false
func handle_connecting_signal() -> void:
		si.button_down.connect(on_si_pressed)
		su.button_down.connect(on_su_pressed)
		sign_up.signing_in.connect(on_signin_on_signup)
