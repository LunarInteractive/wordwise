extends Control

@onready var ClassCodePanel = $PanelContainer
@onready var text_edit: TextEdit = $PanelContainer/MarginContainer/PanelContainer/VBoxContainer/Content/VBoxContainer/TextEdit
@onready var out: Button = $MarginContainer/VBoxContainer/HBoxContainer2/Out as Button
@onready var sign_in_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/SignIn as Button
@onready var sign_out_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/SignOut as Button
@onready var name_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Label

@onready var Student_Script = $Student_data_Grabber
const FILE_PATH = "user://saved_data.enc"

func _ready() -> void:
	out.button_down.connect(on_exit_pressed)
	set_process(false)
	
	check_save_file()  # Cek file save saat pertama kali _ready() dipanggil

func on_signout_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/login.tscn")

func on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")

func _on_button_cancel_pressed() -> void:
	ClassCodePanel.visible = false

func _on_button_Confirm_pressed() -> void:
	var Classcode_Text = text_edit.get_text()
	GlobalVariable.ClassCode = Classcode_Text
	print(Classcode_Text)
	ClassCodePanel.visible = false

func _on_button_Plus_pressed() -> void:
	ClassCodePanel.visible = true

func _on_sign_out_pressed() -> void:
	on_signout_pressed()

# Fungsi untuk mengecek apakah file save ada
func check_save_file() -> void:
	if FileAccess.file_exists(FILE_PATH):
		# Gunakan Student_Script untuk load dan decrypt data
		var saved_data = Student_Script.load_data()
		if saved_data.has("name"):  # Periksa apakah data memiliki properti "name"
			name_label.text = saved_data["name"]  # Ubah label nama
			print("Name loaded: ", saved_data["name"])
		
		# Aktifkan tombol sign out dan nonaktifkan tombol sign in
		sign_out_button.visible = false
		sign_in_button.visible = true
	else:
		print("No save file found.")
