extends Control
@onready var v_box_container = %VBoxContainer
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
	task_items[task_idx].connect("item_claimed", delete_task)
	
	v_box_container.add_child(task_items[task_idx])
	
	
func delete_task(item_task : TaskItem):
	var cari := task_items.find(item_task)
	
	for n in range(cari,task_items.size()-1):
		var prev_y = task_items[n].position.y
		if n+1 < task_items.size():
			var tween = create_tween()
			tween.tween_property(task_items[n+1], "position:y", prev_y,0.5)
		#if n+1 == cari:
			#await tween.finished
			#if item_task:
				#task_items.remove_at(cari)
				#print(item_task)
				#item_task.queue_free()
				#print(item_task)
				#task_idx -= 1
	task_items.remove_at(cari)
	print(item_task)
	task_idx -= 1
	
