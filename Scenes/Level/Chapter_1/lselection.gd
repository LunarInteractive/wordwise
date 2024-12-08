extends Node2D

@onready var Tutorial_layer : CanvasLayer = $Popup_Tutorial
@onready var kode_level = ""

#CH1
@onready var c_1l_1: Button = $"CanvasLayer/Control/TabContainer/Chapter 1/VBoxContainer/Control/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 1/MarginContainer/Chapter 1/C1L1"
@onready var c_1l_2: Button = $"CanvasLayer/Control/TabContainer/Chapter 1/VBoxContainer/Control/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 1/MarginContainer/Chapter 1/C1L2"
@onready var c_1l_3: Button = $"CanvasLayer/Control/TabContainer/Chapter 1/VBoxContainer/Control/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 1/MarginContainer/Chapter 1/C1L3"
@onready var c_1l_4: Button = $"CanvasLayer/Control/TabContainer/Chapter 1/VBoxContainer/Control/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 1/MarginContainer/Chapter 1/C1L4"
@onready var c_1l_5: Button = $"CanvasLayer/Control/TabContainer/Chapter 1/VBoxContainer/Control/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 1/MarginContainer/Chapter 1/C1L5"

#CH2
@onready var c_2l_1: Button = $"CanvasLayer/Control/TabContainer/Chapter 2/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 2/MarginContainer/Chapter 2/C2L1"
@onready var c_2l_2: Button = $"CanvasLayer/Control/TabContainer/Chapter 2/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 2/MarginContainer/Chapter 2/C2L2"
@onready var c_2l_3: Button = $"CanvasLayer/Control/TabContainer/Chapter 2/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 2/MarginContainer/Chapter 2/C2L3"
@onready var c_2l_4: Button = $"CanvasLayer/Control/TabContainer/Chapter 2/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 2/MarginContainer/Chapter 2/C2L4"
@onready var c_2l_5: Button = $"CanvasLayer/Control/TabContainer/Chapter 2/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 2/MarginContainer/Chapter 2/C2L5"

#CH3
@onready var c_3l_1: Button = $"CanvasLayer/Control/TabContainer/Chapter 3/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 3/MarginContainer/Chapter 3/C2L1"
@onready var c_3l_2: Button = $"CanvasLayer/Control/TabContainer/Chapter 3/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 3/MarginContainer/Chapter 3/C2L2"
@onready var c_3l_3: Button = $"CanvasLayer/Control/TabContainer/Chapter 3/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 3/MarginContainer/Chapter 3/C2L3"
@onready var c_3l_4: Button = $"CanvasLayer/Control/TabContainer/Chapter 3/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 3/MarginContainer/Chapter 3/C2L4"
@onready var c_3l_5: Button = $"CanvasLayer/Control/TabContainer/Chapter 3/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 3/MarginContainer/Chapter 3/C2L5"
#CH4
@onready var c_4l_1: Button = $"CanvasLayer/Control/TabContainer/Chapter 4/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 4/MarginContainer/Chapter 4/C2L1"
@onready var c_4l_2: Button = $"CanvasLayer/Control/TabContainer/Chapter 4/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 4/MarginContainer/Chapter 4/C2L2"
@onready var c_4l_3: Button = $"CanvasLayer/Control/TabContainer/Chapter 4/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 4/MarginContainer/Chapter 4/C2L3"
@onready var c_4l_4: Button = $"CanvasLayer/Control/TabContainer/Chapter 4/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 4/MarginContainer/Chapter 4/C2L4"
@onready var c_4l_5: Button = $"CanvasLayer/Control/TabContainer/Chapter 4/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 4/MarginContainer/Chapter 4/C2L5"
#CH5
@onready var c_5l_1: Button = $"CanvasLayer/Control/TabContainer/Chapter 5/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 5/MarginContainer/Chapter 5/C2L1"
@onready var c_5l_2: Button = $"CanvasLayer/Control/TabContainer/Chapter 5/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 5/MarginContainer/Chapter 5/C2L2"
@onready var c_5l_3: Button = $"CanvasLayer/Control/TabContainer/Chapter 5/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 5/MarginContainer/Chapter 5/C2L3"
@onready var c_5l_4: Button = $"CanvasLayer/Control/TabContainer/Chapter 5/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 5/MarginContainer/Chapter 5/C2L4"
@onready var c_5l_5: Button = $"CanvasLayer/Control/TabContainer/Chapter 5/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 5/MarginContainer/Chapter 5/C2L5"

#CH6
@onready var c_6l_1: Button = $"CanvasLayer/Control/TabContainer/Chapter 6/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 6/MarginContainer/Chapter 6/C2L1"
@onready var c_6l_2: Button = $"CanvasLayer/Control/TabContainer/Chapter 6/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 6/MarginContainer/Chapter 6/C2L2"
@onready var c_6l_3: Button = $"CanvasLayer/Control/TabContainer/Chapter 6/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 6/MarginContainer/Chapter 6/C2L3"
@onready var c_6l_4: Button = $"CanvasLayer/Control/TabContainer/Chapter 6/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 6/MarginContainer/Chapter 6/C2L4"
@onready var c_6l_5: Button = $"CanvasLayer/Control/TabContainer/Chapter 6/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 6/MarginContainer/Chapter 6/C2L5"

