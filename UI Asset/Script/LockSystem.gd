extends Node

@export var json_file_Path = "res://UI Asset/Script/tes_data_level.json"
@export var chapter_index: int = 1
# Variabel untuk menyimpan level yang terbuka
var unlocked_level: int = 0
var unlocked_chapter: int = 1  # Variabel untuk menyimpan chapter yang terbuka dari JSON
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
			var data = json.get_data()
			unlocked_chapter = data.get("chapter_id", 1)
			unlocked_level = data.get("level_id", 0)
			print("Chapter terbuka:", unlocked_chapter)
			print("Level yang terbuka:", unlocked_level)
			check_levels()
		else:
			print("Error parsing JSON")
	else:
		print("Error opening file")

func check_levels():
	# Menyesuaikan level yang terbuka berdasarkan chapter dan level
	var max_levels = min(total_levels, level_buttons.size(), lock_icons.size())
	
	if chapter_index < unlocked_chapter:
		# Jika chapter_index lebih kecil dari chapter terbuka, buka semua level di chapter ini
		print("Chapter",  chapter_index, " terbuka (semua level dalam chapter ini terbuka).")
		
		for i in range(max_levels):
			level_buttons[i].disabled = false
			lock_icons[i].visible = false
		
		
	elif chapter_index == unlocked_chapter:
		# Jika chapter_index sama dengan chapter terbuka, buka level berdasarkan unlocked_level
		print("Chapter",  chapter_index, " terbuka (semua level dalam chapter ini terbuka).")
		
		for i in range(max_levels):
			if i < unlocked_level:
				level_buttons[i].disabled = false  # Aktifkan button
				lock_icons[i].visible = false  # Sembunyikan TextureRect
				print("Level ", i + 1, " terbuka.")
			else:
				level_buttons[i].disabled = true  # Nonaktifkan button
				lock_icons[i].visible = true  # Tampilkan TextureRect
				print("Level ", i + 1, " terkunci.")
	else:
		# Jika chapter_index lebih besar dari chapter terbuka, kunci semua level di chapter ini
		for i in range(max_levels):
			level_buttons[i].disabled = true
			lock_icons[i].visible = true
			print("Level ", i + 1, " terkunci (semua level dalam chapter ini terkunci).")
