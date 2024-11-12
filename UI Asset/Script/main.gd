extends Control

var Coins_value = 0
@onready var coin_values: Label = %CoinValues
@onready var Music_Bus_ID = AudioServer.get_bus_index("Music")
@onready var SFX_Bus_ID = AudioServer.get_bus_index("SFX")
const SaveMaterial = preload("res://UI Asset/Script/SaveMaterial.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coin_values.text = str(Coins_value)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
  

func _on_grant_coin_button_pressed() -> void:
	pass


func _on_decrease_coin_button_pressed() -> void:
	Coins_value -= 10
	print(Coins_value)
	coin_values.text = str(Coins_value)


func _on_reset_coin_button_pressed() -> void:
	Coins_value = 0
	print(Coins_value)
	coin_values.text = str(Coins_value)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(Music_Bus_ID, linear_to_db(value))
	AudioServer.set_bus_mute(Music_Bus_ID, value < 0.05)



func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_Bus_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_Bus_ID, value < 0.05)
