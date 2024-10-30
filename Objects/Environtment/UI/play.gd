class_name Play
extends Control

@onready var b_1: Button = $"TabContainer/Chapter 1/MarginContainer/VBoxContainer/HBoxContainer3/B1" as Button
@onready var b_2: Button = $"TabContainer/Chapter 2/MarginContainer/VBoxContainer/HBoxContainer3/B2" as Button
@onready var b_3: Button = $"TabContainer/Chapter 3/MarginContainer/VBoxContainer/HBoxContainer3/B3" as Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handle_connecting_signal()

func back_pressed():
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")

func handle_connecting_signal() -> void:
	b_1.button_down.connect(back_pressed)
	b_2.button_down.connect(back_pressed)
	b_3.button_down.connect(back_pressed)
