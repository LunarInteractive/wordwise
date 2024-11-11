extends PanelContainer

signal persenan_berubah(persen_baru)
signal total_error_berubah(total_error_baru)
signal kata_error_berubah(kata_error_baru)

@export var angka_persen:Label
@export var angka_total_error:Label
@export var angka_kata_eror:Label

@export var label_lulus:Label
@export var label_cobalagi:Label

@export var label_desc_error:Control
@export var label_desc_kata:Control

@export var batas_lulus : int = 70

@export var tombol_lanjut : Button

var total_error: int = 100:
	set(angka_total):
		total_error = clampi(angka_total,0,400)
		total_error_berubah.emit(total_error)
		
var kata_error: int = 100:
	set(angka_kata):
		kata_error = clampi(angka_kata,0,500)
		kata_error_berubah.emit(kata_error)

var persenan: int = 100:
	set(nilai):
		persenan = clampi(nilai,0,100)
		persenan_berubah.emit(persenan)
		
	# Called when the node enters the scene tree for the first time.
func _ready():
	
	pesen_angka()
	pesen_angka_kata()
	pesen_angka_total()
	

func _on_persenan_berubah(persen_baru: int):
	reset_gaya()

	var tween = create_tween()
	tween.tween_method(update_teks_skor,0,persen_baru,persen_baru/100.0)
	
	await tween.finished
	
	uji_lulus(persen_baru)
	tampil_total_error()


func _on_button_retry_button_up():
	get_tree().reload_current_scene()
	
func _on_button_home_button_up():
	get_tree().change_scene_to_file("res://UI Asset/Scene/Main_Menu.tscn")
	
func _on_button_lanjut_button_up():
	get_tree().reload_current_scene()
	
func pesen_angka():
	persenan = randi_range(60,100)
	
func pesen_angka_total():
	total_error = randi_range(0,400)

func pesen_angka_kata():
	kata_error = randi_range(0,500)
	

func _on_kata_error_berubah(kata_error_baru):
	angka_kata_eror.text = str(kata_error_baru)
	
func _on_total_error_berubah(total_error_baru):
	angka_total_error.text = str(total_error_baru)
	
func update_teks_skor(nilainyah:int):
	angka_persen.text = str(nilainyah) + "%"

func uji_lulus(nilainyah:int):

	if nilainyah < batas_lulus:
		label_cobalagi.show()
		angka_persen.add_theme_font_size_override("font_size", 100)
		angka_persen.add_theme_color_override("font_color", Color(0.5,0.5,0.5,1.0))
		angka_persen.add_theme_color_override("font_shadow_color", Color.BLACK)
		angka_persen.add_theme_color_override("font_outline_color", Color.BLACK)
	else:
		
		label_lulus.show()
		angka_persen.add_theme_font_size_override("font_size", 100)
		angka_persen.add_theme_color_override("font_color", Color(1.0,0.78,0.22,1.0))
		angka_persen.add_theme_color_override("font_shadow_color", Color.BLACK)
		angka_persen.add_theme_color_override("font_outline_color", Color.BLACK)
		tombol_lanjut.show()
	
	
	
func reset_gaya():
	angka_persen.add_theme_color_override("font_color", Color.WHITE)
	angka_persen.add_theme_color_override("font_shadow_color", Color.BLACK)
	angka_persen.add_theme_color_override("font_outline_color", Color.BLACK)
	angka_persen.add_theme_font_size_override("font_size", 64)
	label_lulus.hide()
	label_cobalagi.hide()
	tombol_lanjut.hide()
	label_desc_error.modulate = Color.TRANSPARENT
	label_desc_kata.modulate = Color.TRANSPARENT
	
func tampil_total_error():
	label_desc_error.modulate = Color.WHITE
	
	var tween = create_tween()
	#tween.tween_method(update_teks,0,total_error,3.0)
	tween.tween_method(update_teks_total,0,total_error,1.0)
	
	await tween.finished
	tampil_total_kata()
	
func tampil_total_kata():
	label_desc_kata.modulate = Color.WHITE
	var tween = create_tween()
	tween.tween_method(update_teks_kata,0,kata_error,1.0)
	
	
func update_teks_total(nilainyah:int):
	angka_total_error.text = str(nilainyah)
	
func update_teks_kata(nilainyah:int):
	angka_kata_eror.text = str(nilainyah)
