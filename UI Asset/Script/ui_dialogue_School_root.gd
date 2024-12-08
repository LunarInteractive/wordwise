extends CanvasLayer

@export var prompto : Control
@export var result : Control
@export var result_text : Label
@export var lisen : ComparisonModule
@export var judul_level : Label
@export var skor_akhir : Control

@onready var choices : Dictionary
#@onready var tester = $Tester

@export var path : DialogicTimeline
#@onready var ngeteh = Dialogic.preload_timeline(path)

var test_array : PackedStringArray = []
var lolos_lanjut : bool = false

#buat TTS
var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[0]

var chapter = GlobalVariable.Chapter
var level = GlobalVariable.level
var dialogue = GlobalVariable.get_dialogue_by_chapter_and_level(chapter, level)
# Called when the node enters the scene tree for the first time.
func _ready():
	if dialogue:
		print(dialogue)
	#Dialogic.get_subsystem("Choices").connect("question_shown", simpan_data_choice) # ini sebenarnya ga perlu
	# untuk menampilkan promp pas pilih salah satu choice
	Dialogic.get_subsystem("Choices").connect("choice_selected", tampilkan_prompt)
	# ini buat TTS dan try again
	Dialogic.get_subsystem("Choices").connect("choice_selected", simpan_data_choice) 
	Dialogic.connect("event_handled", cek_even_jalan)
	setup_judul()
	setup_dialogic()
	AudioServer.set_bus_mute(2,true)

func setup_dialogic():
	var events : Array = dialogue.split('\n')

	var timeline : DialogicTimeline = DialogicTimeline.new()
	timeline.events = events
	Dialogic.start(timeline)

func setup_judul():
	var judul_text = "Level " + level
	judul_level.text = judul_text

func simpan_data_choice(info: Dictionary):
	choices = info
	
func tampilkan_prompt(info: Dictionary) -> void:
	print("Isi dialog tombol dipilih : "+info["text"])
	if !prompto.visible:
		prompto.show()
	
		prompto.audio_stream_player.play()
		prompto.speech_to_text.recording = true
	
	prompto.rich_text_label.partial_text = ""
	prompto.rich_text_label.completed_text = ""

	
	#Baris buat debug comparison, langsung kasih teks tanpa lewat whisper	
	#test_array = info["text"].split(" ")
	#test_array[randi_range(0,test_array.size()-1)] = "deleu"
	#prompto.rich_text_label.bypass_pesan(" ".join(test_array))
	#TODO: 
	# cek apakah masalah comparison hanya karena string tertentu saja
	# atau dipengaruhi kondisi lain (computing power)

func _on_comparison_kirim_result(pesan):

	if pesan != "Command not recognized.":
		await get_tree().create_timer(1.0).timeout
		prompto.rich_text_label.partial_text = ""
		prompto.rich_text_label.completed_text = ""
		
		prompto.hide()
		result.show()
		if lolos_lanjut:
			result.tombol_lanjut.show()
		else:
			result.tombol_lanjut.hide()
		
		prompto.audio_stream_player.stop()
		prompto.speech_to_text.recording = false
	
		result_text.text = pesan

	else:
		prompto.rich_text_label.partial_text = ""
		prompto.rich_text_label.completed_text = ""


func _on_texture_button_3_button_up():
	Dialogic.get_subsystem("Choices").progress_dialog(choices)
	
	result.hide()
	Dialogic.handle_next_event()

func cek_even_jalan(even:DialogicEvent):
	print(even.event_name)
	if even.event_name == "Label":
		Dialogic.get_subsystem("Text").hide_textbox(true)
	elif even.event_name == "End":
		skor_akhir.show()
	#print(Dialogic.current_timeline_events[Dialogic.current_event_idx])

func _on_texture_button_2_button_up():
		
	result.hide()
	tampilkan_prompt(choices)

func _on_texture_button_button_up():
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(choices['text'], voice_id) # Replace with function body.

func _on_comparison_kirim_nilai(nilai):
	if nilai >= 80:
		lolos_lanjut = true# Replace with function body.
