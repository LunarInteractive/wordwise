extends Control

@onready var PanelPause : PanelContainer = $PanelContainer

func _on_button_pause_pressed() -> void:
	PanelPause.set_visible(true)


func _on_button_home_pressed() -> void:
	Dialogic.end_timeline()
	get_tree().change_scene_to_file('res://Objects/Environtment/UI/menu.tscn')


func _on_button_continue_pressed() -> void:
	PanelPause.set_visible(false)
