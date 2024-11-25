extends Node

@onready var ClassCode = ""
@onready var kode_level = ""

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

# Clear all dialogue data
func clear_dialogue_data() -> void:
	dialogue_data_map.clear()
	print("All dialogue data has been cleared.")

# Debug: Print all stored dialogue keys
func print_all_dialogue_keys() -> void:
	print("Stored Dialogue Keys: ", dialogue_data_map.keys())
