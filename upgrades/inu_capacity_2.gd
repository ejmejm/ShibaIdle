class_name InuCapacity2
extends BaseUpgrade


func _init():
	id = "inu_capacity_2"
	label = "Upgrade Inu Capacity"
	description = "Increases the maximum number of shibas you can have by 30."
	cost = 500
	max_purchases = 1


func _on_purchase_logic():
	player_stats.max_inu_capacity += 30


func _should_display_logic() -> bool:
	return player_stats.upgrade_purchases.has("inu_capacity_1")
