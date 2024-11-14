extends Control


@export var panel_prompt : PanelContainer
@export var v_box_container : VBoxContainer
#@onready var v_box_container = $"../../../Dialog_Panel/HBoxContainer/AwnserPanel/ScrollContainer/VBoxContainer"
var dialog_res = load("res://UI Asset/Scene/dialog_item.tscn")
#var dialog_teks_res = load("res://UI Asset/Script/tes_data.tres")
#@export var kode_soal:= 0
#var json = JSON.new()

var coba_ambil : Dictionary
var grup_aktif : String
var dialog_items:  Array[Control] = []
var dialog_hold: Node
var dialog_idx: int = -1

@onready var bank_teks:Array[Control] = []
@export var npc_panel : Node
#@export var dialog_panel : Node
@export var path : DialogicTimeline
@onready var ngeteh = Dialogic.preload_timeline(path)

#sinyal untuk mengabari ada choices baru yang di load (setelah load timeline/level?)
signal lapor_atasan
#const CHARACTER = preload("res://UI Asset/Dialog/character.dch")
#const CHARACTER_2 = preload("res://UI Asset/Dialog/character2.dch")

func _ready():
	coba_ambil = read_json_file("res://UI Asset/Script/tes_data.json")
	
	grup_aktif = coba_ambil.keys()[randi_range(0,2)]
	

func tiap_button(kode:int):
	
	var kode_soal:int = kode
	#if Dialogic.current_timeline != null:
		#return
	#print(kode)
	#ngeteh.register_character(CHARACTER,npc_panel)
	#ngeteh.register_character(CHARACTER_2,dialog_panel)
	
	
	
	var yea := 7 * kode_soal
	reset_dialog()
	#if ngeteh
	npc_panel.text = ngeteh.events[yea].text
	for n in range(0,3):
	#if dialog_items.size() == 0:
		#
		#
	#elif dialog_items.size() > 0 and dialog_items.size() <= 4:
		
		#dialog_idx +=1
		dialog_hold = dialog_res.instantiate()
		#dialog_hold.inisialisasi(rand2)
		dialog_items.insert(n, dialog_hold)
		v_box_container.add_child(dialog_items[n])
		print(dialog_items[n])
		#dialog_items[dialog_idx].set_rect(dialog_idx)
		#dialog_items[dialog_idx].isi_label(coba_ambil[grup_aktif].values()[dialog_idx])
		var event_idx := yea + (n*2)+1
		
		dialog_items[n].isi_label(ngeteh.events[event_idx].text)
		dialog_items[n].connect("munculkan_prompt", showkan)
		dialog_items[n].connect("disable_other", disablekan)
		#dialog_items[dialog_idx].disable_other.connect(disablekan.bind([toggle_button, button_identity]))
		#print(dialog_items[dialog_idx].button_identity)
	#print(dialog_items.size())
			
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
func reset_dialog():
	#print(dialog_items.size())
	if dialog_items.size() !=0:
		
		for i in dialog_items:
			print(i)
			i.queue_free()

		dialog_items = []


func _on_tes_dialog_1_button_up(extra_arg_0):
	tiap_button(extra_arg_0) # Replace with function body.


func _on_tes_dialog_2_button_up(extra_arg_0):
	tiap_button(extra_arg_0) # Replace with function body.


func _on_tes_dialog_3_button_up(extra_arg_0):
	tiap_button(extra_arg_0) # Replace with function body.


func _on_tes_dialogic_button_up():
	var dialogic = Dialogic.start(path) # Replace with function body.
	#print("klik")
	lapor_atasan.emit(true)


func _on_button_pressed() -> void:
	var dialogic = Dialogic.start(path) # Replace with function body.
	#print("klik")
	lapor_atasan.emit(true)
