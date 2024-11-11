class_name TaskItem

extends PanelContainer

@onready var sfx = $AudioStreamPlayer2D
@export var progress: TextureProgressBar
@export var tombolPlay: Button
@export var tombolClaim: Button
var nilai: float = 100

signal item_claimed(item_task)

#func _init(nilai:float = 100.0):
#func _ready():
	#print("readydulu")
	#progress.value = nilai
	#inisialisasi()

#func _init(inputz: float = 50.0):
#
	#nilai = inputz
	
	

func _on_tombol_claim_button_up():
	sfx.play()
	#item_claimed.emit(self)
	get_node("AnimationPlayer").play("claimed")
	tombolClaim.get_node("LabelClaim").add_theme_color_override("font_color", Color.WHITE)

func inisialisasi(inputs: float = 50.0):
	progress.value = inputs
	get_node("AnimationPlayer").play("created")
	if progress.value >= 100:
		tombolPlay.visible = false
		tombolClaim.visible = true
	else:
		tombolPlay.visible = true
		tombolClaim.visible = false



func _on_tombol_claim_button_down():
	tombolClaim.get_node("LabelClaim").add_theme_color_override("font_color", Color.DIM_GRAY)


func _on_tombol_play_button_down():
	tombolPlay.get_node("LabelPlay").add_theme_color_override("font_color", Color.DIM_GRAY)
	
	


func _on_tombol_play_button_up():
	tombolPlay.get_node("LabelPlay").add_theme_color_override("font_color", Color.WHITE)

func _on_tombol_play_pressed():
	tombolPlay.get_node("LabelPlay").add_theme_color_override("font_color", Color.WHITE)

func _on_tombol_claim_pressed():
	tombolClaim.get_node("LabelClaim").add_theme_color_override("font_color", Color.WHITE)

func _on_tombol_play_mouse_exited():
	tombolPlay.get_node("LabelPlay").add_theme_color_override("font_color", Color.WHITE)
	
func _on_tombol_claim_mouse_exited():
	tombolClaim.get_node("LabelClaim").add_theme_color_override("font_color", Color.WHITE)
	



func _on_tombol_claim_mouse_entered():
	if tombolClaim.button_pressed:
		tombolClaim.get_node("LabelClaim").add_theme_color_override("font_color", Color.DIM_GRAY)
		
		


func _on_tombol_play_mouse_entered():
	if tombolPlay.button_pressed:
		tombolPlay.get_node("LabelPlay").add_theme_color_override("font_color", Color.DIM_GRAY)
		
func signal_to_move():
	item_claimed.emit(self)
