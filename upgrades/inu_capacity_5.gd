class_name InuCapacity5
extends BaseUpgrade


func _init():
	id = "inu_capacity_5"
	label = "Upgrade Inu Capacity"
	description = "Increases the maximum number of inus you can have by 200"
	cost = 20000
	max_purchases = 1


func _on_purchase_logic():
	player_stats.max_inu_capacity += 200


func _should_display_logic() -> bool:
	return player_stats.upgrade_purchases.has("inu_capacity_4")
