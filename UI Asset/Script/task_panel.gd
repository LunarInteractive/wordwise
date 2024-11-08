extends Control
@onready var v_box_container = %VBoxContainer
#@onready var close_button_2: TextureButton = $MarginPanelTask/PanelContainer/VBoxContainer/HeaderPanel/MarginHeader/MarginClose/CloseButton2 as TextureButton

var task_res = load("res://UI Asset/Scene/task_item.tscn")

var task_items:  Array[TaskItem] = []
var task_hold: Node
var task_idx: int
var rand1: int
var rand2: float

# Called when the node enters the scene tree for the first time.
func _ready():
	#close_button_2.button_down.connect(_on_button_2_button_up)
	pass # Replace with function body.

func _init():
	#task_idx = clampi(task_items.size()-1,0,99)
	task_idx = task_items.size()-1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_button_2_button_up():
	#get_tree().change_scene_to_file("res://Objects/Environtment/UI/menu.tscn")
	queue_free()
	
func add_task():
	task_idx +=1
	#task_hold = task_res.instantiate()
	rand1 = randi_range(0,1)
	
	match rand1:
		1:
			rand2 = 100.0
		0:
			rand2 = randf_range(0.0,99.99)
	
	#task_hold = TaskItem.new(rand2)
	task_hold = task_res.instantiate()
	task_hold.inisialisasi(rand2)
	task_items.insert(task_idx, task_hold)
	v_box_container.add_child(task_items[task_idx])
