class_name SpaceShipUpgrade
extends BaseUpgrade


func _init():
	id = "buy_space_ship"
	label = "BUY SPACESHIP"
	description = "Buy a spaceship to finish the game."
	cost = 100000
	max_purchases = 1
	treats_to_unlock = 10000


func _on_purchase_logic():
	pass
