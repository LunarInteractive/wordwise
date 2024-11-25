extends Control

@onready var ClassCodePanel = $PanelContainer
@onready var text_edit: TextEdit = $PanelContainer/MarginContainer/PanelContainer/VBoxContainer/Content/VBoxContainer/TextEdit
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


func _on_button_cancel_pressed() -> void:
	ClassCodePanel.visible = false


func _on_button_Confirm_pressed() -> void:
	var Classcode_Text = text_edit.get_text()
	GlobalVariable.ClassCode = Classcode_Text
	print(Classcode_Text)
	ClassCodePanel.visible = false


func _on_button_Plus_pressed() -> void:
	ClassCodePanel.visible = true
