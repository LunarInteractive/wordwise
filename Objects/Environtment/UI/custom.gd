class_name Custom
extends Control

@onready var prev: Button = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Main/HBoxContainer/PREV as Button
@onready var next: Button = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Main/HBoxContainer/NEXT as Button
@onready var confirm: Button = $MarginContainer/VBoxContainer/Confirm as Button

signal confirm_confirm
var charvalue = 1
func _ready() :
	handle_connecting_signal()
	set_process(false)
	
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

func on_prev_pressed():
	update_chara(-1)
	$MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Main/HBoxContainer/Node2D/Sprite.frame = charvalue
	
func on_next_pressed():
	update_chara(+1)
	$MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Main/HBoxContainer/Node2D/Sprite.frame = charvalue
func on_confirm_pressed():
	confirm_confirm.emit()
	set_process(false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func handle_connecting_signal() -> void:
	prev.button_down.connect(on_prev_pressed)
	next.button_down.connect(on_next_pressed)
	confirm.button_down.connect(on_confirm_pressed)
