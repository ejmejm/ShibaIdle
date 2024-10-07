class_name BuyFactoryUpgrade
extends BaseUpgrade

var spawner: SpawnManager


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")


func _init():
	id = "buy_factory"
	label = "Buy Shiba Inu Treat Factory"
	description = "Buy a treat factory for even more treats!"
	cost = 2000
	max_purchases = 1

func _on_ready():
	pass

func _on_purchase_logic():
	spawner.spawn_building("factory")
	#player_stats.n_current_buildings += 1 currently does nothing until player stats updated

	
func _should_display_logic() -> bool:
	return player_stats.n_treats >= cost and player_stats.n_current_inus >= 5 #change to highest treats after Edan commit add


func _is_purchasable_logic() -> bool:
	return player_stats.n_treats >= cost and player_stats.max_inu_capacity >= 20
