extends Node

@export var json_file_Path = "res://UI Asset/Script/tes_data_level.json"

# Variabel untuk menyimpan level yang terbuka
var unlocked_level: int = 0
var total_levels: int = 5  # Misalkan total level ada 5

# Array untuk menyimpan referensi ke Button dan TextureRect
var level_buttons: Array = []
var lock_icons: Array = []  # Array untuk menyimpan TextureRect

func _ready():
	# Mengisi array dengan referensi ke Button dan TextureRect
	for i in range(get_child_count()):  # Use get_child_count() to avoid out of bounds
		var button = get_child(i)  # Mengambil button dari node container
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
		
		if parsed_data == OK:
			unlocked_level = json.get_data().get("level", 0)
			print("level yang terbuka", unlocked_level)
			check_levels()
		else:
			print("error parsing JSON")
	else:
		print("error opening file")

func check_levels():
	# Ensure we do not go out of bounds
	var max_levels = min(total_levels, level_buttons.size(), lock_icons.size())
	for i in range(max_levels):
		if i < unlocked_level:
			level_buttons[i].disabled = false  # Aktifkan button
			lock_icons[i].visible = false  # Sembunyikan TextureRect
			print("Level ", i + 1, " terbuka.")
		else:
			level_buttons[i].disabled = true  # Nonaktifkan button
			lock_icons[i].visible = true  # Tampilkan TextureRect
			print("Level ", i + 1, " terkunci.")
