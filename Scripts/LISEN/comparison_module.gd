extends Node
class_name ComparisonModule


# List of valid commands
var commands: Array


var kalimat_bersih: String

@export var tanda_baca := ".!?;。；？！"

var regex = RegEx.new()
		
# Difficulty settings (thresholds, etc.) in a dictionary
var difficulty_settings: Dictionary = {
	"easy": {
		"allowed_distance": 5.0, # Levenshtein distance tolerance
		"score_multiplier": 1.0 # Score multiplier for difficulty
	},
	"medium": {
		"allowed_distance": 3.0,
		"score_multiplier": 1.5
	},
	"hard": {
		"allowed_distance": 1.0,
		"score_multiplier": 2.0
	}
}

#@export var LisenBus : Node

signal kirim_result(pesan, nilai: int, kata_kata : Dictionary)
signal kirim_nilai(nilai)
signal kirim_banding_kata(kata_kata : Dictionary)



#nyimpan hasil perbandingan
#var result := "" :
	#set(isi_result):
#
		#result = isi_result
		#kirim_result.emit(result)
var result := ""

# Default difficulty level (can be changed dynamically)
@export var difficulty_level: String = "easy"

func _ready() -> void:
	regex.compile(r'^(.+)(?=.*\1)')
	# Register commands and argument autocomplete for LimboConsole
	#Dari 'LisenBus' ke 'LimboConsole' ga ngerti gunanya buat apa tapi biarin dulu
	#LisenBus.connect("recognized_string", on_speech_recognized)
	#LimboConsole.register_command(on_speech_recognized, "lisen_compare", "compare speech to commands")
	#LimboConsole.add_argument_autocomplete_source("lisen_compare", 1, func() -> Array[String]: return commands)
	#LimboConsole.register_command(set_difficulty_level, "lisen_set_difficulty_level", "set difficulty level")
	#LimboConsole.add_argument_autocomplete_source("lisen_set_difficulty_level", 1, func() -> Array: return difficulty_settings.keys())
	
	#'choice_selected' jika ingin commands hanya berisi dialog choice yang dipilih
	#'quiestion_shown' jika ingin commands berisi semua dialog choice dalam chapter
	#Dialogic.get_subsystem("Choices").connect("choice_selected", handle_dialogic_signal)
	#Dialogic.get_subsystem("Choices").connect("question_shown", handle_dialogic_signal)
	#TODO: Add connection to speech recognition module

#func handle_dialogic_signal(info: Dictionary):
func handle_new_commands(info: Dictionary):
	
	commands.clear()
	
	for i in info:
		#print(i)
		commands.push_back(info[i])
	
	#NOTE<FAJAR>: membersihkan kalimat yang dibandingkan
	kalimat_bersih = proses_kalimat(commands[3])
	#commands = info["choices"]

	
	
	#NOTE<FAJAR>: Hapus comment jika ingin tahu isi Dictionary info (data opsi terpilih dari Dialogic)
	#print("isi_command : "+ str(commands) )

# Function to change difficulty level
func set_difficulty_level(level: String) -> void:
	# Check if the selected difficulty level is valid
	if difficulty_settings.has(level):
		difficulty_level = level
		print("Difficulty level set to: " + difficulty_level)
	else:
		print("Invalid difficulty level")

# Function to handle speech recognition and comparison
func on_speech_recognized(speech: String) -> void:
	# Check for an exact match in the command list
	#print(regex.get_pattern() + " DAN " + str(regex.search(speech)))
	#if regex.search(speech) != null:
		##print("regex jalan")
		#speech = regex.search(speech).get_string()
		#
	##print(speech)	
	#
	#for i in tanda_baca:
		#if speech.contains(i):
			#var sample_1 = hapus_spasi_awal(speech.get_slice(i,0))
			#var sample_2 = hapus_spasi_awal(speech.get_slice(i,1))
			#if sample_1 == sample_2:
				#speech = sample_1
				#break
				#
	##print(speech)
	var hasil_kata : Dictionary = {}
	
	if commands.has(speech):
		var score: int = calculate_score(0.0)
		#print("Command recognized: " + speech)
		#LimboConsole.print_line("Score: " + str(score))
		print("Score: " + str(score))
		result = "Command recognized: " + speech + "\n" + "Score: " + str(score)
		hasil_kata = check_word_difference_levenshtein_bersih(speech, commands[3])
		kirim_result.emit(result, score, hasil_kata)
	else:
		# Check for the closest matching command using Levenshtein distance
		var closest_command: Array = find_closest_command(speech)
		if closest_command[0] != "":
			
			var error_percentage: float = round_to_dec(calculate_error_percentage_levenshtein_bersih(speech, closest_command[0]),2)
			var score: int = calculate_score(error_percentage)

			hasil_kata = check_word_difference_levenshtein_bersih(speech, closest_command[0])
			#LimboConsole.print_line("Error percentage: " + str(error_percentage) + "%")
			#LimboConsole.print_line("Score: " + str(score))
			print("Error percentage: " + str(error_percentage) + "%")
			print("Score: " + str(score))
			#Dialogic.get_subsystem("Choices").get_choice_button_node(closest_command[1]).emit_signal("pressed")
			result = "Error percentage: " + str(error_percentage) + "%" + "\n" + "Score: " + str(score)
			kirim_result.emit(result, score, hasil_kata)
		else:
			#LimboConsole.print_line("Command not recognized.")
			print("Command not recognized.")
			result = "Command not recognized."
			kirim_result.emit(result, 0, {})

