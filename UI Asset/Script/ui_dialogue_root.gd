extends CanvasLayer

@export var prompto : Control
@export var result : Control
#@export var result_text : Label
@export var lisen : ComparisonModule
@export var judul_level : Label
@export var skor_akhir : Control
@export var nilai_lulus : int
@onready var nilai : int = 0
@onready var nilai_level : Array[int]
@onready var indeks_nilai : int = 0
@export var container_kata_per_kata : Control

@export var tanda_baca := ".!?;。；？！"

@onready var choices : Dictionary
#@onready var tester = $Tester

@export var path : DialogicTimeline
#@onready var ngeteh = Dialogic.preload_timeline(path)

@onready var label_katakata : Array[Label] = []

var test_array : PackedStringArray = []
var lolos_lanjut : bool = false

var hasil_banding_kata : Dictionary

#buat TTS
var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = DisplayServer.tts_get_voices().pick_random()

# Called when the node enters the scene tree for the first time.
func _ready():
	#Dialogic.get_subsystem("Choices").connect("question_shown", simpan_data_choice) # ini sebenarnya ga perlu
	# untuk menampilkan promp pas pilih salah satu choice
	Dialogic.get_subsystem("Choices").connect("choice_selected", tampilkan_prompt)
	# ini buat TTS dan try again
	Dialogic.get_subsystem("Choices").connect("choice_selected", simpan_data_choice) 
	Dialogic.connect("event_handled", cek_even_jalan)
	var _dialogic = Dialogic.start(path)
	AudioServer.set_bus_mute(2,true)

func simpan_data_choice(info: Dictionary):
	choices = info
	
func tampilkan_prompt(info: Dictionary) -> void:
	print("Isi dialog tombol dipilih : "+info["text"])
	lisen.handle_new_commands(info)
	#NOTE<FAJAR>: Mode Awal
	#if !prompto.visible:
		#prompto.show()
	#
		#prompto.audio_stream_player.play()
		#prompto.speech_to_text.recording = true
	#
	#prompto.kata_terucap.partial_text = ""
	#prompto.kata_terucap.completed_text = ""
	
	#NOTE<FAJAR>: Percobaan mode indikator per-kata
	label_katakata.clear()
	if !prompto.visible:
		prompto.show()
	
		prompto.audio_stream_player.play()
		prompto.speech_to_text.recording = true
		
		prompto.kata_terucap.hide()
		prompto.kata_perkata.show()
		

		
		#prompto.kata_perkata.text = info["text"]
		
	
	if container_kata_per_kata.get_child_count() >0:
		for child in container_kata_per_kata.get_children():
			child.queue_free()
		
		pecah_kalimat(info["text"], container_kata_per_kata)
	
	prompto.kata_terucap.partial_text = ""
	prompto.kata_terucap.completed_text = ""
	
	#Baris buat debug comparison, langsung kasih teks tanpa lewat whisper	
	#test_array = info["text"].split(" ")
	#test_array[randi_range(0,test_array.size()-1)] = "deleu"
	#prompto.kata_terucap.bypass_pesan(" ".join(test_array))
	#TODO: 
	# cek apakah masalah comparison hanya karena string tertentu saja
	# atau dipengaruhi kondisi lain (computing power)

func _on_comparison_kirim_result(pesan):

	if pesan != "Command not recognized.":
		await get_tree().create_timer(1.0).timeout
		prompto.kata_terucap.partial_text = ""
		prompto.kata_terucap.completed_text = ""
		
		prompto.hide()
		result.show()
		if lolos_lanjut:
			result.tombol_lanjut.show()
		else:
			result.tombol_lanjut.hide()
		
		prompto.audio_stream_player.stop()
		prompto.speech_to_text.recording = false
		
		#TODO<FAJAR>: Mengganti hasil pesan nilai dengan kata yang masih keliru
		#result.teks_hasil.text = pesan
		var data_label_hasil : Array[Label]
		var index : int = 0
		
		if result.container_hasil_perkata.get_child_count() >0:
			for child in result.container_hasil_perkata.get_children():
				child.queue_free()
		
		for kata in hasil_banding_kata:
			data_label_hasil.append(bikin_label(kata))
			if hasil_banding_kata[kata]["Beda"]:
				data_label_hasil[index].self_modulate.a = 1.0
			result.container_hasil_perkata.add_child(data_label_hasil[index])
			
			index += 1

	else:
		prompto.kata_terucap.partial_text = ""
		prompto.kata_terucap.completed_text = ""


