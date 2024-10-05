extends Node2D


@export var player_stats: PlayerStats
@export var treat_give_count: int = 1


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("PrimaryClick"):
		player_stats.n_treats += treat_give_count
