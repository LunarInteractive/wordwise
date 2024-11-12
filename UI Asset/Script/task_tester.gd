extends Control

@onready var button = $MarginContainer/VBoxContainer/Button
@onready var button_2 = $MarginContainer/VBoxContainer/Button2
@onready var button_3 = $MarginContainer/VBoxContainer/Button3

var task_panel = load("res://UI Asset/Scene/task_panel.tscn")
var instance_panel : Node



func _on_button_button_up():
	if !instance_panel:
		instance_panel = task_panel.instantiate()
		get_tree().root.add_child(instance_panel)
		get_tree().root.move_child(instance_panel,0)
		instance_panel.global_position = global_position
		button_2.disabled = false
	elif instance_panel:
		instance_panel.queue_free()
		button_2.disabled = true
		

		


func _on_button_3_button_up():
	get_tree().quit()


func _on_button_2_button_up():
	if instance_panel:
		instance_panel.add_task() # Replace with function body.
