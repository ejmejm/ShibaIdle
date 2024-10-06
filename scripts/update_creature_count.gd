extends Label


func _on_player_stats_current_inu_count_update(val: int) -> void:
	text = str(val)
