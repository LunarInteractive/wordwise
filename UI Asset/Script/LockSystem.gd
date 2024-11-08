extends Node

@export var json_file_Path = "res://UI Asset/Script/tes_data_level.json"

# Variabel untuk menyimpan level yang terbuka
var unlocked_level: int = 0
var total_levels: int = 5  # Misalkan total level ada 10

# Array untuk menyimpan referensi ke Button dan TextureRect
var level_buttons: Array = []
var lock_icons: Array = []  # Array untuk menyimpan TextureRect

func _ready():
	# Mengisi array dengan referensi ke Button dan TextureRect
	for i in range(total_levels):
		var button = $".".get_child(i)  # Mengambil button dari node container
		if button is Button:
			level_buttons.append(button)
			var lock_icon = button.get_node("LockIcon")  # Mengambil TextureRect dari button
			if lock_icon is TextureRect:
				lock_icons.append(lock_icon)
	
	load_levels()

func load_levels():
	var file = FileAccess.open(json_file_Path, FileAccess.READ)  # Use FileAccess to open the file
	# Open the JSON file
	if file:
		var json_data = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var parsed_data = json.parse(json_data)
		
		if parsed_data.error == OK:
			unlocked_level = parsed_data.result.level
			print("level yang terbuka", unlocked_level)
			check_levels()
		else:
			print("error parsing JSON: ", parsed_data.error_string)
	else:
		print("error opening file")

func check_levels():
	for i in range(total_levels):
		if i < unlocked_level:
			level_buttons[i].disabled = false  # Aktifkan button
			lock_icons[i].visible = false  # Sembunyikan TextureRect
			print("Level ", i + 1, " terbuka.")
		else:
			level_buttons[i].disabled = true  # Nonaktifkan button
			lock_icons[i].visible = true  # Tampilkan TextureRect
			print("Level ", i + 1, " terkunci.")