func _on_texture_button_3_button_up():
	Dialogic.get_subsystem("Choices").progress_dialog(choices)
	
	result.hide()
	Dialogic.handle_next_event()
	nilai_level[indeks_nilai] = nilai
	indeks_nilai += 1
	nilai = 0
	

func cek_even_jalan(even:DialogicEvent):
	print(even.event_name)
	if even.event_name == "Label":
		var isi_label = even.to_text().substr(even.event_name.length()+1)
		Dialogic.get_subsystem("Text").hide_textbox(true)
		judul_level.text = isi_label
	elif even.event_name == "End":
		skor_akhir.show()
	#print(Dialogic.current_timeline_events[Dialogic.current_event_idx])

func _on_texture_button_2_button_up():
		
	result.hide()
	tampilkan_prompt(choices)
	nilai = 0

func _on_texture_button_button_up():
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(choices['text'], voice_id)

func _on_comparison_kirim_nilai(nilai_kiriman : int):
	nilai = nilai_kiriman
	
	if nilai >= nilai_lulus:
		lolos_lanjut = true
	
func pecah_kalimat(kalimatnya:String,tempatnya:Control):
	var katakata : Array[String] = []
	
	
	for idx in range(0,kalimatnya.get_slice_count(" ")):
		katakata.append(kalimatnya.get_slice(" ", idx))

	for i in range(0,katakata.size()):
		var tanda_bacas = tanda_baca.split("", false)
		var grup_tanda : Array[int] = []
		var kata_bersih
		var kotor
		
		for j in tanda_bacas:
			
			var posisi_tanda = katakata[i].find(j)
			if posisi_tanda != -1:
				grup_tanda.append(posisi_tanda)
			
		if grup_tanda.size() != 0:
			kata_bersih = katakata[i].substr(0,grup_tanda.min())
			if i != 0:
				kata_bersih = " "+kata_bersih
			kotor = katakata[i].substr(grup_tanda.min(),grup_tanda.size())
			label_katakata.append(bikin_label(kata_bersih))
			label_katakata.append(bikin_label(kotor))
		else:
			kata_bersih = katakata[i]
			if i != 0:
				kata_bersih = " "+kata_bersih
			
			label_katakata.append(bikin_label(kata_bersih))
			#katakata.insert(i+1,katakata[i].substr(0,posisi_tanda-1)	
		
	for label_dibuat in label_katakata:
		tempatnya.add_child(label_dibuat)	
				
func bikin_label(isi : String) -> Label:
	var label_baru = Label.new()
	label_baru.text = isi
	label_baru.theme = load("res://UI Asset/Shader/theme_fajar/theme_fajar.tres")
	label_baru.theme_type_variation = "LabelTeksAwal"
	label_baru.self_modulate.a = 0.1
	return label_baru
				
				
			
			
#func _pisahkan_tanda_baca(kata: String):
	#
	#for special_character in special_characters:
		#while (message.find(special_character["start"]) != -1):
			#var begin_character := message.find(special_character["start"])
			#var end_character := message.find(special_character["end"])
			#if end_character != -1:
				#message = message.substr(0, begin_character) + message.substr(end_character + 1)


func _on_comparison_kirim_banding_kata(kata_kata):
	hasil_banding_kata = kata_kata # Replace with function body.
