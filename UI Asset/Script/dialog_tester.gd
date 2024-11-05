extends Button


@onready var panel_prompt = $"../../../Dialog_Panel/HBoxContainer/AwnserPanel/VBoxContainer/PanelPrompt"
@onready var v_box_container = $"../../../Dialog_Panel/HBoxContainer/AwnserPanel/VBoxContainer/ScrollContainer/VBoxContainer"
#@onready var v_box_container = $"../../../Dialog_Panel/HBoxContainer/AwnserPanel/ScrollContainer/VBoxContainer"
var dialog_res = load("res://UI Asset/Scene/dialog_item.tscn")
#var dialog_teks_res = load("res://UI Asset/Script/tes_data.tres")

#var json = JSON.new()

var coba_ambil : Dictionary
var grup_aktif : String
var dialog_items:  Array[Control] = []
var dialog_hold: Node
var dialog_idx: int = -1

@onready var bank_teks:Array[Control] = []


func _ready():
	coba_ambil = read_json_file("res://UI Asset/Script/tes_data.json")
	
	grup_aktif = coba_ambil.keys()[randi_range(0,2)]
	

func _on_button_up():
	if dialog_items.size() < 3:
		dialog_idx +=1
		dialog_hold = dialog_res.instantiate()
		#dialog_hold.inisialisasi(rand2)
		dialog_items.insert(dialog_idx, dialog_hold)
		v_box_container.add_child(dialog_items[dialog_idx])
		#dialog_items[dialog_idx].set_rect(dialog_idx)
		dialog_items[dialog_idx].isi_label(coba_ambil[grup_aktif].values()[dialog_idx])
		dialog_items[dialog_idx].connect("munculkan_prompt", showkan)
		dialog_items[dialog_idx].connect("disable_other", disablekan)
		#dialog_items[dialog_idx].disable_other.connect(disablekan.bind([toggle_button, button_identity]))
		#print(dialog_items[dialog_idx].button_identity)
			
func showkan(pesan: bool):

	if pesan:
		panel_prompt.show()
	else:
		panel_prompt.hide()
	
	
	#call_json()
		
func disablekan(pesan1: bool, pesan2:Node):
	for button_dialog in dialog_items:
		if !pesan1:
			button_dialog.is_disabled = false
		else:
			button_dialog.is_disabled = true
			if button_dialog.button_identity == pesan2:
				button_dialog.is_disabled = false

func read_json_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	var content_as_text = file.get_as_text()
	
	var content_as_dictionary = parse_json(content_as_text)
	return content_as_dictionary

func parse_json(teks_isi:String):
	return JSON.parse_string(teks_isi)
				
#func call_json():
	#var error = json.parse(dialog_teks_res)
	#if error == OK:
		#var data_received = json.data
		#if typeof(data_received) == TYPE_ARRAY:
			#print(data_received) # Prints array
		#else:
			#print("Unexpected data")
	#else:
		#print("JSON Parse Error: ", json.get_error_message(), " in ", dialog_teks_res, " at line ", json.get_error_line())
