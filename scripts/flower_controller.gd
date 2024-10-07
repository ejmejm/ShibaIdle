class_name FlowerInuController
extends InuController


@onready var stats: InuStats = %InuStats
var treat_resource: Resource = preload("res://scenes/bonus_treat.tscn")


func _on_timer_timeout() -> void:
	var treat: BonusTreat = treat_resource.instantiate()
	treat.value *= stats.treat_power
	treat.global_position = global_position - Vector2(576, 324)
	# Randomize the treat's rotation
	treat.rotation = randf_range(0, 2 * PI)
	var treat_container = get_node("/root/Root/TreatsContainer")
	treat_container.add_child(treat)
	
	
