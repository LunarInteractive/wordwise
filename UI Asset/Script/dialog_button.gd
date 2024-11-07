extends DialogicLayoutLayer
@onready var nine_patch_rect = $MarginContainer/PanelContainer/Button/NinePatchRect
@onready var label = $MarginContainer/PanelContainer/Button/MarginContainer/Label

var tipe_balon : Rect2

signal munculkan_prompt
signal disable_other(pesan1, pesan2)
signal disable_self

@export var button_identity : Button

var is_toggled := false:
	set(toggle_button):
		is_toggled = toggle_button
		disable_other.emit(is_toggled, button_identity)
		
@onready var is_disabled := false:
	set(toggle_disabled):
		is_disabled = toggle_disabled
		disable_self.emit(is_disabled)
		
#func _ready():
	

func _on_button_toggled(toggled_on):
	if toggled_on:
		nine_patch_rect.region_rect = Rect2(1060.0, 10.0, 490.0, 240.0)
		label.add_theme_color_override("font_color", Color.SANDY_BROWN)
		emit_signal("munculkan_prompt", true)
		is_toggled = true
		
	else:
		reset_panel_dialog()
		emit_signal("munculkan_prompt", false)
		is_toggled = false
		


func reset_panel_dialog():
	nine_patch_rect.region_rect = Rect2(2060.0, 10.0, 490.0, 240.0)
	label.add_theme_color_override("font_color", Color.BLACK)
#func set_rect(kodetipe:int):
	#
	#kodetipe = clampi(kodetipe,0,2)
	#print(kodetipe)
	#match kodetipe:
		#0:
			#tipe_balon = Rect2(1060.0, 10.0, 490.0, 240.0)
		#1:
			#tipe_balon = Rect2(2060.0, 10.0, 490.0, 240.0)
		#2:
			#tipe_balon = Rect2(2060.0, 260.0, 490.0, 240.0)
	#
	#nine_patch_rect.region_rect = tipe_balon


func _on_disable_self(pesan1:bool):
	button_identity.disabled = pesan1
	
	if !is_toggled:
		if pesan1:
		
			nine_patch_rect.region_rect = Rect2(1560.0, 10.0, 490.0, 240.0)
			label.add_theme_color_override("font_color", Color.DIM_GRAY)
		else:
			reset_panel_dialog()
	else:
		pass

func isi_label(dialog:String):
	label.text = dialog