#CH7
@onready var c_7l_1: Button = $"CanvasLayer/Control/TabContainer/Chapter 7/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 7/MarginContainer/Chapter 7/C2L1"
@onready var c_7l_2: Button = $"CanvasLayer/Control/TabContainer/Chapter 7/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 7/MarginContainer/Chapter 7/C2L2"
@onready var c_7l_3: Button = $"CanvasLayer/Control/TabContainer/Chapter 7/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 7/MarginContainer/Chapter 7/C2L3"
@onready var c_7l_4: Button = $"CanvasLayer/Control/TabContainer/Chapter 7/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 7/MarginContainer/Chapter 7/C2L4"
@onready var c_7l_5: Button = $"CanvasLayer/Control/TabContainer/Chapter 7/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 7/MarginContainer/Chapter 7/C2L5"

#CH8
@onready var c_8l_1: Button = $"CanvasLayer/Control/TabContainer/Chapter 8/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 8/MarginContainer/Chapter 8/C2L1"
@onready var c_8l_2: Button = $"CanvasLayer/Control/TabContainer/Chapter 8/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 8/MarginContainer/Chapter 8/C2L2"
@onready var c_8l_3: Button = $"CanvasLayer/Control/TabContainer/Chapter 8/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 8/MarginContainer/Chapter 8/C2L3"
@onready var c_8l_4: Button = $"CanvasLayer/Control/TabContainer/Chapter 8/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 8/MarginContainer/Chapter 8/C2L4"
@onready var c_8l_5: Button = $"CanvasLayer/Control/TabContainer/Chapter 8/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 8/MarginContainer/Chapter 8/C2L5"

#CH9
@onready var c_9l_1: Button = $"CanvasLayer/Control/TabContainer/Chapter 9/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 9/MarginContainer/Chapter 9/C2L1"
@onready var c_9l_2: Button = $"CanvasLayer/Control/TabContainer/Chapter 9/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 9/MarginContainer/Chapter 9/C2L2"
@onready var c_9l_3: Button = $"CanvasLayer/Control/TabContainer/Chapter 9/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 9/MarginContainer/Chapter 9/C2L3"
@onready var c_9l_4: Button = $"CanvasLayer/Control/TabContainer/Chapter 9/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 9/MarginContainer/Chapter 9/C2L4"
@onready var c_9l_5: Button = $"CanvasLayer/Control/TabContainer/Chapter 9/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 9/MarginContainer/Chapter 9/C2L5"

#CH10
@onready var c_10l_1: Button = $"CanvasLayer/Control/TabContainer/Chapter 10/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 10/MarginContainer/Chapter 10/C2L1"
@onready var c_10l_2: Button = $"CanvasLayer/Control/TabContainer/Chapter 10/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 10/MarginContainer/Chapter 10/C2L2"
@onready var c_10l_3: Button = $"CanvasLayer/Control/TabContainer/Chapter 10/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 10/MarginContainer/Chapter 10/C2L3"
@onready var c_10l_4: Button = $"CanvasLayer/Control/TabContainer/Chapter 10/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 10/MarginContainer/Chapter 10/C2L4"
@onready var c_10l_5: Button = $"CanvasLayer/Control/TabContainer/Chapter 10/VBoxContainer/Control2/MarginContainer/ScrollContainer/HBoxContainer/Panel Chapter 10/MarginContainer/Chapter 10/C2L5"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handle_connecting_signal()

func setup_level(kode: String):
	kode_level = kode
	GlobalVariable.kode_level = kode_level
	print(GlobalVariable.kode_level)
	get_tree().change_scene_to_file("res://Scenes/Level/Chapter_1/Level_1.tscn")

#CHAPTER1
func _on_c_1l_1_pressed() -> void:
	setup_level("Chapter 1_Level 1")
func _on_c_1l_2_pressed() -> void:
	setup_level("Chapter 1_Level 2")
func _on_c_1l_3_pressed() -> void:
	setup_level("Chapter 1_Level 3")
func _on_c_1l_4_pressed() -> void:
	setup_level("Chapter 1_Level 4")
func _on_c_1l_5_pressed() -> void:
	setup_level("Chapter 1_Level 5")

#CHAPTER2
func _on_c_2l_1_pressed() -> void:
	setup_level("Chapter 2_Level 1")
func _on_c_2l_2_pressed() -> void:
	setup_level("Chapter 2_Level 2")
func _on_c_2l_3_pressed() -> void:
	setup_level("Chapter 2_Level 3")
func _on_c_2l_4_pressed() -> void:
	setup_level("Chapter 2_Level 4")
func _on_c_2l_5_pressed() -> void:
	setup_level("Chapter 2_Level 5")

#CHAPTER3
func _on_c_3l_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_3l_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_3l_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_3l_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_3l_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
	
#CHAPTER4
func _on_c_4l_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_4l_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_4l_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_4l_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_4l_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
	
#CHAPTER5
func _on_c_5l_1_pressed() -> void:
	setup_level("Chapter 5_Level 1")