# Find the closest matching command using Levenshtein distance
func find_closest_command(speech: String) -> Array:
	var min_distance: float = INF
	var closest_command: String = ""
	var closest_index: int = -1
	
	#Pada kasus 'choice_selected' isi commands Array bukan dictionary
	#Tapi array berisi info dari choice yang dipilih
	#commands[3] --> isi teks choice
	#commands[1] --> indeks choice
	#for command in commands:
		#var distance: int = levenshtein_distance(speech, command.text)
		#
		#if distance < min_distance:
			#min_distance = distance
			#closest_command = command.text
			#
			#closest_index = command.button_index
	var distance: int = levenshtein_distance(speech, kalimat_bersih)
		
	if distance < min_distance:
		min_distance = distance
		closest_command = commands[3]
		closest_index = commands[1]
	
	var allowed_distance: float = difficulty_settings[difficulty_level]["allowed_distance"]*4
	return [closest_command, closest_index] if min_distance <= int(allowed_distance) else ["", -1]
	
# Find the closest matching command using Levenshtein distance
func find_closest_word(source: Array, speech: String, skips: Array) -> Array:
	var min_distance: float = INF
	var closest_word: String = ""
	var closest_index: int = -1
	
	for i in range(0,source.size()):
		if !skips.has(i):
			var distance: int = levenshtein_distance(source[i], speech)
			
			if distance < min_distance:
				min_distance = distance
				closest_word = source[i]
				closest_index = i
	
	var allowed_distance: float = 1.0#difficulty_settings[difficulty_level]["allowed_distance"]
	return [closest_word, closest_index] if min_distance <= int(allowed_distance) else ["", -1]
	


# Calculate Levenshtein distance between two strings
func levenshtein_distance(s1: String, s2: String) -> int:
	var len_s1: int = s1.length()
	var len_s2: int = s2.length()
	#print("mulai hitung")
	# Create a matrix to store distances
	var matrix: Array[Array] = []
	for i in range(len_s1 + 1):
		matrix.append([i])
	for j in range(1, len_s2 + 1):
		matrix[0].append(j)
	#print("mulai copulate the maagtrix")
	# Populate the matrix
	for i in range(1, len_s1 + 1):
		for j in range(1, len_s2 + 1):
			var cost: int = 0 if s1[i - 1] == s2[j - 1] else 1
			matrix[i].append(min(
				matrix[i - 1][j] + 1, # Deletion
				matrix[i][j - 1] + 1, # Insertion
				matrix[i - 1][j - 1] + cost # Substitution
			))
	#print("mau return")
	
	#if matrix[len_s1][len_s2] !=0.0:			
		#print("speech :" + str(s1))
		#print("commands :" + str(s2))
		#print("distance :" + str(matrix[len_s1][len_s2]))
	#else:
		#print("no prob")
	#
	
	return matrix[len_s1][len_s2]

# Calculate error percentage based on incorrect words
func calculate_error_percentage(spoken: String, command: String) -> float:
	var spoken_words: PackedStringArray = spoken.split(" ")
	var command_words: PackedStringArray = command.split(" ")
	var incorrect_count: int = 0
	
	# Compare words between spoken and command
	for i in range(min(spoken_words.size(), command_words.size())):
		if spoken_words[i] != command_words[i]:
			incorrect_count += 1

	# Account for extra or missing words
	incorrect_count += abs(spoken_words.size() - command_words.size())

	var total_words: int = max(spoken_words.size(), command_words.size())
	return float(incorrect_count) / float(total_words) * 100.0

