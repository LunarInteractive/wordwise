extends MarginContainer

@onready var margin_container :MarginContainer = $ScrollContainer/MarginContainer
@onready var scroll_container : ScrollContainer = $ScrollContainer
@onready var scroll_bar : HScrollBar = $"../PanelContainer/HScrollBar"
@onready var chapter_labels :Array[Label] = [ $"../PanelContainer/HBoxContainer/Label", $"../PanelContainer/HBoxContainer/Label2", $"../PanelContainer/HBoxContainer/Label3" ]

@onready var total_chapters : int = chapter_labels.size()
@onready var scroll_range : float = scroll_bar.max_value

func _ready():
	scroll_bar.value_changed.connect(_on_scrollbar_value_changed)
	update_chapter_labels()

func _on_scrollbar_value_changed(value):
	print(margin_container.size.x)
	var scroll_offset = int(value / scroll_range * margin_container.size.x)
	print(scroll_offset)
	scroll_container.set_h_scroll(scroll_offset)

	update_chapter_labels()

func update_chapter_labels():
	var active_chapter = int(scroll_bar.value / scroll_range * total_chapters)

	for i in range(total_chapters):
		if i == active_chapter:
			chapter_labels[i].custom_minimum_size = Vector2(200, 50)
		else:
			chapter_labels[i].custom_minimum_size = Vector2(150, 40)