func _on_c_5l_2_pressed() -> void:
	setup_level("Chapter 5_Level 2")
func _on_c_5l_3_pressed() -> void:
	setup_level("Chapter 5_Level 3")
func _on_c_5l_4_pressed() -> void:
	setup_level("Chapter 5_Level 4")
func _on_c_5l_5_pressed() -> void:
	setup_level("Chapter 5_Level 5")
	
#CHAPTER6
func _on_c_6l_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_6l_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_6l_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_6l_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_6l_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
	
#CHAPTER7
func _on_c_7l_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_7l_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_7l_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_7l_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_7l_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
	
#CHAPTER8
func _on_c_8l_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_8l_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_8l_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_8l_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_8l_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
	
#CHAPTER9
func _on_c_9l_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_9l_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_9l_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_9l_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_9l_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
	
#CHAPTER10
func _on_c_10l_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_10l_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_10l_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_10l_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
func _on_c_10l_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func handle_connecting_signal() -> void:
	#CHAPTER1
	c_1l_1.button_down.connect(_on_c_1l_1_pressed)
	c_1l_2.button_down.connect(_on_c_1l_2_pressed)
	c_1l_3.button_down.connect(_on_c_1l_3_pressed)
	c_1l_4.button_down.connect(_on_c_1l_4_pressed)
	c_1l_5.button_down.connect(_on_c_1l_5_pressed)
	
	#CHAPTER2
	c_2l_1.button_down.connect(_on_c_2l_1_pressed)
	c_2l_2.button_down.connect(_on_c_2l_2_pressed)
	c_2l_3.button_down.connect(_on_c_2l_3_pressed)
	c_2l_4.button_down.connect(_on_c_2l_4_pressed)
	c_2l_5.button_down.connect(_on_c_2l_5_pressed)
	
	#CHAPTER3
	c_3l_1.button_down.connect(_on_c_3l_1_pressed)
	c_3l_2.button_down.connect(_on_c_3l_2_pressed)
	c_3l_3.button_down.connect(_on_c_3l_3_pressed)
	c_3l_4.button_down.connect(_on_c_3l_4_pressed)
	c_3l_5.button_down.connect(_on_c_3l_5_pressed)
	
	#CHAPTER4
	c_4l_1.button_down.connect(_on_c_4l_1_pressed)
	c_4l_2.button_down.connect(_on_c_4l_2_pressed)
	c_4l_3.button_down.connect(_on_c_4l_3_pressed)
	c_4l_4.button_down.connect(_on_c_4l_4_pressed)
	c_4l_5.button_down.connect(_on_c_4l_5_pressed)
	
	#CHAPTER5
	c_5l_1.button_down.connect(_on_c_5l_1_pressed)
	c_5l_2.button_down.connect(_on_c_5l_2_pressed)
	c_5l_3.button_down.connect(_on_c_5l_3_pressed)
	c_5l_4.button_down.connect(_on_c_5l_4_pressed)
	c_5l_5.button_down.connect(_on_c_5l_5_pressed)
	
	#CHAPTER6
	c_6l_1.button_down.connect(_on_c_6l_1_pressed)
	c_6l_2.button_down.connect(_on_c_6l_2_pressed)
	c_6l_3.button_down.connect(_on_c_6l_3_pressed)
	c_6l_4.button_down.connect(_on_c_6l_4_pressed)
	c_6l_5.button_down.connect(_on_c_6l_5_pressed)
	
	#CHAPTER7
	c_7l_1.button_down.connect(_on_c_7l_1_pressed)
	c_7l_2.button_down.connect(_on_c_7l_2_pressed)
	c_7l_3.button_down.connect(_on_c_7l_3_pressed)
	c_7l_4.button_down.connect(_on_c_7l_4_pressed)
	c_7l_5.button_down.connect(_on_c_7l_5_pressed)
	
	#CHAPTER8
	c_8l_1.button_down.connect(_on_c_8l_1_pressed)
	c_8l_2.button_down.connect(_on_c_8l_2_pressed)
	c_8l_3.button_down.connect(_on_c_8l_3_pressed)
	c_8l_4.button_down.connect(_on_c_8l_4_pressed)
	c_8l_5.button_down.connect(_on_c_8l_5_pressed)
	
	#CHAPTER9
	c_9l_1.button_down.connect(_on_c_9l_1_pressed)
	c_9l_2.button_down.connect(_on_c_9l_2_pressed)
	c_9l_3.button_down.connect(_on_c_9l_3_pressed)
	c_9l_4.button_down.connect(_on_c_9l_4_pressed)
	c_9l_5.button_down.connect(_on_c_9l_5_pressed)
	
	#CHAPTER10
	c_10l_1.button_down.connect(_on_c_10l_1_pressed)
	c_10l_2.button_down.connect(_on_c_10l_2_pressed)
	c_10l_3.button_down.connect(_on_c_10l_3_pressed)
	c_10l_4.button_down.connect(_on_c_10l_4_pressed)
	c_10l_5.button_down.connect(_on_c_10l_5_pressed)


func _on_button_tutorial_pressed() -> void:
	Tutorial_layer.visible = true