# Calculate error percentage based on incorrect words but cleaned
func calculate_error_percentage_bersih(spoken: String, command: String) -> float:
	var spoken_words: PackedStringArray = spoken.split(" ")
	var command_words: PackedStringArray = command.split(" ")
	var incorrect_count: int = 0
	
	var spoken_words_test: PackedStringArray = proses_kalimat(spoken).split(" ") 
	var command_words_test: PackedStringArray = kalimat_bersih.split(" ")
	
	# Compare words between spoken and command
	for i in range(min(spoken_words_test.size(), command_words_test.size())):
		if spoken_words_test[i] != command_words_test[i]:
			incorrect_count += 1

	# Account for extra or missing words
	incorrect_count += abs(spoken_words.size() - command_words.size())

	var total_words: int = max(spoken_words.size(), command_words.size())
	return float(incorrect_count) / float(total_words) * 100.0

func calculate_error_percentage_levenshtein_bersih(spoken: String, command: String) -> float:
	var spoken_words: PackedStringArray = spoken.split(" ")
	var command_words: PackedStringArray = command.split(" ")
	var incorrect_count: int = 0
	
	var spoken_words_test: PackedStringArray = proses_kalimat(spoken).split(" ") 
	var command_words_test: PackedStringArray = kalimat_bersih.split(" ")
	
	var allowed_distance: float = difficulty_settings["hard"]["allowed_distance"]
	# Compare words between spoken and command
	for i in range(min(spoken_words_test.size(), command_words_test.size())):
		
		if levenshtein_distance(spoken_words_test[i], command_words_test[i]) > allowed_distance:
			incorrect_count += 1

	# Account for extra or missing words
	incorrect_count += abs(spoken_words.size() - command_words.size())

	var total_words: int = max(spoken_words.size(), command_words.size())
	return float(incorrect_count) / float(total_words) * 100.0

# Calculate score based on error percentage and difficulty
func calculate_score(error_percentage: float) -> int:
	if error_percentage == 0.0:
		# Perfect match gets a 100% score, no multiplier applied
		return 100 * difficulty_settings[difficulty_level]["score_multiplier"]

	# Start with a base score and reduce it by error percentage
	var base_score: int = max(0, 100 - int(error_percentage))

	# Apply the score multiplier based on the difficulty level
	var score_multiplier: float = difficulty_settings[difficulty_level]["score_multiplier"]
	return int(base_score * score_multiplier)

# Optional: Compare each word between spoken and command
func check_word_difference(spoken: String, command: String) -> void:
	var spoken_words: PackedStringArray = spoken.split(" ")
	var command_words: PackedStringArray = command.split(" ")
	var hasil_banding_kata: Dictionary = {}
	
	#LimboConsole.print_line("Words comparison:")
	print("Words comparison:")
	for i in range(command_words.size()):
		var beda = false
		if spoken_words[i] != command_words[i]:
			#LimboConsole.print_line("Word different: Spoken '" + spoken_words[i] + "', Expected '" + command_words[i] + "'")
			print("Word different: Spoken '" + spoken_words[i] + "', Expected '" + command_words[i] + "'")
			beda = true
			#print(spoken_words[i].similarity(command_words[i]))
		
		hasil_banding_kata[command_words[i]]= { "Hasil" : spoken_words[i], "Beda" : beda }
		
	if spoken_words.size() != command_words.size():
		#LimboConsole.print_line("Word count mismatch, additional/missing words detected.")
		print("Word count mismatch, additional/missing words detected.")
	
	#kirim_banding_kata.emit(hasil_banding_kata)

func check_word_difference_bersih(spoken: String, command: String) -> void:
	var spoken_words: PackedStringArray = spoken.split(" ")
	var command_words: PackedStringArray = command.split(" ")
	var hasil_banding_kata: Dictionary = {}
	
	var spoken_words_test: PackedStringArray = proses_kalimat(spoken).split(" ") 
	var command_words_test: PackedStringArray = proses_kalimat(command).split(" ")
	
	# Compare words between spoken and command
	#LimboConsole.print_line("Words comparison:")
	print("Words comparison:")
	for i in range(min(spoken_words_test.size(), command_words_test.size())):
		var beda = false
		if spoken_words_test[i] != command_words_test[i]:
			#LimboConsole.print_line("Word different: Spoken '" + spoken_words[i] + "', Expected '" + command_words[i] + "'")
			print("Word different: Spoken '" + spoken_words[i] + "', Expected '" + command_words[i] + "'")
			beda = true
			#print(spoken_words[i].similarity(command_words[i]))
		
		hasil_banding_kata[command_words[i]]= { "Hasil" : spoken_words[i], "Beda" : beda }
		
	if spoken_words.size() != command_words.size():
		#LimboConsole.print_line("Word count mismatch, additional/missing words detected.")
		print("Word count mismatch, additional/missing words detected.")
	
	#kirim_banding_kata.emit(hasil_banding_kata)

