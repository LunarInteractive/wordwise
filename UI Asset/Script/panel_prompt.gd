extends PanelContainer
@onready var audio_stream_player = $MarginContainer/VBoxContainer/AudioStreamPlayer
@onready var speech_to_text = $MarginContainer/VBoxContainer/SpeechToText

@onready var kata_terucap = $MarginContainer/VBoxContainer/TeksJawaban/KataTerucap
@onready var kata_perkata = $MarginContainer/VBoxContainer/TeksJawaban/KataPerkata/KataTerisi

# Isinya variable children agar mudah diakses
#TODO: menambahkan tombol close
