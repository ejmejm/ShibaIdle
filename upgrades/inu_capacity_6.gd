class_name InuCapacity6
extends BaseUpgrade


func _init():
	id = "inu_capacity_6"
	label = "Upgrade Inu Capacity"
	description = "Increases the maximum number of inus you can have by 200"
	cost = 40000
	max_purchases = 1
	treats_to_unlock = 100000


func _on_purchase_logic():
	player_stats.max_inu_capacity += 200


func _should_display_logic() -> bool:
	return player_stats.upgrade_purchases.has("inu_capacity_5")
