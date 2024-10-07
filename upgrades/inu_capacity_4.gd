class_name InuCapacity4
extends BaseUpgrade


func _init():
	id = "inu_capacity_4"
	label = "Upgrade Inu Capacity"
	description = "Increases the maximum number of inus you can have by 100"
	cost = 10000
	max_purchases = 1


func _on_purchase_logic():
	player_stats.max_inu_capacity += 100


func _should_display_logic() -> bool:
	return player_stats.upgrade_purchases.has("inu_capacity_3")
