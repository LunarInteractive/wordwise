# Mengatur data dan tampilan UI untuk proses voice recognition di tiap level
# Dialogic dipanggil dari sini
# Mengambil data Choices terpilih dan menyimpannya, 
# lalu mengirim data kalimat terpilih ke ComparisonModule,
# dan menjalankan CaptureStreamToText dari Temporary Prompt.

# Saat CaptureStreamToText mendeteksi kalimat, langsung di kirim ke sini,
# lalu menampilkan kalimat di label Temporary Prompt,
# sambil mengirim kalimat untuk dinilai di ComparisonModul

# Setelah keluar nilai, panel hasil muncul.
# Ada data nilai disimpan, tapi tidak ditampilkan

# NOTE<FAJAR>: Pengucapan harus benar satu kalimat. 
# Potongan kalimat benar bisa terdeteksi.
# Misal: 
#	Soal: Good Morning! How are you today 
#	Pengucapan: How are you today
#	Hasil: How are you today 
# namun salah urutan kata dianggap salah
# Misal: 
#	Soal: You're welcome! Good Bye
#	Pengucapan: You are welcome! Good Bye
#	Hasil : 
# Soal harus disesuaikan dengan kemampuan 
# modul Speech-to-Text yang digunakan.
#
# Pengucapan case insensitive, tanda baca ga ngaruh

extends CanvasLayer

# Variabel elemen-elemen UI

# Temporary Prompt dan children nya
@export var temp_prompt : Control
@onready var lisen : ComparisonModule = temp_prompt.comparison
# Data pembantu pengisian kata untuk label Temporary Prompt
var completed_text := ""
var partial_text := ""

# Panel hasil dan children nya
# Hanya menampilkan kata yang dipilih dan ditandai kata yang salahnya
# Serta tombol-tombol
@export var panel_hasil : Control
# Data kata-kata pada panel hasil
var hasil_banding_kata : Dictionary

# Elemen UI lainnya
@export var judul_level : Label
@export var panel_skor_akhir : Control

# Data-data terkait nilai
@export var nilai_lulus : int
@onready var nilai : int = 0
@onready var nilai_level : Array[int] =[]
@onready var indeks_nilai : int = 0
@onready var lolos_lanjut : bool = false

# Alamat resource Timeline Dialogic (Chapter) yang dipanggil
@export var path : DialogicTimeline

# Data opsi kata terpilih
@onready var choices : Dictionary

# Daftar tanda baca untuk pembersihan kalimat
@export var tanda_baca := ".!?;。；？！"

# Data untuk fitur Text to Speech
var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = DisplayServer.tts_get_voices().pick_random()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Untuk menampilkan Temporary Prompt saat pilih salah satu choice
	Dialogic.get_subsystem("Choices").connect("choice_selected", tampilkan_prompt)
	
	# Menyimpan data choice untuk text to Speech dan Coba Lagi setelah hasil keluar
	#Dialogic.get_subsystem("Choices").connect("choice_selected", simpan_data_choice) 
	
	# Debug untuk mendeteksi event Dialogic yang sedang jalan
	Dialogic.connect("event_handled", cek_even_jalan)
	
	# Panggil Dialogic
	var _dialogic = Dialogic.start(path)
	
	# Agar mic tidak mengeluarkan suara (hanya input)
	AudioServer.set_bus_mute(2,true)
	
	# Debug memastikan thread pada Capture Stream to Text tidak jalan saat pertama load
	print("is playing? " + str(temp_prompt.speech_to_text.thread.is_alive()))
	print("is ada? " + str(temp_prompt.speech_to_text.thread))
	
## Menyimpan data kalimat terpilih
#func simpan_data_choice(info: Dictionary):
	#choices = info

# Menampilkan Temporary Prompt
func tampilkan_prompt(info: Dictionary) -> void:
	
	# Update label
	partial_text = ""
	completed_text = ""
	
	update_text()
	
	print("Isi dialog tombol dipilih : "+info["text"])
	choices = info
	# Kirim ke ComparisonModule
	lisen.handle_new_commands(info)

	#if temp_prompt.speech_to_text.process_mode == ProcessMode.PROCESS_MODE_DISABLED:
		#temp_prompt.speech_to_text.process_mode = ProcessMode.PROCESS_MODE_INHERIT

	# Tampilkan
	if !temp_prompt.visible:
		temp_prompt.show()
		
		#if !temp_prompt.audio_stream_player.playing:
		temp_prompt.audio_stream_player.play()
		
		#if !temp_prompt.speech_to_text.recording:
		temp_prompt.speech_to_text.recording = true
	