func check_word_difference_levenshtein_bersih(spoken: String, command: String) -> Dictionary:
	var spoken_words: PackedStringArray = spoken.split(" ")
	var command_words: PackedStringArray = command.split(" ")
	var hasil_banding_kata: Dictionary = {}
	
	var spoken_words_test: PackedStringArray = proses_kalimat(spoken).split(" ") 
	var command_words_test: PackedStringArray = kalimat_bersih.split(" ")
	
	
	
	for kata in command_words:
		hasil_banding_kata[kata] = { "Hasil" :"missing", "Beda" : true }
	
	
	#var allowed_distance: float = difficulty_settings[difficulty_level]["allowed_distance"]
	# Compare words between spoken and command
	#LimboConsole.print_line("Words comparison:")
	print("Words comparison:")
	var skips = []
	for i in range(spoken_words.size()):
		var beda = true
		
		if i < command_words.size() && command_words_test[i] == spoken_words_test[i]:
			skips.append(i)
			beda = false
			hasil_banding_kata[command_words[i]]= { "Hasil" : spoken_words[i], "Beda" : beda }
			#print("Spoken '" + spoken_words[i] + "', Expected '" + command_words[i] + "'")
		else:
			if skips.is_empty():
				var closest_word := find_closest_word(command_words_test, spoken_words_test[i],skips)
				#if levenshtein_distance(spoken_words_test[i], command_words_test[i]) > allowed_distance:
				if closest_word[1] != -1:
					#LimboConsole.print_line("Word different: Spoken '" + spoken_words[i] + "', Expected '" + command_words[i] + "'")
					#print("Word different: Spoken '" + spoken_words[i] + "', Expected '" + command_words[i] + "'")
					skips.append(closest_word[1])
					print("ARGH")
					beda = false
					hasil_banding_kata[command_words[closest_word[1]]]= { "Hasil" : spoken_words[i], "Beda" : beda }
			elif command_words_test.size() > skips[0]+i:
				if levenshtein_distance(command_words_test[skips[0]+i], spoken_words_test[i]) <= 1.0:
					beda = false
				else:
					beda = true
				skips.append(skips[0]+i)
				hasil_banding_kata[command_words[skips[0]+i]]= { "Hasil" : spoken_words[i], "Beda" : beda }
				#print(spoken_words[i].similarity(command_words[i]))\

	for kata in hasil_banding_kata:	
		print("Spoken '" + hasil_banding_kata[kata]["Hasil"] + "', Expected '" + kata + "'")
		
	if spoken_words.size() != command_words.size():
		#LimboConsole.print_line("Word count mismatch, additional/missing words detected.")
		
		print("Word count mismatch, additional/missing words detected.")
	
	return hasil_banding_kata
	
	#kirim_banding_kata.emit(hasil_banding_kata)
	
#func _on_speech_to_text_transcribed_msg(is_partial, new_text):
	#for i in commands:
		#print(i.text)
	#if is_partial == true:
		
		#completed_text += new_text
		#partial_text = ""
		#on_speech_recognized(completed_text)
	#else:
		#if new_text!="":
			#partial_text = new_text


func _on_rich_text_label_kirim_teks(pesan):

	if pesan.begins_with(" "):

		pesan = pesan.substr(1)
	
	#NOTE<FAJAR>: Hapus comment jika ingin tahu isi pesan yang terkirim dari label
	#print("isi_pesan : '"+ pesan +"'")
	
	#baris buat by pass comparison; 
	#emit result dari sini, comment fungsinya
	#kirim_result.emit("anggap berhasil")
	on_speech_recognized(pesan) 

func proses_kalimat(kalimatnya:String) -> String:
	
	var katakata : Array[String] = []
	var kalimat_new : String = ""
	
	kalimatnya = kalimatnya.to_lower()
	
	for idx in range(0,kalimatnya.get_slice_count(" ")):
		katakata.append(kalimatnya.get_slice(" ", idx))

	for i in range(0,katakata.size()):
		var tanda_bacas = tanda_baca.split("", false)
		var grup_tanda : Array[int] = []
		var kata_bersih
		
		for j in tanda_bacas:
			var posisi_tanda = katakata[i].find(j)
			if posisi_tanda != -1:
				grup_tanda.append(posisi_tanda)
			
		if grup_tanda.size() != 0:
			kata_bersih = katakata[i].substr(0,grup_tanda.min())
		else:
			kata_bersih = katakata[i]
		
		if i != 0:
			kalimat_new += " "+kata_bersih
		else:
			kalimat_new += kata_bersih
	
	return kalimat_new
			#katakata.insert(i+1,katakata[i].substr(0,posisi_tanda-1)	
func round_to_dec(num:float, digit:int):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func hapus_spasi_awal(kalimat: String) -> String:
	var sample = kalimat
	if sample.begins_with(" "):
		sample = sample.substr(1)
	
	return sample
