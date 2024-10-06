class_name InuCapacity1
extends BaseUpgrade


func _init():
	id = "inu_capacity_1"
	label = "Upgrade Inu Capacity"
	description = "Increases the maximum number of inus you can have by 10"
	cost = 100
	max_purchases = 1
	treats_to_unlock = 40


func _on_purchase_logic():
	player_stats.max_inu_capacity += 10
