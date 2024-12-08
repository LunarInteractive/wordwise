extends Node

@onready var ClassCode = ""

@onready var kode_level = ""
@onready var Chapter = ""
@onready var level = ""

# Dictionary to store dialogue data
var dialogue_data_map = {}

# Store all dialogue data
func set_all_dialogue_data(dialogues: Array) -> void:
	dialogue_data_map.clear()
	for dialogue in dialogues:
		if dialogue.has("dialogue_data"):
			var dialogue_text = dialogue["dialogue_data"]
			dialogue_data_map[dialogue_text] = dialogue_text  # Store just the dialogue text
	print("All dialogue data has been set.")

# Retrieve a specific dialogue by searching in the keys
func get_dialogue_by_key(search_text: String) -> String:
	for key in dialogue_data_map.keys():
		if key.find(search_text) != -1:  # Check if search_text is a substring of the key
			return dialogue_data_map[key]
	return "Dialogue not found for: " + search_text

# Store all dialogue data with chapter and level as keys
func set_all_dialogue_data_spesific(dialogues: Array) -> void:
	dialogue_data_map.clear()
	for dialogue in dialogues:
		if dialogue.has("chapter") and dialogue.has("level") and dialogue.has("dialogue_data"):
			var chapter = dialogue["chapter"]
			var level = dialogue["level"]
			var dialogue_text = dialogue["dialogue_data"]
			
			# Store dialogue using chapter and level as nested keys
			if not dialogue_data_map.has(chapter):
				dialogue_data_map[chapter] = {}
			dialogue_data_map[chapter][level] = dialogue_text
	print("All dialogue data has been set.")
	print(dialogue_data_map)

# Retrieve a specific dialogue by chapter and level
func get_dialogue_by_chapter_and_level(chapter: String, level: String) -> String:
	
	if dialogue_data_map.has(chapter) and dialogue_data_map[chapter].has(level):
		return dialogue_data_map[chapter][level]
	return "Dialogue not found for Chapter: " + chapter + " Level: " + level

# Clear all dialogue data
func clear_dialogue_data() -> void:
	dialogue_data_map.clear()
	print("All dialogue data has been cleared.")

# Debug: Print all stored dialogue keys
func print_all_dialogue_keys() -> void:
	print("Stored Dialogue Keys: ", dialogue_data_map.keys())
