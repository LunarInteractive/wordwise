extends Button

@onready var panel_container_skor = $"../PanelContainerSkor"



func _on_button_up():
	panel_container_skor.pesen_angka()
	panel_container_skor.pesen_angka_kata()
	panel_container_skor.pesen_angka_total()
	panel_container_skor.show()
	