# Menerima pesan dari ComparisonModule
func _on_comparison_kirim_result(pesan, nilai_kiriman, kata_kata) -> void:
	#temp_prompt.audio_stream_player.stop()
	#temp_prompt.speech_to_text.recording = false
	
	nilai = nilai_kiriman
	
	if nilai >= nilai_lulus:
		lolos_lanjut = true
	else:
		lolos_lanjut = false
		
	hasil_banding_kata = kata_kata
	
	if pesan != "Command not recognized.":
		pesan_terkirim = true
		await get_tree().create_timer(0.5).timeout
		#partial_text = ""
		#completed_text = ""
		#
		#update_text()
		
		# Menyembunyikan Prompt menampilkan Hasil
		if !panel_hasil.visible:
			temp_prompt.hide()
			panel_hasil.show()
			if lolos_lanjut:
				panel_hasil.tombol_lanjut.show()
			else:
				panel_hasil.tombol_lanjut.hide()

			# Menghentikan voice recognition agar tidak memberatkan		
			#temp_prompt.audio_stream_player.stop()
			#temp_prompt.speech_to_text.recording = false
			#if temp_prompt.audio_stream_player.playing:
				#temp_prompt.audio_stream_player.playing = false
			temp_prompt.audio_stream_player.stop()
			
			#if temp_prompt.speech_to_text.recording:
			temp_prompt.speech_to_text.recording = false

			# Menampilkan kata-kata hasil
			
			panel_hasil.teks_hasil.text = ""
			
			print("hasil isinya apa aja: " + str(hasil_banding_kata))
			print("choices isinya apa:" + choices['text'])
			
			for idx in range(0,choices['text'].get_slice_count(" ")):
				#choices_array.append(choices['text'].get_slice(" ", idx))
			
			#for kata in hasil_banding_kata:
				var isi_kata = choices['text'].get_slice(" ", idx)
				if idx != 0:
					isi_kata = " "+isi_kata
				
				if idx < hasil_banding_kata.keys().size():
					var teks_banding = hasil_banding_kata.keys()[idx]
					if hasil_banding_kata[teks_banding]["Beda"]:
						panel_hasil.teks_hasil.text += "[color=#828282]" + isi_kata + "[/color]"
					else:
						panel_hasil.teks_hasil.text += "[color=#ffc83a]" + isi_kata + "[/color]"
				else:
					panel_hasil.teks_hasil.text += "[color=#828282]" + isi_kata + "[/color]"
					
				panel_hasil.teks_hasil.text = "[center]"+panel_hasil.teks_hasil.text+"[/center]"
		pesan_terkirim = false
	else:
		pesan_terkirim = false
		# Jika ComparisonModule bilang kalimat tidak valid, kosongkan label di Prompt
		partial_text = ""
		completed_text = ""
		
		update_text()
		#if !temp_prompt.audio_stream_player.playing:
			#temp_prompt.audio_stream_player.play()
		
		#if !temp_prompt.speech_to_text.recording:
			#temp_prompt.speech_to_text.recording = true
	#print("kirim? -> " + str(pesan_terkirim))
	#pesan_terkirim = false
# Tombol lanjut pada Panel Hasil (muncul jika lulus)
func _on_texture_button_3_button_up():
	Dialogic.get_subsystem("Choices").progress_dialog(choices)
	
	panel_hasil.hide()
	Dialogic.handle_next_event()
	nilai_level.append(nilai)
	indeks_nilai += 1
	nilai = 0
	
# Tombol coba bicara lagi pada Panel Hasil
func _on_texture_button_2_button_up():
		
	
	#print("thread mati?" + str(temp_prompt.speech_to_text.thread.is_alive()))
	tampilkan_prompt(choices)
	panel_hasil.hide()
	nilai = 0

# Tombol Text to Speech pada Panel Hasil
func _on_texture_button_button_up():
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(choices['text'], voice_id["id"])

# Saat menerima nilai dari ComparisonModul, memutuskan status kelulusan
func _on_comparison_kirim_nilai(nilai_kiriman : int):
	nilai = nilai_kiriman
	
	if nilai >= nilai_lulus:
		lolos_lanjut = true
	else:
		lolos_lanjut = false

# Menyimpan data perbandingan kata dari ComparisonModule
func _on_comparison_kirim_banding_kata(kata_kata):
	hasil_banding_kata = kata_kata # Replace with function body.


var pesan_terkirim := false
# Saat CaptureStreamToText mengirimkan kalimat
# update label Prompt dan kirim ke ComparisonMOdule
func _on_speech_to_text_transcribed_msg(is_partial, new_text):
	
	#if completed_text == new_text || new_text == "":
		#pass
	
	if pesan_terkirim:
		print("sabar")
		return
	
	for i in tanda_baca:
		if new_text.contains(i):
			var sample_1 = hapus_spasi_awal(new_text.get_slice(i,0))
			var sample_2 = hapus_spasi_awal(new_text.get_slice(i,1))
			if sample_1 == sample_2 && sample_1 != "":
				new_text = sample_1
				break
	
	if !is_partial:
		completed_text += new_text
		partial_text = ""
		
		if !panel_hasil.visible && !pesan_terkirim:
			print("pesan dikirim ke comparison: [" + completed_text +"]")	
			lisen._on_rich_text_label_kirim_teks(completed_text)
			#pesan_terkirim = true
			#completed_text = ""
			
	else:
		if new_text!="":
			partial_text = new_text

	update_text()
	completed_text = ""

# Update label Prompt dengan formatting BBCODE
func update_text():
		
	temp_prompt.kata_terucap.text = "[center][color=ffc83a]" + completed_text + "[/color][color=8282]" + partial_text + "[/color][/center]"


# Memeriksa event Dialogic
func cek_even_jalan(even:DialogicEvent):
	
	#NOTE<FAJAR>: Hapus comment jika ingin tahu tipe event Dialogic yang sedang jalan
	#print(even.event_name)
	
	if even.event_name == "Label":
		var isi_label = even.to_text().substr(even.event_name.length()+1)
		Dialogic.get_subsystem("Text").hide_textbox(true)
		judul_level.text = isi_label
	elif even.event_name == "End":
		panel_skor_akhir.show()

func hapus_spasi_awal(kalimat: String) -> String:
	var sample = kalimat
	if sample.begins_with(" "):
		sample = sample.substr(1)
	
	return sample
