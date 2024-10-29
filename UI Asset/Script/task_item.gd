class_name TaskItem

extends PanelContainer

@onready var sfx = $AudioStreamPlayer2D
@export var progress: TextureProgressBar
@export var tombolPlay: Button
@export var tombolClaim: Button
var nilai: float = 100


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
	get_node("AnimationPlayer").play("claimed")

func inisialisasi(inputs: float = 50.0):
	progress.value = inputs
	get_node("AnimationPlayer").play("created")
	if progress.value >= 100:
		tombolPlay.visible = false
		tombolClaim.visible = true
	else:
		tombolPlay.visible = true
		tombolClaim.visible = false
