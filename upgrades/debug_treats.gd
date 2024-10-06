class_name DebugTreats
extends BaseUpgrade


func _init():
	id = "debug_treats"
	label = "Give Treats"
	description = "Give free treats for debugging"
	cost = 0
	max_purchases = -1


func _on_purchase_logic():
	player_stats.n_treats += 100000
