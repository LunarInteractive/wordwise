class_name Menu
extends Control


@onready var task: Button = $"MarginContainer/HBoxContainer/VBC Profile and Task/HBoxContainer/Task" as Button
@onready var mode: Button = $"MarginContainer/HBoxContainer/VBC Setting and Play/HBoxContainer/Mode" as Button
@onready var play: Button = $"MarginContainer/HBoxContainer/VBC Setting and Play/HBoxContainer/Play" as Button

@onready var setting: Button = $"MarginContainer/HBoxContainer/VBC Setting and Play/Setting" as Button

@onready var settings: Settings = $Settings as Settings
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer
@onready var avatar: Button = $"MarginContainer/HBoxContainer/VBC Profile and Task/HBC Profile/TextureRect2/Avatar" as Button

@onready var customize: Custom = $Customize as Custom
@onready var custom: Button = $"MarginContainer/HBoxContainer/VBC Profile and Task/HBoxContainer/Custom" as Button

var charvalue = 0
func _ready() :
	handle_connecting_signal()
	
func on_ava_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/profile.tscn")
	
func on_play_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/play.tscn")

func on_task_pressed():
	get_tree().change_scene_to_file("res://UI Asset/Scene/task_panel.tscn")
	
func on_setting_pressed() -> void:
	margin_container.visible = false
	settings.set_process(false)
	settings.visible = true

func on_exit_on_setting() -> void:
	margin_container.visible = true
	settings.visible = false
	
func on_custom_pressed() -> void:
	margin_container.visible = false
	customize.set_process(false)
	customize.visible = true

func on_confirm_on_custom() -> void:
	margin_container.visible = true
	customize.visible = false
	
func handle_connecting_signal() -> void:
	setting.button_down.connect(on_setting_pressed)
	settings.exit_setting.connect(on_exit_on_setting)
	
	avatar.button_down.connect(on_ava_pressed)
	play.button_down.connect(on_play_pressed)
	task.button_down.connect(on_task_pressed)
	
	custom.button_down.connect(on_custom_pressed)
	customize.confirm_confirm.connect(on_confirm_on_custom)
