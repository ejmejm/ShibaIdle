class_name CollidableTreat
extends Node2D


@export var player_stats: PlayerStats
@export var treat_give_count: int = 1
@onready var treat_sprite: Sprite2D = $DogTreatSprite
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

var waiting_for_release: bool = false
var treat_position: Vector2
var shadow_position: Vector2


func _ready() -> void:
	treat_position = $DogTreatSprite.position
	shadow_position = $DogTreatShadow.position


func _click_bone():
	waiting_for_release = true
	treat_sprite.position = shadow_position


func _release_bone():
	waiting_for_release = false
	treat_sprite.position = treat_position
	player_stats.n_treats += treat_give_count
	audio_player.play()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("PrimaryClick"):
		_click_bone()
	elif waiting_for_release and event.is_action_released("PrimaryClick"):
		_release_bone()


func _on_area_2d_mouse_exited() -> void:
	if waiting_for_release:
		_release_bone()
