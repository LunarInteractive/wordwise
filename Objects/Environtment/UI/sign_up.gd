class_name Logup
extends Control

@onready var Api_Grabber = $MarginContainer

@onready var su: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/MarginContainer/VBoxContainer/su
@onready var si: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/MarginContainer/VBoxContainer/si

@onready var Fullname_TextEdit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Username
@onready var Password_TextEdit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Password
@onready var Password2_TextEdit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Password2
@onready var Data_Siswa: Dictionary = {
	"name": "",
	"sprite": 1,
	"level": 5,
	"total_points": 300,
	"teacher_id": 1,
	"email": "",
	"password": "",
	"password_confirmation": ""
}

signal signing_in

func _ready() -> void:
	# Connect button signals
	si.pressed.connect(on_signin_pressed)
	su.pressed.connect(on_su_pressed)
	Api_Grabber.send_API.connect(change_scene)

# Called when the sign-in button is pressed
func on_signin_pressed():
	emit_signal("signing_in")
	set_process(false)

# Called when the sign-up button is pressed
func on_su_pressed():
	var full_name = Fullname_TextEdit.get_text()
	var password = Password_TextEdit.get_text()
	var password2 = Password2_TextEdit.get_text()

	if full_name != "" and password != "" and password2 != "":
		if password != password2:
			print("Passwords do not match!")
			return

		Data_Siswa["name"] = full_name
		Data_Siswa["password"] = password
		Data_Siswa["password_confirmation"] = password2
		print("Sending data to API:", Data_Siswa)
		Api_Grabber.send_data_api(Data_Siswa)
		
		

	else:
		print("Please fill in all the fields.")

func change_scene():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/profile.tscn")
