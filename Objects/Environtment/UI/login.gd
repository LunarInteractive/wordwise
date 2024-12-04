extends Control

@onready var Api_Grabber = $MarginContainer

@onready var Fullname_Textedit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Username
@onready var Password_Textedit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Password
@onready var si: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/SI
@onready var su: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/SU
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer

@onready var sign_up: Logup = $Sign_up as Logup

func _ready() :
	handle_connecting_signal()

func on_si_pressed():
	pass



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
	Api_Grabber.send_data_success.connect(change_scene)

func change_scene():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/profile.tscn")

func _on_si_pressed() -> void:
	var fullname = Fullname_Textedit.get_text()
	var password = Password_Textedit.get_text()
	
	if fullname != "" and password != "":
		Api_Grabber.fetch_all_data("https://lunarinteractive.net/api/v1/students", fullname)

	
	else: 
		print("somethings wrong in fullname or password")
