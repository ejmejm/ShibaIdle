class_name BonusTreat
extends Area2D


@export var value: int = 20


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("PrimaryClick"):
		var player_stats: PlayerStats = get_node("/root/Root/GameManager/PlayerStats")
		player_stats.n_treats += value
		get_node("/root/Root/TreatSFX").play()
		get_parent().remove_child(self)
		queue_free()
