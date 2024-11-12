extends HSlider

@export
var bus_name: String
var bus_index: int
#@onready var llc: Label = $"../../../../../Gameplay/MarginContainer/VBoxContainer/Listen Control/llc" as Label
#@onready var lla: Label = $"../../../../../Gameplay/MarginContainer/VBoxContainer/Listen Accuracy/lla" as Label

func _ready() -> void:
	#$lla.visible = false
	#$llc.visible = false
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(on_value_changed)
	
	value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)
	
func on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)


func _on_ila_pressed() -> void:
	#$lla.visible = true
	pass

func _on_ilc_pressed() -> void:
	#$llc.visible = true
	pass
