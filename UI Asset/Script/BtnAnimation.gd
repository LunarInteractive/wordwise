class_name AnimationComponent extends Node

@export var from_center : bool = true
@export var hover_scale : Vector2 = Vector2(1,1)
@export var time : float = 0.1
@export var transition_type : Tween.TransitionType

var tween: Tween = null

signal Scene_transition

var target : Control
var default_scale : Vector2


func _ready() -> void:
	target = get_parent()
	
	Scene_transition.connect(kil_tween)
	
	connect_signals()
	call_deferred("setup")


func _process(delta: float) -> void:
	if target == null:
		Scene_transition.emit()
		

func connect_signals() -> void:
	target.mouse_entered.connect(on_hover)
	target.mouse_exited.connect(off_hover)

func setup() -> void:
	if from_center:
		target.pivot_offset = target.size / 2
	default_scale = target.scale


func on_hover() -> void:
	if target != null:
		add_tween("scale", hover_scale, time)
		target.set_modulate(Color(0.466, 0.466, 0.466))


func off_hover() -> void:
	if target != null:
		add_tween("scale", default_scale, time)
		target.set_modulate(Color(1, 1, 1))


func add_tween(property: String, value, seconds: float) -> void:
	if target != null:
		# Kill the previous tween if it exists
		if tween != null:
			tween.kill()

		tween = get_tree().create_tween()
		tween.tween_property(target, property, value, seconds)
	else:
		print("Tweening target is null. Aborting tween.")

func kil_tween():
	tween.kill()
