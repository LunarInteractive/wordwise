extends ScrollContainer

@export var tebal:int = 60

@onready var scrollbar:= get_v_scroll_bar()
# Called when the node enters the scene tree for the first time.
func _ready():
	scrollbar.custom_minimum_size.x = tebal
	scrollbar.set_anchors_and_offsets_preset(PRESET_CENTER, PRESET_MODE_KEEP_WIDTH, 0)
