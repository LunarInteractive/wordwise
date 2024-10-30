class_name Menu
extends Control

@onready var task: Button = $"MarginContainer/HBoxContainer/VBC Profile and Task/Task" as Button
@onready var mode: Button = $"MarginContainer/HBoxContainer/VBC Mode/Mode" as Button
@onready var setting: Button = $"MarginContainer/HBoxContainer/VBC Setting and Play/Setting" as Button
@onready var play: Button = $"MarginContainer/HBoxContainer/VBC Setting and Play/Play" as Button
@onready var settings: Settings = $Settings as Settings
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer
@onready var prev: Button = $"MarginContainer/HBoxContainer/VBC PREV/PREV" as Button
@onready var next: Button = $"MarginContainer/HBoxContainer/VBC NEXT/NEXT" as Button
@onready var avatar: Button = $"MarginContainer/HBoxContainer/VBC Profile and Task/HBC Profile/TextureRect2/Avatar" as Button
@onready var profile: Control = $Profile





var charvalue = 0
func _ready() :
	handle_connecting_signal()
	
func update_chara(val) :
	charvalue += val
	charvalue = min(charvalue, 2)
	charvalue = max(-1, charvalue)
		
	if charvalue > 1:
		charvalue = 0
		print(charvalue)
		
	elif charvalue < 0:
		charvalue = 1
		print(charvalue)
	
	else:
		print(charvalue)
		
	$"MarginContainer/HBoxContainer/VBC Mode/Node2D/Sprite".frame = charvalue
	
func on_prev_pressed():
	update_chara(-1)

func on_next_pressed():
	update_chara(+1)
	
func on_ava_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/profile.tscn")
	
func on_play_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/play.tscn")
	
func on_setting_pressed() -> void:
	margin_container.visible = false
	settings.set_process(false)
	settings.visible = true

func on_exit_on_setting() -> void:
	margin_container.visible = true
	settings.visible = false
	
func handle_connecting_signal() -> void:
	setting.button_down.connect(on_setting_pressed)
	settings.exit_setting.connect(on_exit_on_setting)
	prev.button_down.connect(on_prev_pressed)
	next.button_down.connect(on_next_pressed)
	avatar.button_down.connect(on_ava_pressed)
	play.button_down.connect(on_play_pressed)
