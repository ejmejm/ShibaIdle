class_name InuCapacity3
extends BaseUpgrade


func _init():
	id = "inu_capacity_3"
	label = "Upgrade Inu Capacity"
	description = "Increases the maximum number of shibas you can have by 50."
	cost = 2000
	max_purchases = 1


func _on_purchase_logic():
	player_stats.max_inu_capacity += 50


func _should_display_logic() -> bool:
	return player_stats.upgrade_purchases.has("inu_capacity_2")
