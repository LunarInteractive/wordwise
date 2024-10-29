extends Control
@onready var v_box_container = $MarginPanelTask/PanelTask/VBoxContainer/MarginBadanPanel/ScrollContainer/VBoxContainer
var task_res = load("res://UI Asset/Scene/task_item.tscn")

var task_items:  Array[TaskItem] = []
var task_hold: Node
var task_idx: int
var rand1: int
var rand2: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init():
	#task_idx = clampi(task_items.size()-1,0,99)
	task_idx = task_items.size()-1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_button_2_button_up():
	#get_tree().quit()
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
