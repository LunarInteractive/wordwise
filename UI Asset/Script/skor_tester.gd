extends Button

@onready var panel_container_skor = %PanelContainerSkor 

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_button_up():
	panel_container_skor.pesen_angka()
	panel_container_skor.pesen_angka_kata()
	panel_container_skor.pesen_angka_total()
	panel_container_skor.show()
	

func _on_dialogic_signal(argument:String):
		if argument == "level ended":
			_on_button_up()
