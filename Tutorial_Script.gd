extends Control

@onready var Tab_Container : TabContainer = $MarginPanelTask/PanelContainer/VBoxContainer/BadanPanel/MarginContainer/HBoxContainer/MarginBadanPanel/TabContainer
@onready var Prev_Button : Button = $MarginPanelTask/PanelContainer/VBoxContainer/BadanPanel/MarginContainer/HBoxContainer/Button_Prev
@onready var Next_Button : Button = $MarginPanelTask/PanelContainer/VBoxContainer/BadanPanel/MarginContainer/HBoxContainer/Button_Next


var tab_count : int = 0
var max_tab : int = 0

func _ready() -> void:
	max_tab = Tab_Container.get_tab_count()
	tab_count = 1
	

func _process(delta: float) -> void:
	if tab_count == 1:
		Prev_Button.disabled = true
	
	elif tab_count == max_tab:
		Next_Button.disabled = true
	
	else:
		Prev_Button.disabled = false
		Next_Button.disabled = false

func _on_button_prev_pressed() -> void:
	Tab_Container.select_previous_available()
	tab_count -= 1

func _on_button_next_pressed() -> void:
	Tab_Container.select_next_available()
	tab_count += 1
