extends Node
class_name ComparisonModule


# List of valid commands
var commands: Array
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

@export var LisenBus : Node

signal kirim_result(pesan)
signal kirim_nilai(nilai)

#nyimpan hasil perbandingan
var result := "" :
	set(isi_result):

		result = isi_result
		kirim_result.emit(result)


# Default difficulty level (can be changed dynamically)
var difficulty_level: String = "easy"

func _ready() -> void:
	# Register commands and argument autocomplete for LimboConsole
	#Dari 'LisenBus' ke 'LimboConsole' ga ngerti gunanya buat apa tapi biarin dulu
	LisenBus.connect("recognized_string", on_speech_recognized)
	LimboConsole.register_command(on_speech_recognized, "lisen_compare", "compare speech to commands")
	LimboConsole.add_argument_autocomplete_source("lisen_compare", 1, func() -> Array[String]: return commands)
	LimboConsole.register_command(set_difficulty_level, "lisen_set_difficulty_level", "set difficulty level")
	LimboConsole.add_argument_autocomplete_source("lisen_set_difficulty_level", 1, func() -> Array: return difficulty_settings.keys())
	
	#'choice_selected' jika ingin commands hanya berisi dialog choice yang dipilih
	#'quiestion_shown' jika ingin commands berisi semua dialog choice dalam chapter
	Dialogic.get_subsystem("Choices").connect("choice_selected", handle_dialogic_signal)
	#Dialogic.get_subsystem("Choices").connect("question_shown", handle_dialogic_signal)
	#TODO: Add connection to speech recognition module

func handle_dialogic_signal(info: Dictionary):
	
	commands.clear()
	for i in info:
		#print(i)
		commands.push_back(info[i])
	#commands = info["choices"]
	print("isi_command : "+ str(commands) )

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
	if commands.has(speech):
		var score: int = calculate_score(0.0)
		print("Command recognized: " + speech)
		LimboConsole.print_line("Score: " + str(score))
		print("Score: " + str(score))
		result = "Command recognized: " + speech + "\n" + "Score: " + str(score)
		kirim_nilai.emit(score)
	else:
		# Check for the closest matching command using Levenshtein distance
		var closest_command: Array = find_closest_command(speech)
		if closest_command[0] != "":
			
			var error_percentage: float = calculate_error_percentage(speech, closest_command[0])
			var score: int = calculate_score(error_percentage)

			check_word_difference(speech, closest_command[0])
			LimboConsole.print_line("Error percentage: " + str(error_percentage) + "%")
			LimboConsole.print_line("Score: " + str(score))
			print("Error percentage: " + str(error_percentage) + "%")
			print("Score: " + str(score))
			Dialogic.get_subsystem("Choices").get_choice_button_node(closest_command[1]).emit_signal("pressed")
			result = "Command recognized: " + speech + "\n" + "Score: " + str(score)
			# result = "Error percentage: " + str(error_percentage) + "%" + "\n" + "Score: " + str(score)
			kirim_nilai.emit(score)
		else:
			LimboConsole.print_line("Command not recognized.")
			print("Command not recognized.")
			result = "Command not recognized."

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
	var distance: int = levenshtein_distance(speech, commands[3])
		
	if distance < min_distance:
		min_distance = distance
		closest_command = commands[3]
		
		closest_index = commands[1]
			
	var allowed_distance: float = difficulty_settings[difficulty_level]["allowed_distance"]
	return [closest_command, closest_index] if min_distance <= int(allowed_distance) else ["", -1]

# Calculate Levenshtein distance between two strings
func levenshtein_distance(s1: String, s2: String) -> int:
	var len_s1: int = s1.length()
	var len_s2: int = s2.length()
	print("mulai hitung")
	# Create a matrix to store distances
	var matrix: Array[Array] = []
	for i in range(len_s1 + 1):
		matrix.append([i])
	for j in range(1, len_s2 + 1):
		matrix[0].append(j)
	print("mulai copulate the maagtrix")
	# Populate the matrix
	for i in range(1, len_s1 + 1):
		for j in range(1, len_s2 + 1):
			var cost: int = 0 if s1[i - 1] == s2[j - 1] else 1
			matrix[i].append(min(
				matrix[i - 1][j] + 1, # Deletion
				matrix[i][j - 1] + 1, # Insertion
				matrix[i - 1][j - 1] + cost # Substitution
			))
	print("mau return")
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

	LimboConsole.print_line("Words comparison:")
	print("Words comparison:")
	for i in range(min(spoken_words.size(), command_words.size())):
		if spoken_words[i] != command_words[i]:
			LimboConsole.print_line("Word different: Spoken '" + spoken_words[i] + "', Expected '" + command_words[i] + "'")
			print("Word different: Spoken '" + spoken_words[i] + "', Expected '" + command_words[i] + "'")

	if spoken_words.size() != command_words.size():
		LimboConsole.print_line("Word count mismatch, additional/missing words detected.")
		print("Word count mismatch, additional/missing words detected.")


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
	print("isi_pesan : '"+ pesan +"'")
	
	#baris buat by pass comparison; 
	#emit result dari sini, comment fungsinya
	#kirim_result.emit("anggap berhasil")
	on_speech_recognized(pesan) 
