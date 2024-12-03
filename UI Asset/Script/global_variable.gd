extends Node

var dialogue_data_map = {}
var dialogue_label : String = ""

# Store only the "dialogue_data" field in the map
func set_all_dialogue_data(dialogues: Array) -> void:
	dialogue_data_map.clear()
	for dialogue in dialogues:
		if dialogue.has("dialogue_data"):
			var dialogue_text = dialogue["dialogue_data"]
			dialogue_data_map[dialogue_text] = dialogue_text  # Store just the dialogue text
	print("All dialogue data has been set.")

# Get a specific dialogue by searching in the keys
# Return `Variant` to allow for null or the dialogue text
func get_dialogue_by_key(search_text: String) -> Variant:
	for key in dialogue_data_map.keys():
		if key.find(search_text) != -1:  # Check if search_text is a substring of the key
			return dialogue_data_map[key]
	return null
