extends Control


func _ready() -> void:
	save_game()

func save():
	var save_dict = {
		"coin" : 1000,
		"Music" : 0.5,
		"SFX" : 0.8
	}
	return save_dict

func save_game():
	var save_game = FileAccess.open_encrypted_with_pass("user://savegame.save", FileAccess.WRITE, "Astro")
	var json_string = JSON.stringify(save())
	
	save_game.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var save_game = FileAccess.open_encrypted_with_pass("user://savegame.save", FileAccess.READ, "Astro")
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		print(node_data)

func _on_reset_coin_button_pressed() -> void:
	load_game()
