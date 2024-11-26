extends Control


#Mengatur perilaku objek Dialog Button tunggal
@onready var nine_patch_rect = $MarginContainer/PanelContainer/Button/NinePatchRect
@onready var label = $MarginContainer/PanelContainer/Button/MarginContainer/Label

var max_width : Array[float]
@export var max_height : float = 105.0
@export var margin_x : float = 100.0
@export var margin_y : float = 150.0
var tipe_balon : Rect2

#signal munculkan_prompt
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
		
func _ready():
	reset_panel_dialog()
	var margin_ki = button_identity.get_node("MarginContainer").get_theme_constant("margin_left")
	var margin_at = button_identity.get_node("MarginContainer").get_theme_constant("margin_top")
	var margin_ka = button_identity.get_node("MarginContainer").get_theme_constant("margin_right")
	var margin_ba = button_identity.get_node("MarginContainer").get_theme_constant("margin_bottom")
	max_width = [size.x * 0.5,size.x * 0.75, size.x]
	margin_x = margin_ki + margin_ka
	margin_y = margin_at + margin_ba

func _on_button_toggled(toggled_on):
	if toggled_on:
		nine_patch_rect.region_rect = Rect2(1060.0, 10.0, 490.0, 240.0)
		label.add_theme_color_override("font_color", Color.SANDY_BROWN)
		#emit_signal("munculkan_prompt", true)
		is_toggled = true
		
	else:
		reset_panel_dialog()
		#emit_signal("munculkan_prompt", false)
		is_toggled = false
		

#mengembalikan warna teks dan balon dialog
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

#Fungsi dipanggil dari luar untuk mengisi teks dialog
func isi_label(dialog:String):
	label.text = dialog
	#_fit_width()
	
	await get_tree().process_frame
	#print(label.size)
	
	if label.size.y > max_height:
		var indeks
		if label.size.y <= max_height*2:
			indeks = 1
		elif label.size.y > max_height*2:
			indeks = 2
			
		label.set_custom_minimum_size(Vector2(max_width[indeks]-margin_x,max_height))
		button_identity.set_custom_minimum_size(Vector2(max_width[indeks],max_height+margin_y))	
	
	#for i in max_width:	
		#if label.size.x < i-margin_x:
			#label.size.x = i-margin_x
			#label.set_custom_minimum_size(Vector2(i-margin_x,max_height))
			#await get_tree().process_frame
			#if label.size.y > max_height:
				#continue
			#else:
				#break
		#elif max_width.find(i) == max_width.size()-1:
			#label.size.x = i-margin_x
			#label.set_custom_minimum_size(Vector2(i-margin_x,max_height))
			#await get_tree().process_frame
		#else:
			#continue
			##button_identity.set_custom_minimum_size(Vector2(i,max_height+margin_y))
				
	#button_identity.set_custom_minimum_size(Vector2(label.size.x+margin_x,max_height+margin_y))	
	#print(label.size)	
	


#func _on_label_resized():
	#if label:
		#set_block_signals(true)
		#print(label)
		##
#func _fit_width() -> void:
	## block the signals so "finished" does not trigger this function again
	#label.set_block_signals(true)
	#var original_autowrap = label.autowrap_mode
	## save the position
	##var tmp = global_position
	## move it out of the way to avoid flashing
	##global_position.x = -100000
	## disable autowrap
	#label.autowrap_mode = TextServer.AUTOWRAP_OFF
	## make it 0, 0
	#label.size = Vector2.ZERO
	## wait one frame
	#await get_tree().process_frame
	## now we have the size with no autowrap
	## if the width is bigger than max width clamp it
	#var w = clampf(label.size.x, 0, max_width[4])
	#var h = label.size.y
	## restore the autowrap mode
	#label.autowrap_mode = original_autowrap
	## set the maximum size we got
	#label.size.x = w
	## wait one frame for the text to resize
	#await get_tree().process_frame
	## if the height is bigger than before we have multiple lines
	## and we may need to make the width smaller
	#if label.size.y > h:
		## save the height
		#h = label.size.y
		## keep lowering the width until the height changes
		#while true:
			## lower the width a bit
			#label.size.x -= 10
			## wait one frame
			#await get_tree().process_frame
			## check if the height changed
			#if not is_equal_approx(label.size.y, h):
				## if it changed we made the textbox too small
				## restore the width and break the while loop
				#label.size.x += 10
				#break
	## wait one frame
	#await get_tree().process_frame
	## restore the height
	#label.size.y = h
	## restore the original position
	##global_position = tmp
	## unblock the signals
	#label.set_block_signals(false)
