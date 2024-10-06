extends Label


@onready var player_stats: PlayerStats = %PlayerStats


func _on_ready() -> void:
	text = str(player_stats.max_inu_capacity)
	

func _on_player_stats_max_inu_count_update(val: int) -> void:
	text = str(val)
