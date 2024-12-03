# Isinya variable children agar mudah diakses
#TODO: menambahkan tombol close

extends PanelContainer
@export var audio_stream_player : AudioStreamPlayer
@export var speech_to_text : CaptureStreamToText

@export var kata_terucap : RichTextLabel
@export var kata_perkata : HBoxContainer

@export var comparison : ComparisonModule
