extends VBoxContainer

const RECORD_BUS: String = "Record"
var bus_layout: AudioBusLayout = load("res://samples/godot_whisper/sample_bus_layout.tres")

@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var mic_player: AudioStreamPlayer = $MicPlayer
@onready var audio_to_text: CaptureStreamToText = $CaptureStreamToText
@onready var transcribe_label: RichTextLabel = $Panel/Label


func _init():
	AudioServer.set_bus_layout(bus_layout)


func _ready():
	setup_audio_buses()
	audio_to_text.transcribed_msg.connect(transcribe_label._on_capture_stream_to_text_transcribed_msg)


func setup_audio_buses():
	audio_player.bus = RECORD_BUS
	mic_player.bus = RECORD_BUS