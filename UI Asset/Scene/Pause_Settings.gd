extends Control

@onready var PanelPause : PanelContainer = $PanelContainer

func _on_button_pause_pressed() -> void:
	PanelPause.set_visible(true)


func _on_button_home_pressed() -> void:
	pass # Replace with function body.


func _on_button_continue_pressed() -> void:
	PanelPause.set_visible(false)
