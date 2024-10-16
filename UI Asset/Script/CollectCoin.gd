extends Control

#btn value
@export var coin_count : int = 10
@export var min_travel_distance : float = 0.5
@export var max_travel_distance : float = 1.5
const COIN = preload("res://UI Asset/Scene/coin.tscn")

#panel value
@export var from_center : bool = true
@export var hover_scale : Vector2 = Vector2(1.1,1.1)
@export var animate_time : float = 0.1

var normal_scale : Vector2

@onready var panel_container: PanelContainer = $"../CoinInfoBox"
@onready var SFX_1: AudioStreamPlayer = $SFX/AudioStreamPlayer
@onready var SFX_2: AudioStreamPlayer = $SFX/AudioStreamPlayer2

@onready var screen_size = get_viewport().get_visible_rect().size


func _on_button_pressed() -> void:
	for i in range(coin_count):
		spawn_coin(i)


func _ready() -> void:
	call_deferred("setup")

func setup() -> void:
	if from_center:
		panel_container.pivot_offset = panel_container.size / 2
	normal_scale = panel_container.scale

func spawn_coin(index : int) -> void:
	var coin = COIN.instantiate()
	add_child(coin)
	coin.z_index += 5
	
	coin.global_position = get_global_mouse_position()
	coin.scale = Vector2(0.3,0.3)
	
	var travel_time = float(randf_range(min_travel_distance, max_travel_distance))
	
	var target_position = Vector2(panel_container.global_position.x, panel_container.global_position.y)
	SFX_1.play()
	animate_coin(coin, target_position, travel_time)


func animate_coin(coin: TextureRect, target_position: Vector2, travel_time: float) -> void:
	var tween = create_tween()
	var random_offset = Vector2(randi_range(-150,150), randi_range(-150,150))
	
	tween.tween_property(coin, "global_position", coin.global_position+random_offset, 0.1)
	tween.tween_property(coin, "global_position", target_position, travel_time).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	tween.connect("finished", _on_tween_completed)
	tween.tween_callback(coin.queue_free)

func _on_tween_completed():
	animate_panel()

func animate_panel() -> void:
	SFX_2.play()
	#var panelTween = create_tween()
	Anima.Node(panel_container).anima_animation("rubber band", animate_time + 0.1).play()
	$"..".Coins_value += 1
	%CoinValues.text = str($"..".Coins_value)
	#panelTween.tween_property(panel_container, "scale", hover_scale, animate_time).set_trans(Tween.TRANS_EXPO)
	#panelTween.tween_property(panel_container, "scale", normal_scale, animate_time).set_trans(Tween.TRANS_EXPO)
