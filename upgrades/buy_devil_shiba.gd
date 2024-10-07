class_name BuyDevilUpgrade
extends BaseUpgrade


var spawner: SpawnManager


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")


func _init():
	id = "buy_devil_shiba"
	label = "Attract Devil Shiba"
	description = "Devil shibas give 20x treats per hit, but beware! They may turn other shibas into ghosts."
	cost = 800
	max_purchases = -1
	treats_to_unlock = 250


func _on_purchase_logic():
	spawner.spawn_inu("devil_shiba")
	player_stats.n_current_inus += 1


func _is_purchasable_logic() -> bool:
	return player_stats.n_current_inus < player_stats.max_inu_capacity
